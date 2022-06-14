import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:qiscus_multichannel_widget/src/models.dart';

import 'config/avatar_config.dart';
import 'config/subtitle_config.dart';
import 'states/app_state.dart';
import 'states/app_theme.dart';

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
final avatarUrlProvider = StateProvider<String?>((_) => null);
final userPropertiesProvider =
    StateProvider<Map<String, dynamic>?>((_) => null);
final sdkUserExtrasProvider = StateProvider<Map<String, dynamic>?>((_) => null);

// ==
final accountProvider = Provider<AsyncValue<QAccount>>((ref) {
  var state = ref.watch(appStateProvider);
  return state.when(
    initial: () => const AsyncValue.loading(),
    ready: (_, account) => AsyncValue.data(account),
  );
});
final roomIdProvider = Provider<AsyncValue<int>>((ref) {
  var appState = ref.watch(appStateProvider);

  return appState.when(
    initial: () => const AsyncValue.loading(),
    ready: (roomId, _) => AsyncValue.data(roomId),
  );
});
final roomProvider = FutureProvider((ref) async {
  var qiscus = await ref.watch(qiscusProvider.future);
  var roomId = await ref.watch(roomIdProvider.future);
  var room = await qiscus.getChatRoomWithMessages(roomId: roomId);

  return room;
});
final messagesProvider =
    StateNotifierProvider<MessagesStateNotifier, List<QMessage>>((ref) {
  return MessagesStateNotifier(ref);
});

final initiateChatUrlProvider = Provider((ref) {
  var baseUrl = ref.watch(baseUrlProvider);

  return Uri.parse('$baseUrl/api/v2/qiscus/initiate_chat');
});
final initiateChatProvider = FutureProvider((ref) async {
  var qiscus = await ref.watch(qiscusProvider.future);
  var userId = ref.watch(userIdProvider);
  var displayName = ref.watch(displayNameProvider);
  var avatarUrl = ref.watch(avatarUrlProvider);
  var userProperties = ref.watch(userPropertiesProvider);
  var channelId = ref.watch(channelIdConfigProvider);
  var sdkUserExtras = ref.watch(sdkUserExtrasProvider);
  var url = ref.watch(initiateChatUrlProvider);
  var deviceId = ref.watch(deviceIdConfigProvider);
  var deviceIdDevelopmentMode = ref.watch(deviceIdDevelopmentModeProvider);

  // return -1;

  var nonce = await qiscus.getJWTNonce();
  var data = <String, dynamic>{
    'app_id': qiscus.appId,
    'user_id': userId,
    'nonce': nonce,
  };

  if (displayName != null) data['name'] = displayName;
  if (avatarUrl != null) data['avatar'] = avatarUrl;
  if (sdkUserExtras != null) data['sdk_user_extras'] = sdkUserExtras;
  if (userProperties != null) data['user_properties'] = userProperties;
  if (channelId != null) data['channel_id'] = channelId;

  var resp = await http.post(url, body: data);
  var json = jsonDecode(resp.body);
  var identityToken = json['data']['identity_token'] as String;
  // var isSessional = json['data']['is_sessional'] as bool;
  var room = json['data']['customer_room'];
  var roomId = int.parse(room['room_id']);
  var user = await qiscus.setUserWithIdentityToken(token: identityToken);

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
  var stream = qiscus.onMessageReceived();
  stream = stream.map((it) {
    print('message received $it');
    return it;
  });

  yield* stream;
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
final userPresenceProvider = StreamProvider((ref) async* {
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
  MessagesStateNotifier(this.ref, [List<QMessage> _state = const []])
      : super(_state) {
    ref.wait(roomProvider, (QChatRoomWithMessages roomData) {
      state = roomData.messages;
    });
    ref.subscribe(messageReceivedProvider, (QMessage message) {
      state = [
        ...state.where((m) => m.uniqueId != message.uniqueId),
        message,
      ];
    });
  }

  final Ref ref;

  Future<QMessage> sendMessage(QMessage message) async {
    var qiscus = await ref.read(qiscusProvider.future);
    message.status = QMessageStatus.sending;
    state = [
      ...state,
      message,
    ];

    var m = await qiscus.sendMessage(message: message);
    message.id = m.id;
    message.status = m.status;

    state = [
      ...state.where((v) => v.uniqueId != message.uniqueId),
      message,
    ];

    return message;
  }

  Future<QMessage> deleteMessage(String messageUniqueId) async {
    var qiscus = await ref.read(qiscusProvider.future);
    var messages = state.firstWhere((v) => v.uniqueId == messageUniqueId);

    await qiscus.deleteMessages(messageUniqueIds: [messageUniqueId]);
    state = [
      ...state.where((v) => v.uniqueId != messageUniqueId),
    ];
    return messages;
  }

  Future<List<QMessage>> loadMoreMessage(int lastMessageId) async {
    var qiscus = await ref.read(qiscusProvider.future);
    var roomId = await ref.watch(roomIdProvider.future);

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

    message ??= QMessageImage.tryParse(it);
    message ??= QMessageVideo.tryParse(it);
    message ??= QMessageFile.tryParse(it);
    // Not yet mature
    // message ??= QMessageButton.tryParse(it);
    message ??= QMessageReply.tryParse(it);
    message ??= QMessageSystem.tryParse(it);
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

  AsyncValue<QChatRoom> get room =>
      ref.watch(roomProvider.select((it) => it.whenData((v) => v.room)));

  Future<QChatRoom> initiateChat() async {
    await ref.read(initiateChatProvider.future);
    var room = await ref.watch(roomProvider.future.select((it) async {
      var data = await it;
      return data.room;
    }));

    return room;
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
    ref.read(avatarUrlProvider.notifier).state = avatarUrl;
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
    // TODO: clear user
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
    var roomId = await ref.watch(roomIdProvider.future);
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
    var roomId = await ref.watch(roomIdProvider.future);
    var q = await qiscus.future;
    return q.generateFileAttachmentMessage(
        chatRoomId: roomId, caption: caption, url: url);
  }

  Future<QMessage> generateFileAttachmentMessageFromFile({
    required File file,
    required String caption,
  }) async {
    var roomId = await ref.watch(roomIdProvider.future);
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
    var roomId = await ref.read(roomIdProvider.future);

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
