import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' hide QAccount;

import 'models.dart';
import 'account.dart';
import 'storage_provider.dart';
import 'config/avatar_config.dart';
import 'config/subtitle_config.dart';
import 'states/app_state.dart';
import 'states/app_theme.dart';

final encSharedPreferenceProvider = Provider((_) {
  return const FlutterSecureStorage();
});

final qiscusProvider = FutureProvider<QiscusSDK>((ref) async {
  var appId = ref.watch(appIdProvider);
  if (appId == null) return QiscusSDK();
  return QiscusSDK.withAppId(appId);
});

final appStateProvider = StateProvider((_) => const AppState.initial());
final baseUrlProvider = StateProvider((_) => 'https://multichannel.qiscus.com');
final avatarConfigProvider =
    StateProvider((_) => const QAvatarConfig.enabled());
final subtitleConfigProvider =
    StateProvider((_) => const QSubtitleConfig.disabled());
final titleConfigProvider = StateProvider((_) => 'Customer Service');
final channelIdConfigProvider = StateProvider<String?>((_) => null);
final deviceIdConfigProvider = StateProvider<String?>((_) => null);
final deviceIdDevelopmentModeProvider = StateProvider((_) => false);
final systemEventConfigProvider = StateProvider<bool>((_) => true);
final appThemeConfigProvider = StateProvider((_) => const QAppTheme());
final appIdProvider = StateProvider<String?>((_) => null);
final userIdProvider = StateProvider<String?>((_) => null);
final displayNameProvider = StateProvider<String?>((_) => null);
final userAvatarUrl = StateProvider<String?>((_) => null);
final userPropertiesProvider =
    StateProvider<Map<String, dynamic>?>((_) => null);
final sdkUserExtrasProvider = StateProvider<Map<String, dynamic>?>((_) => null);
final isSessionalRoomProvider = StateProvider<bool>((_) => false);

// ==
final accountProvider = Provider<AsyncValue<QAccount>>((ref) {
  var state = ref.watch(appStateProvider);
  return state.maybeWhen(
    orElse: () => const AsyncValue.loading(),
    ready: (_, account) => AsyncValue.data(account),
  );
});
final avatarUrlProvider = Provider<String?>((ref) {
  var account = ref.watch(accountProvider);
  var avatarConfig = ref.watch(avatarConfigProvider);

  return avatarConfig.when(
    disabled: () => null,
    editable: (avatar) => avatar,
    enabled: () => account.valueOrNull?.avatarUrl,
  );
});

final sessionalProvider = FutureProvider<bool>((ref) async {
  var baseUrl = ref.watch(baseUrlProvider);
  var appId = ref.watch(appIdProvider);

  if (appId == null) return false;

  var sessional = await http.get(Uri.parse('$baseUrl/$appId/get_session'));
  var body = jsonDecode(sessional.body) as Map<String, Object?>;
  var data = body['data'] as Map<String, Object?>;
  var isSessional = data['is_sessional'] as bool?;
  isSessional ??= false;

  return isSessional;
});

final roomIdProvider = Provider<AsyncValue<int>>((ref) {
  var appState = ref.watch(appStateProvider);

  return appState.maybeWhen(
    orElse: () => const AsyncValue.loading(),
    ready: (roomId, _) => AsyncValue.data(roomId),
  );
});
final roomProvider = FutureProvider((ref) async {
  var qiscus = await ref.watch(qiscusProvider.future);
  var roomId = await ref.watch(roomIdProvider).future;
  var room = await qiscus.getChatRoomWithMessages(roomId: roomId);

  for (var m in room.messages) {
    ref.read(messagesProvider.notifier).receive(m);
  }

  return room;
});
final isResolvedProvider = StateProvider<bool>((_) => false);
final isSessionalProvider = StateProvider<bool>((_) => false);
final messagesProvider =
    StateNotifierProvider<MessagesStateNotifier, List<QMessage>>((ref) {
  return MessagesStateNotifier(ref);
});
final sortedMessagesProvider = Provider((ref) {
  var messages = ref.watch(messagesProvider);
  messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
  return messages;
});
final lastMessageProvider = Provider((ref) {
  var messages = ref.watch(sortedMessagesProvider);
  return messages.first;
});

