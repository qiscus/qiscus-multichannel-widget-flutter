import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' hide QAccount;

import '../account.dart';
import '../states/app_state.dart';
import 'avatar_url_provider.dart';
import 'qiscus_sdk_provider.dart';
import 'room_provider.dart';
import 'states_provider.dart';

final initiateChatUrlProvider = Provider((ref) {
  var baseUrl = ref.watch(baseUrlProvider);

  return Uri.parse('$baseUrl/api/v2/qiscus/initiate_chat');
}, name: 'initiateChatUrlProvider');

class InitiateChatResponse {
  const InitiateChatResponse({
    required this.account,
    required this.room,
    required this.messages,
    required this.isResolved,
    required this.isSessional,
  });

  final QAccount account;
  final QChatRoom room;
  final List<QMessage> messages;
  final bool isResolved;
  final bool isSessional;
}

Future<InitiateChatResponse> initiateChat({
  required QiscusSDK qiscus,
  String? userId,
  String? displayName,
  String? avatarUrl,
  Map<String, dynamic>? userProperties,
  String? channelId,
  Map<String, dynamic>? sdkUserExtras,
  required Uri initiateUrl,
  String? deviceId,
  bool deviceIdDevelopmentMode = false,
  AppState appState = const AppState.initial(),
}) async {
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

  var resp = await http.post(initiateUrl, body: data);
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

  var user = QAccount.merge(
    await qiscus.setUserWithIdentityToken(token: identityToken),
    properties,
  );

  if (deviceId != null) {
    try {
      await qiscus.registerDeviceToken(
        token: deviceId,
        isDevelopment: deviceIdDevelopmentMode,
      );
    } catch (_) {}
  }

  var roomData = await getChatRoomWithMessages(qiscus: qiscus, roomId: roomId);

  return InitiateChatResponse(
    account: user,
    room: roomData.room,
    messages: roomData.messages,
    isResolved: isResolved ?? false,
    isSessional: isSessional ?? false,
  );
}

Future<QChatRoomWithMessages> getChatRoomWithMessages({
  required QiscusSDK qiscus,
  required int roomId,
}) {
  return qiscus.getChatRoomWithMessages(roomId: roomId).timeout(
      const Duration(seconds: 2),
      onTimeout: () => getChatRoomWithMessages(qiscus: qiscus, roomId: roomId));
}

Future<void> initiateChatF(Ref ref) async {
  var data = await initiateChat(
    qiscus: await ref.read(qiscusProvider.future),
    initiateUrl: ref.read(initiateChatUrlProvider),
    userId: ref.read(userIdProvider),
    displayName: ref.read(displayNameProvider),
    avatarUrl: ref.read(avatarUrlProvider),
    channelId: ref.read(channelIdConfigProvider),
    userProperties: ref.read(userPropertiesProvider),
    sdkUserExtras: ref.read(sdkUserExtrasProvider),
    deviceId: ref.read(deviceIdConfigProvider),
    deviceIdDevelopmentMode: ref.read(deviceIdDevelopmentModeProvider),
    appState: ref.read(appStateProvider),
  );

  ref.read(isResolvedProvider.notifier).state = data.isResolved;
  ref.read(isSessionalProvider.notifier).state = data.isSessional;

  ref.read(appStateProvider.notifier).state = AppState.ready(
    roomId: data.room.id,
    account: data.account,
  );

  ref.read(roomStateProvider.notifier).state = QChatRoomWithMessages(
    data.room,
    data.messages,
  );
}

final initiateChatProvider = Provider.autoDispose((ref) {
  return () => initiateChatF(ref);
});

final _initiateChatProvider = FutureProvider((ref) async {
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
