part of 'provider.dart';

@riverpod
Uri initiateChatUrl(InitiateChatUrlRef ref) {
  var baseUrl = ref.watch(baseUrlProvider);

  return Uri.parse('$baseUrl/api/v2/qiscus/initiate_chat');
}

typedef InitiateChatFunction = Future<QChatRoom> Function();

@riverpod
Future<InitiateChatFunction> initiateChat(InitiateChatRef ref) async {
  var qiscus = await ref.watch(qiscusProvider.future);
  var userId = ref.watch(userIdProvider);
  var displayName = ref.watch(displayNameProvider);
  var avatarUrl = ref.watch(avatarUrlProvider);
  var userProperties = ref.watch(userPropertiesProvider);
  var channelId = ref.watch(channelIdConfigProvider);
  var sdkUserExtras = ref.watch(sdkUserExtrasProvider);
  var initiateUrl = ref.watch(initiateChatUrlProvider);
  var deviceId = ref.watch(deviceIdConfigProvider);
  var deviceIdDevelopment = ref.watch(deviceIdDevelopmentModeProvider);
  var userExtras = ref.watch(userExtrasProvider);

  var storage = ref.watch(encSharedPreferenceProvider);

  return () async {
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
    if (userExtras != null) data['extras'] = jsonEncode(userExtras);
    if (channelId != null) data['channel_id'] = channelId;

    var secureSession = await storage
        .read(key: StorageKey.secureSession)
        .then((v) => v == null ? null : jsonDecode(v) as Map<String, dynamic>)
        .then((v) => v == null ? null : SecureSession.fromJson(v));

    if (secureSession != null &&
        secureSession.appId == qiscus.appId &&
        secureSession.channelId == channelId &&
        secureSession.userId == userId) {
      data['session_id'] = secureSession.id;
    }

    var json = await http
        .post(initiateUrl, body: data)
        .then((r) => jsonDecode(r.body) as Map<String, dynamic>);

    var identityToken = json['data']['identity_token'] as String;
    var roomJson = json['data']['customer_room'] as Map<String, dynamic>;

    var roomId = int.parse(roomJson['room_id']);
    var isResolved = roomJson['is_resolved'] as bool?;
    var isSessional = roomJson['is_sessional'] as bool?;

    Map<String, dynamic>? properties;
    try {
      var prop = (roomJson['extras']['user_properties'] as List)
          .cast<Map<String, dynamic>>();

      if (prop.isNotEmpty) properties ??= {};
      for (var item in prop) {
        if (item['key'] != null) {
          properties?['${item['key']}'] = item['value'];
        }
      }
    } catch (_) {}

    final user = QAccount.merge(
      await qiscus.setUserWithIdentityToken(token: identityToken),
      properties,
    );

    if (deviceId != null) {
      qiscus
          .registerDeviceToken(
            token: deviceId,
            isDevelopment: deviceIdDevelopment,
          )
          .ignore();
    }

    QChatRoomWithMessages roomData;
    try {
      roomData = await getChatRoomWithMessages(qiscus: qiscus, roomId: roomId);
    } catch (e) {
      roomData = QChatRoomWithMessages(QChatRoom(id: 1, uniqueId: '1'), []);
      print('error while getting room data: $e');
    }
    var room = roomData.room;
    var messages = roomData.messages;

    // Security Enchancements
    var isSecure = json['data']['is_secure'] as bool? ?? false;
    var sessionId = roomJson['session_id'] as String?;
    channelId = (roomJson['channel_id'] as int).toString();
    if (isSecure == false) {
      storage.delete(key: StorageKey.secureSession).ignore();
    }
    if (isSecure && sessionId != null) {
      var userId = user.id.split('_')[1];
      // Save session data to local
      var data = SecureSession(
        appId: qiscus.appId!,
        channelId: channelId!,
        userId: userId,
        id: sessionId,
      );
      ref.read(secureSessionProvider.notifier).state = data;
      await storage.write(
        key: StorageKey.secureSession,
        value: jsonEncode(data.toJson()),
      );
    }

    // Update providers
    ref.read(isResolvedProvider.notifier).state = isResolved ?? false;
    ref.read(isSessionalProvider.notifier).state = isSessional ?? false;
    ref.read(appStateProvider.notifier).state = AppState.ready(
      roomId: roomId,
      account: user,
    );
    ref.read(roomStateProvider.notifier).state =
        QChatRoomWithMessages(room, messages);

    return room;
  };
}

Future<QChatRoomWithMessages> getChatRoomWithMessages({
  required QiscusSDK qiscus,
  required int roomId,
}) {
  return qiscus.getChatRoomWithMessages(roomId: roomId).timeout(
      const Duration(seconds: 2),
      onTimeout: () => getChatRoomWithMessages(qiscus: qiscus, roomId: roomId));
}