final initiateChatUrlProvider = Provider((ref) {
  var baseUrl = ref.watch(baseUrlProvider);

  return Uri.parse('$baseUrl/api/v2/qiscus/initiate_chat');
});
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

  // return -1;
  var appState = ref.watch(appStateProvider);
  // print('appState($appState)');
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
});

// Stream
final messageReceivedProvider = StreamProvider((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var room = await ref.watch(roomProvider.selectAsync((data) => data.room));
  qiscus.subscribeChatRoom(room);
  ref.onDispose(() {
    qiscus.unsubscribeChatRoom(room);
  });
  yield* qiscus.onMessageReceived();
});
final messageReadProvider = StreamProvider((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var room = await ref.watch(roomProvider.selectAsync((data) => data.room));

  qiscus.subscribeChatRoom(room);
  ref.onDispose(() {
    qiscus.unsubscribeChatRoom(room);
  });

  yield* qiscus.onMessageRead();
});
final messageDeliveredProvider = StreamProvider((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var room = await ref.watch(roomProvider.selectAsync((data) => data.room));

  qiscus.subscribeChatRoom(room);
  ref.onDispose(() {
    qiscus.unsubscribeChatRoom(room);
  });

  yield* qiscus.onMessageDelivered();
});
final messageDeletedProvider = StreamProvider((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var room = await ref.watch(roomProvider.selectAsync((data) => data.room));

  qiscus.subscribeChatRoom(room);
  ref.onDispose(() {
    qiscus.unsubscribeChatRoom(room);
  });

  yield* qiscus.onMessageDeleted();
});
final userPresenceProvider = StreamProvider.autoDispose((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var userId = ref.watch(userIdProvider);

  if (userId != null) {
    qiscus.subscribeUserOnlinePresence(userId);
  }
  ref.onDispose(() {
    if (userId != null) {
      qiscus.unsubscribeUserOnlinePresence(userId);
    }
  });
  yield* qiscus.onUserOnlinePresence();
});
final userTypingProvider = StreamProvider((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var room = await ref.watch(roomProvider.selectAsync((data) => data.room));

  qiscus.subscribeChatRoom(room);
  ref.onDispose(() {
    qiscus.unsubscribeChatRoom(room);
  });

  yield* qiscus.onUserTyping();
});

extension QRefExt on Ref {
  void subscribe<R>(StreamProvider<R> provider, void Function(R) onData) {
    var subs = watch(provider.stream).listen(onData);
    onDispose(() => subs.cancel());
  }

  void wait<R>(FutureProvider<R> provider, void Function(R) onData) async {
    var data = await watch(provider.future);
    onData(data);
  }
}

extension AsyncValueExt<T> on AsyncValue<T> {
  Future<T> get future async {
    final completer = Completer<T>();
    maybeWhen(
      orElse: () {},
      error: (e, trace) => completer.completeError(e, trace),
      data: (data) => completer.complete(data),
    );

    return completer.future;
  }
}

class MessagesStateNotifier extends StateNotifier<List<QMessage>> {
  MessagesStateNotifier(this.ref, [List<QMessage> state = const []])
      : super(state) {
    ref.wait(roomProvider, (QChatRoomWithMessages roomData) {
      state = roomData.messages;
    });
    ref.subscribe(messageReceivedProvider, _onMessageReceived);
    ref.subscribe(messageReadProvider, _onMessageRead);
    ref.subscribe(messageDeliveredProvider, _onMessageDelivered);
  }

  final Ref ref;

  void _onMessageRead(QMessage message) {
    state = state.map((m) {
      if (m.timestamp.isBefore(message.timestamp)) {
        m.status = QMessageStatus.read;
      }

      return m;
    }).toList();
  }

  void _onMessageDelivered(QMessage message) {
    state = state.map((m) {
      if (m.status != QMessageStatus.read &&
          m.timestamp.isBefore(message.timestamp)) {
        m.status = QMessageStatus.delivered;
      }
      return m;
    }).toList();
  }

  void Function(QMessage) get receive => _onMessageReceived;

  void _onMessageReceived(QMessage message) {
    message.status = QMessageStatus.read;
    var idx = state.indexWhere((v) => v.uniqueId == message.uniqueId);

    if (idx == -1) {
      state = [...state, message];
    } else {
      state = state.updateAt(
        index: idx,
        value: message,
      );
    }
  }

