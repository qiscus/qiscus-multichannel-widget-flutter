part of 'provider.dart';

@riverpod
Uri initiateChatUrl(InitiateChatUrlRef ref) {
  var baseUrl = ref.watch(baseUrlProvider);

  return Uri.parse('$baseUrl/api/v2/qiscus/initiate_chat');
}

typedef InitiateChatFunction = Future<QChatRoom> Function();

@riverpod
InitiateChatFunction initiateChat(InitiateChatRef ref) {
  return () async {
    // Setting share location dari dashboard (mode
    // `QLocationMapConfig.dashboard()`) dibaca ulang setiap initiateChat;
    // endpoint-nya publik, jadi tidak menunggu login.
    refreshShareLocationDashboardConfig(ref);

    // Dibaca di sini (bukan di builder luar) agar setiap pemanggilan closure
    // selalu mengambil nilai terkini, tanpa membuat provider ini rebuild /
    // menghasilkan closure baru saat salah satu dependency berubah.
    var qiscus = await ref.read(qiscusProvider.future);
    var userId = ref.read(userIdProvider);
    var displayName = ref.read(displayNameProvider);
    var avatarUrl = ref.read(userAvatarUrl);
    var userProperties = ref.read(userPropertiesProvider);
    var channelId = ref.read(channelIdConfigProvider);
    var sdkUserExtras = ref.read(sdkUserExtrasProvider);
    var initiateUrl = ref.read(initiateChatUrlProvider);
    var deviceId = ref.read(deviceIdConfigProvider);
    var deviceIdDevelopment = ref.read(deviceIdDevelopmentModeProvider);
    var userExtras = ref.read(userExtrasProvider);
    var storage = ref.read(encSharedPreferenceProvider);

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

    final sessionKey = StorageKey.getSecureSessionKey(
      appId: qiscus.appId!,
      channelId: channelId,
      userId: userId,
    );

    await migrateLegacySecureSession(
      storage: storage,
      sessionKey: sessionKey,
      appId: qiscus.appId!,
      channelId: channelId,
      userId: userId,
    );

    var secureSession = await storage
        .read(key: sessionKey)
        .then((v) => v == null ? null : jsonDecode(v) as Map<String, dynamic>)
        .then((v) => v == null ? null : SecureSession.fromJson(v));

    if (secureSession != null &&
        secureSession.appId == qiscus.appId &&
        secureSession.channelId == channelId &&
        secureSession.userId == userId) {
      data['session_id'] = secureSession.id;
    }

    var response = await http.post(initiateUrl, body: data);
    if (response.statusCode != 200) {
      throw Exception(
        'initiate_chat failed with status ${response.statusCode}: ${response.body}',
      );
    }
    var json = jsonDecode(response.body) as Map<String, dynamic>;

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

    // Kalau getChatRoomWithMessages gagal, error dibiarkan lempar ke atas
    // (bukan diganti room dummy) supaya host app tahu initiateChat benar-benar
    // gagal dan bisa menampilkan error state yang sesuai, bukan chat kosong
    // yang terlihat seperti berhasil.
    var roomData =
        await getChatRoomWithMessages(qiscus: qiscus, roomId: roomId);
    var room = roomData.room;
    var messages = roomData.messages;

    // Security Enchancements
    var isSecure = json['data']['is_secure'] as bool? ?? false;
    var sessionId = roomJson['session_id'] as String?;
    channelId = (roomJson['channel_id'] as int).toString();
    if (isSecure == false) {
      storage.delete(key: sessionKey).ignore();
    }
    if (isSecure && sessionId != null) {
      var underscoreIdx = user.id.indexOf('_');
      var userId =
          underscoreIdx == -1 ? user.id : user.id.substring(underscoreIdx + 1);
      // Save session data to local
      var data = SecureSession(
        appId: qiscus.appId!,
        channelId: channelId,
        userId: userId,
        id: sessionId,
      );
      ref.read(secureSessionProvider.notifier).state = data;
      await storage.write(
        key: sessionKey,
        value: jsonEncode(data.toJson()),
      );
    }

    // Update providers
    ref.read(isResolvedProvider.notifier).state = isResolved ?? false;
    ref.read(isSessionalProvider.notifier).state = isSessional ?? false;
    ref.read(roomStateProvider.notifier).state =
        QChatRoomWithMessages(room, messages);
    ref.read(appStateProvider.notifier).state = AppState.ready(
      roomId: roomId,
      account: user,
    );

    return room;
  };
}

Future<QChatRoomWithMessages> getChatRoomWithMessages({
  required QiscusSDK qiscus,
  required int roomId,
}) {
  return retryWithBackoff(
    () => qiscus.getChatRoomWithMessages(roomId: roomId),
    timeout: const Duration(seconds: 2),
    label: 'getChatRoomWithMessages(roomId: $roomId)',
  );
}
