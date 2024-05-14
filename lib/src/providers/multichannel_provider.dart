part of 'provider.dart';

abstract class IQMultichannel {
  int? get roomId;
  AsyncValue<QiscusSDK> get qiscus;
  AsyncValue<QAccount> get account;
  AsyncValue<QChatRoom> get room;
  List<QMessage> get messages;
  QAppTheme get theme;
  String get title;
  String? get avatarUrl;
  bool get isResolved;

  Future<QChatRoom> initiateChat();
  void enableDebugMode(bool enable);
  void setRoomTitle(String title);
  void setRoomSubTitle(QSubtitleConfig config);
  void setHideUIEvent();
  void setAvatar(QAvatarConfig config);
  void setUser({
    required String userId,
    required String displayName,
    String? avatarUrl,
    Map<String, dynamic>? userProperties,
    Map<String, dynamic>? extras,
  });
  void setChannelId(String channelId);
  void setDeviceId(String deviceId, {bool isDevelopment = false});
  Future<void> clearUser();
  Future<QMessage> sendMessage(QMessage message);
  Future<QMessage> deleteMessage(String messageUniqueId);
  Future<List<QMessage>> loadMoreMessages(int lastMessageId);
  Future<QMessage> generateMessage({
    required String text,
    Map<String, dynamic>? extras,
  });
  Future<QMessage> generateReplyMessage({
    required String text,
    required QMessage repliedMessage,
    Map<String, dynamic>? extras,
  });
  Future<QMessage> generateFileAttachmentMessage({
    required String url,
    required String caption,
  });
  Future<QMessage> generateFileAttachmentMessageFromFile({
    required File file,
    required String caption,
  });
}

@riverpod
int? _roomIdQ(_RoomIdQRef ref) {
  return ref.watch(appStateProvider).mapOrNull(ready: (data) => data.roomId);
}

@riverpod
AsyncValue<QChatRoom> _chatRoom(_ChatRoomRef ref) {
  return ref.watch(roomProvider.select((it) => it.whenData((v) => v.room)));
}

class _QMultichannelProviderRef implements IQMultichannel {
  const _QMultichannelProviderRef(this.ref);
  final ProviderRef ref;

  @override
  int? get roomId => ref.read(_roomIdQProvider);
  @override
  AsyncValue<QiscusSDK> get qiscus => ref.read(qiscusProvider);
  @override
  AsyncValue<QAccount> get account => ref.read(accountProvider);
  @override
  List<QMessage> get messages => ref.read(mappedMessagesProvider);
  @override
  QAppTheme get theme => ref.watch(appThemeConfigProvider);
  @override
  String get title => ref.watch(titleConfigProvider);
  @override
  String? get avatarUrl => ref.read(avatarUrlProvider);

  @override
  bool get isResolved => ref.watch(isResolvedProvider);
  @override
  AsyncValue<QChatRoom> get room => ref.read(_chatRoomProvider);

  @override
  Future<QChatRoom> initiateChat() async {
    return ref.read(initiateChatProvider.future).then((f) => f());
  }

  @override
  void enableDebugMode(bool enable) async {
    var qiscus = await ref.read(qiscusProvider.future);
    qiscus.enableDebugMode(enable: enable, level: QLogLevel.verbose);
  }

  @override
  void setRoomTitle(String title) {
    ref.read(titleConfigProvider.notifier).state = title;
  }

  @override
  void setRoomSubTitle(QSubtitleConfig config) {
    ref.read(subtitleConfigProvider.notifier).state = config;
  }

  @override
  void setHideUIEvent() {
    ref.read(systemEventVisibleConfigProvider.notifier).state = false;
  }

  @override
  void setAvatar(QAvatarConfig config) {
    ref.read(avatarConfigProvider.notifier).state = config;
  }

  @override
  void setUser({
    required String userId,
    required String displayName,
    String? avatarUrl,
    Map<String, dynamic>? userProperties,
    Map<String, dynamic>? extras,
  }) {
    ref.read(userIdProvider.notifier).state = userId;
    ref.read(displayNameProvider.notifier).state = displayName;
    ref.read(userAvatarUrl.notifier).state = avatarUrl;
    ref.read(userPropertiesProvider.notifier).state = userProperties;
    ref.read(userExtrasProvider.notifier).state = extras;
  }