  Future<QMessage> sendMessage(QMessage message) async {
    var qiscus = await ref.read(qiscusProvider.future);
    message.status = QMessageStatus.sending;
    _onMessageReceived(message);

    Future.microtask(() async {
      var m = await qiscus.sendMessage(message: message);
      message.id = m.id;
      message.status = QMessageStatus.read;

      _onMessageReceived(message);
      _onMessageRead(message);
    });

    return message;
  }

  Future<QMessage> deleteMessage(String messageUniqueId) async {
    var qiscus = await ref.read(qiscusProvider.future);
    var messages = state.firstWhere((v) => v.uniqueId == messageUniqueId);

    await qiscus.deleteMessages(messageUniqueIds: [messageUniqueId]);
    state = state.where((v) => v.uniqueId != messageUniqueId).toList();

    return messages;
  }

  Future<List<QMessage>> loadMoreMessage([int lastMessageId = 0]) async {
    var qiscus = await ref.read(qiscusProvider.future);
    var roomId = await ref.watch(roomIdProvider).future;
    // var lastMessage = ref.watch(lastMessageProvider);
    // lastMessageId ??= lastMessage.id;

    var messages = await qiscus.getPreviousMessagesById(
      roomId: roomId,
      messageId: lastMessageId,
    );

    state = [
      ...messages,
      ...state,
    ];

    return messages;
  }
}

final mappedMessagesProvider = Provider<List<QMessage>>((ref) {
  var messages = ref.watch(messagesProvider);

  return messages.map((it) {
    QMessage? message;

    message ??= QMessageSystem.tryParse(it);
    message ??= QMessageImage.tryParse(it);
    message ??= QMessageVideo.tryParse(it);
    message ??= QMessageFile.tryParse(it);
    // Not yet mature
    // message ??= QMessageButton.tryParse(it);
    message ??= QMessageReply.tryParse(it);
    message ??= it;

    // if (it.type == QMessageType.custom) {
    //   // FOR debugging purpose to place breakpoint
    //   var payload = it.payload!;
    //   print('payload: $payload');
    // }

    return message;
  }).toList();
});

class QMultichannel {
  const QMultichannel(this.ref);

  final WidgetRef ref;

  int? get roomId => ref.watch(appStateProvider).mapOrNull(
        ready: (data) => data.roomId,
      );
  AsyncValue<QiscusSDK> get qiscus => ref.watch(qiscusProvider);
  AsyncValue<QAccount> get account => ref.watch(accountProvider);
  List<QMessage> get messages => ref.watch(mappedMessagesProvider);
  QAppTheme get theme => ref.watch(appThemeConfigProvider);
  String get title => ref.watch(titleConfigProvider);
  String? get avatarUrl => ref.watch(avatarUrlProvider);

  bool get isResolved => ref.watch(isResolvedProvider);
  AsyncValue<QChatRoom> get room =>
      ref.watch(roomProvider.select((it) => it.whenData((v) => v.room)));

  Future<QChatRoom> initiateChat() async {
    await ref.read(initiateChatProvider.future);

    var room = await ref.watch(roomProvider.selectAsync((r) => r.room));

    return room;
  }

  void enableDebugMode(bool enable) async {
    var qiscus = await ref.read(qiscusProvider.future);
    qiscus.enableDebugMode(enable: enable, level: QLogLevel.verbose);
  }

  void setRoomTitle(String title) {
    ref.read(titleConfigProvider.notifier).state = title;
  }

  void setRoomSubTitle(QSubtitleConfig config) {
    ref.read(subtitleConfigProvider.notifier).state = config;
  }

  void setHideUIEvent() {
    ref.read(systemEventConfigProvider.notifier).state = false;
  }

  void setAvatar(QAvatarConfig config) {
    ref.read(avatarConfigProvider.notifier).state = config;
  }

  void setUser({
    required String userId,
    required String displayName,
    String? avatarUrl,
    Map<String, dynamic>? userProperties,
  }) {
    ref.read(userIdProvider.notifier).state = userId;
    ref.read(displayNameProvider.notifier).state = displayName;
    ref.read(userAvatarUrl.notifier).state = avatarUrl;
    ref.read(userPropertiesProvider.notifier).state = userProperties;
  }

