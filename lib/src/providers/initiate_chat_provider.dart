import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../account.dart';
import '../states/app_state.dart';
import '../storage_provider.dart';
import 'qiscus_sdk_provider.dart';
import 'states_provider.dart';

final initiateChatUrlProvider = Provider((ref) {
  var baseUrl = ref.watch(baseUrlProvider);

  return Uri.parse('$baseUrl/api/v2/qiscus/initiate_chat');
}, name: 'initiateChatUrlProvider');

final initiateChatProvider = FutureProvider((ref) async {
  var qiscus = await ref.watch(qiscusProvider.future);
  var userId = ref.watch(userIdProvider);
  var displayName = ref.watch(displayNameProvider);
  var avatarUrl = ref.watch(userAvatarUrl);
  var userProperties = ref.watch(userPropertiesProvider);
  var channelId = ref.watch(channelIdConfigProvider);
  var sdkUserExtras = ref.watch(sdkUserExtrasProvider);
  var url = ref.watch(initiateChatUrlProvider);
  var deviceId = ref.watch(deviceIdConfigProvider);
  var deviceIdDevelopmentMode = ref.watch(deviceIdDevelopmentModeProvider);

  var appState = ref.watch(appStateProvider);
  if (appState.maybeMap(orElse: () => false, ready: (_) => true)) {
    return 0;
  }

  var nonce = await qiscus.getJWTNonce();
  var data = <String, dynamic>{
    'app_id': qiscus.appId,
    'user_id': userId,
    'nonce': nonce,
  };

  if (displayName != null) data['name'] = displayName;
  if (avatarUrl != null) data['avatar'] = avatarUrl;
  if (sdkUserExtras != null) data['sdk_user_extras'] = sdkUserExtras;
  if (userProperties != null) {
    data['user_properties'] = jsonEncode(userProperties);
  }
  if (channelId != null) data['channel_id'] = channelId;

  var resp = await http.post(url, body: data);
  var json = jsonDecode(resp.body);
  var identityToken = json['data']['identity_token'] as String;
  // var isSessional = json['data']['is_sessional'] as bool;
  var room = json['data']['customer_room'];

  var roomId = int.parse(room['room_id']);
  var isResolved = room['is_resolved'] as bool?;
  var isSessional = room['is_sessional'] as bool?;

  Map<String, Object?>? properties;
  try {
    var prop = (room['extras']['user_properties'] as List)
        .cast<Map<String, Object?>>();

    if (prop.isNotEmpty) properties ??= {};
    for (var item in prop) {
      if (item['key'] != null) {
        properties?['${item['key']}'] = item['value'];
      }
    }
  } catch (_) {}

  ref.read(isResolvedProvider.notifier).state = isResolved ?? false;
  ref.read(isSessionalProvider.notifier).state = isSessional ?? false;

  var user = QAccount.merge(
    await qiscus.setUserWithIdentityToken(token: identityToken),
    properties,
  );

  ref.read(localUserDataProvider.notifier).setData(QLocalUserData(
        appId: qiscus.appId,
        roomId: roomId,
        token: qiscus.token,
        account: user,
      ));

  if (deviceId != null) {
    try {
      await qiscus.registerDeviceToken(
        token: deviceId,
        isDevelopment: deviceIdDevelopmentMode,
      );
    } catch (_) {}
  }

  ref.read(appStateProvider.notifier).state = AppState.ready(
    roomId: roomId,
    account: user,
  );

  return 0;
}, name: 'initiateChatProvider');