  @override
  void setChannelId(String channelId) {
    ref.read(channelIdConfigProvider.notifier).state = channelId;
  }

  @override
  void setDeviceId(String deviceId, {bool isDevelopment = false}) {
    ref.read(deviceIdConfigProvider.notifier).state = deviceId;
    ref.read(deviceIdDevelopmentModeProvider.notifier).state = isDevelopment;
  }

  @override
  Future<void> clearUser() async {
    ref.read(userIdProvider.notifier).state = null;
    ref.read(displayNameProvider.notifier).state = null;
    ref.read(userPropertiesProvider.notifier).state = null;
    ref.read(sdkUserExtrasProvider.notifier).state = null;
    ref.read(appStateProvider.notifier).state = const AppState.initial();
    ref.read(messagesNotifierProvider.notifier).clear();
    await ref.read(qiscusProvider.future).then((q) => q.clearUser());
  }

  @override
  Future<QMessage> sendMessage(QMessage message) async {
    return ref.read(messagesNotifierProvider.notifier).sendMessage(message);
  }

  @override
  Future<QMessage> deleteMessage(String messageUniqueId) async {
    return ref
        .read(messagesNotifierProvider.notifier)
        .deleteMessage(messageUniqueId);
  }

  @override
  Future<List<QMessage>> loadMoreMessages(int lastMessageId) async {
    return ref
        .read(messagesNotifierProvider.notifier)
        .loadMoreMessage(lastMessageId);
  }

  @override
  Future<QMessage> generateMessage({
    required String text,
    Map<String, dynamic>? extras,
  }) async {
    var roomId = await ref.read(roomIdProvider.future);
    var qiscus = await ref.read(qiscusProvider.future);

    return qiscus.generateMessage(
      chatRoomId: roomId,
      text: text,
      extras: extras,
    );
  }

  @override
  Future<QMessage> generateReplyMessage({
    required String text,
    required QMessage repliedMessage,
    Map<String, dynamic>? extras,
  }) async {
    var roomId = await ref.read(roomIdProvider).future;
    var q = await qiscus.future;
    return q.generateReplyMessage(
      chatRoomId: roomId,
      text: text,
      repliedMessage: repliedMessage,
    );
  }

  @override
  Future<QMessage> generateFileAttachmentMessage({
    required String url,
    required String caption,
  }) async {
    var roomId = await ref.read(roomIdProvider).future;
    var q = await qiscus.future;
    return q.generateFileAttachmentMessage(
        chatRoomId: roomId, caption: caption, url: url);
  }

  @override
  Future<QMessage> generateFileAttachmentMessageFromFile({
    required File file,
    required String caption,
  }) async {
    var roomId = await ref.read(roomIdProvider).future;
    var q = await qiscus.future;
    var stream = q.upload(file);
    var data = await stream.firstWhere((item) => item.data != null);
    return q.generateFileAttachmentMessage(
      chatRoomId: roomId,
      caption: caption,
      url: data.data!,
    );
  }
}

class _QMultichannelWidgetRef implements IQMultichannel {
  const _QMultichannelWidgetRef(this.ref);
  final WidgetRef ref;

  @override
  int? get roomId => ref.read(_roomIdQProvider);
  @override
  AsyncValue<QiscusSDK> get qiscus => ref.watch(qiscusProvider);
  @override
  AsyncValue<QAccount> get account => ref.watch(accountProvider);
  @override
  List<QMessage> get messages => ref.watch(mappedMessagesProvider);
  @override
  QAppTheme get theme => ref.watch(appThemeConfigProvider);
  @override
  String get title => ref.watch(titleConfigProvider);
  @override
  String? get avatarUrl => ref.watch(avatarUrlProvider);

  @override
  bool get isResolved => ref.watch(isResolvedProvider);
  @override
  AsyncValue<QChatRoom> get room => ref.read(_chatRoomProvider);

  @override
  Future<QChatRoom> initiateChat() async {
    return ref.read(initiateChatProvider.future).then((f) => f());
  }

  @override
  void enableDebugMode(bool enable) async {
    var qiscus = await ref.read(qiscusProvider.future);
    qiscus.enableDebugMode(enable: enable, level: QLogLevel.verbose);
  }