  void setChannelId(String channelId) {
    ref.read(channelIdConfigProvider.notifier).state = channelId;
  }

  void setDeviceId(String deviceId, {bool isDevelopment = false}) {
    ref.read(deviceIdConfigProvider.notifier).state = deviceId;
    ref.read(deviceIdDevelopmentModeProvider.notifier).state = isDevelopment;
  }

  Future<void> clearUser() async {
    ref.read(userIdProvider.notifier).state = null;
    ref.read(displayNameProvider.notifier).state = null;
    ref.read(userPropertiesProvider.notifier).state = null;
    ref.read(sdkUserExtrasProvider.notifier).state = null;
    ref.read(appStateProvider.notifier).state = const AppState.initial();
    ref.read(localUserDataProvider.notifier).clear();
  }

  Future<QMessage> sendMessage(QMessage message) async {
    return ref.watch(messagesProvider.notifier).sendMessage(message);
  }

  Future<QMessage> deleteMessage(String messageUniqueId) async {
    return ref.watch(messagesProvider.notifier).deleteMessage(messageUniqueId);
  }

  Future<List<QMessage>> loadMoreMessages(int lastMessageId) async {
    return ref.watch(messagesProvider.notifier).loadMoreMessage(lastMessageId);
  }

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

  Future<QMessage> generateFileAttachmentMessage({
    required String url,
    required String caption,
  }) async {
    var roomId = await ref.watch(roomIdProvider).future;
    var q = await qiscus.future;
    return q.generateFileAttachmentMessage(
        chatRoomId: roomId, caption: caption, url: url);
  }

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

final uploaderProvider =
    StateNotifierProvider<UploadStateNotifier, Set<QUpload>>((ref) {
  return UploadStateNotifier(ref);
});

class UploadStateNotifier extends StateNotifier<Set<QUpload>> {
  final Ref ref;

  UploadStateNotifier(this.ref, [Set<QUpload> state = const {}]) : super(state);

  void add(File file) async {
    var qiscus = await ref.read(qiscusProvider.future);
    var roomId = await ref.read(roomIdProvider).future;

    var progress = QUpload(file, 0);
    state = {...state, progress};

    var cancelToken = CancelToken();
    progress.cancel = cancelToken.cancel;

    var stream = qiscus.upload(file, cancelToken: cancelToken);
    await for (var data in stream) {
      if (data.data == null) {
        progress.progress = data.progress;
        state = {...state, progress};
      } else {
        state = state.where((v) => v != progress).toSet();
        var m = qiscus.generateFileAttachmentMessage(
          chatRoomId: roomId,
          caption: '',
          url: data.data!,
        );
        await ref.read(messagesProvider.notifier).sendMessage(m);
      }
    }
  }

  void cancel(QUpload file) {
    state.firstWhere((v) => v == file).cancel?.call();
    state = state.where((v) => v != file).toSet();
  }
}

class QUpload {
  File file;
  double progress;
  void Function()? cancel;

  QUpload(this.file, this.progress);

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is QUpload &&
          runtimeType == other.runtimeType &&
          file == other.file;

  @override
  int get hashCode => Object.hash(runtimeType, file);
}

extension _ListExt<T> on List<T> {
  List<T> updateAt({
    required int index,
    required T value,
  }) {
    return [
      ...sublist(0, index),
      value,
      ...sublist(index + 1, length),
    ];
  }
}

typedef URLTapper = void Function(String);
final onURLTappedProvider = StateProvider<URLTapper?>((ref) => null);

// ==== UI
final accountIdProvider = Provider((ref) {
  return ref.watch(accountProvider.select((v) => v.value?.id));
});

final ProviderFamily<Color, String> bubbleTextColorProvider =
    Provider.family((ref, String senderId) {
  final account = ref.watch(accountIdProvider)!;
  final theme = ref.watch(appThemeConfigProvider);

  if (account == senderId) {
    return theme.rightBubbleTextColor;
  } else {
    return theme.leftBubbleTextColor;
  }
});
final ProviderFamily<Color, String> bubbleBgColorProvider =
    Provider.family((ref, String senderId) {
  final account = ref.watch(accountIdProvider)!;
  final theme = ref.watch(appThemeConfigProvider);

  if (account == senderId) {
    return theme.rightBubbleColor;
  } else {
    return theme.leftBubbleColor;
  }
});
