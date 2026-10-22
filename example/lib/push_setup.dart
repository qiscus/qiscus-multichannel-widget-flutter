// Push notification setup for the sample, with `[QPN]` diagnostic logs.
//
// Correct order on iOS: request permission -> wait for the APNs token -> get the
// FCM token -> setDeviceId() -> initiateChat(). If getToken() runs before the
// APNs token exists, iOS throws `apns-token-not-set` and the device is never
// registered.
//
// Tokens are never logged in full (prefix + length only), and notification
// content is not logged (data keys + whether title/body exist only).
import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

bool _listening = false;

void _log(String msg) {
  var now = DateTime.now().toIso8601String().substring(11, 23);
  var line = '[QPN] $now $msg';
  debugPrint(line);
  developer.log(line, name: 'QPN');
}

String _short(String? token) =>
    token == null ? 'null' : '${token.substring(0, 8)}…(${token.length})';

/// Requests permission and returns the FCM token, or null when permission is
/// denied or no APNs token becomes available.
Future<String?> preparePushToken() async {
  var fcm = FirebaseMessaging.instance;
  _listenMessages();

  var settings = await fcm.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  _log('permission ${settings.authorizationStatus.name}');
  if (settings.authorizationStatus == AuthorizationStatus.denied) {
    return null;
  }

  if (Platform.isIOS) {
    String? apns;
    for (var i = 0; i < 120 && apns == null; i++) {
      apns = await fcm.getAPNSToken();
      if (apns == null) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
    }
    _log('apns token ${_short(apns)}');
    if (apns == null) {
      _log('apns token missing: check the Push Notifications capability '
          '(aps-environment) and the provisioning profile');
      return null;
    }
  }

  try {
    var token = await fcm.getToken();
    _log('fcm token ${_short(token)}');
    return token;
  } catch (e) {
    _log('fcm getToken ERROR $e');
    return null;
  }
}

void _listenMessages() {
  if (_listening) return;
  _listening = true;

  FirebaseMessaging.instance.onTokenRefresh
      .listen((t) => _log('fcm token refresh ${_short(t)}'));
  FirebaseMessaging.onMessage.listen((m) => _log('foreground ${_describe(m)}'));
  FirebaseMessaging.onMessageOpenedApp
      .listen((m) => _log('opened-from-background ${_describe(m)}'));
  FirebaseMessaging.instance.getInitialMessage().then((m) {
    if (m != null) _log('opened-from-terminated ${_describe(m)}');
  });
}

String _describe(RemoteMessage m) {
  var n = m.notification;
  return 'id=${m.messageId} sent=${m.sentTime?.toIso8601String()} '
      'title=${n?.title != null} body=${n?.body != null} '
      'dataKeys=${m.data.keys.toList()}';
}