  @override
  void setRoomTitle(String title) {
    ref.read(titleConfigProvider.notifier).state = title;
  }

  @override
  void setRoomSubTitle(QSubtitleConfig config) {
    ref.read(subtitleConfigProvider.notifier).state = config;
  }

  @override
  void setHideUIEvent() {
    ref.read(systemEventVisibleConfigProvider.notifier).state = false;
  }

  @override
  void setAvatar(QAvatarConfig config) {
    ref.read(avatarConfigProvider.notifier).state = config;
  }

  @override
  void setUser({
    required String userId,
    required String displayName,
    String? avatarUrl,
    Map<String, dynamic>? userProperties,
    Map<String, dynamic>? extras,
  }) {
    ref.read(userIdProvider.notifier).state = userId;
    ref.read(displayNameProvider.notifier).state = displayName;
    ref.read(userAvatarUrl.notifier).state = avatarUrl;
    ref.read(userPropertiesProvider.notifier).state = userProperties;
    ref.read(userExtrasProvider.notifier).state = extras;
  }

  @override
  void setChannelId(String channelId) {
    ref.read(channelIdConfigProvider.notifier).state = channelId;
  }

  @override
  void setDeviceId(String deviceId, {bool isDevelopment = false}) {
    ref.read(deviceIdConfigProvider.notifier).state = deviceId;
    ref.read(deviceIdDevelopmentModeProvider.notifier).state = isDevelopment;
  }

  @override
  Future<void> clearUser() async {
    ref.read(userIdProvider.notifier).state = null;
    ref.read(displayNameProvider.notifier).state = null;
    ref.read(userPropertiesProvider.notifier).state = null;
    ref.read(sdkUserExtrasProvider.notifier).state = null;
    ref.read(appStateProvider.notifier).state = const AppState.initial();
    ref.read(messagesNotifierProvider.notifier).clear();
    await ref.read(qiscusProvider.future).then((q) => q.clearUser());
  }

  @override
  Future<QMessage> sendMessage(QMessage message) async {
    return ref.read(messagesNotifierProvider.notifier).sendMessage(message);
  }

  @override
  Future<QMessage> deleteMessage(String messageUniqueId) async {
    return ref
        .read(messagesNotifierProvider.notifier)
        .deleteMessage(messageUniqueId);
  }

  @override
  Future<List<QMessage>> loadMoreMessages(int lastMessageId) async {
    return ref
        .read(messagesNotifierProvider.notifier)
        .loadMoreMessage(lastMessageId);
  }

  @override
  Future<QMessage> generateMessage({
    required String text,
    Map<String, dynamic>? extras,
  }) async {
    var roomId = await ref.watch(roomIdProvider).future;
    var q = await qiscus.future;
    return q.generateMessage(
      chatRoomId: roomId,
      text: text,
      extras: extras,
    );
  }

  @override
  Future<QMessage> generateReplyMessage({
    required String text,
    required QMessage repliedMessage,
    Map<String, dynamic>? extras,
  }) async {
    var roomId = await ref.read(roomIdProvider).future;
    var q = await qiscus.future;
    return q.generateReplyMessage(
      chatRoomId: roomId,
      text: text,
      repliedMessage: repliedMessage,
    );
  }

  @override
  Future<QMessage> generateFileAttachmentMessage({
    required String url,
    required String caption,
  }) async {
    var roomId = await ref.watch(roomIdProvider).future;
    var q = await qiscus.future;
    return q.generateFileAttachmentMessage(
        chatRoomId: roomId, caption: caption, url: url);
  }

  @override
  Future<QMessage> generateFileAttachmentMessageFromFile({
    required File file,
    required String caption,
  }) async {
    var roomId = await ref.watch(roomIdProvider).future;
    var q = await qiscus.future;
    var stream = q.upload(file);
    var data = await stream.firstWhere((item) => item.data != null);
    return q.generateFileAttachmentMessage(
      chatRoomId: roomId,
      caption: caption,
      url: data.data!,
    );
  }
}

@riverpod
IQMultichannel multichannel(MultichannelRef ref) {
  return _QMultichannelProviderRef(ref);
}

class QMultichannel extends _QMultichannelWidgetRef implements IQMultichannel {
  QMultichannel(super.ref);

  static final provider = multichannelProvider;
}
