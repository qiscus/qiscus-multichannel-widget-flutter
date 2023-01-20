import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import 'config/avatar_config.dart';
import 'config/subtitle_config.dart';
import 'providers/account_provider.dart';
import 'providers/avatar_url_provider.dart';
import 'providers/initiate_chat_provider.dart';
import 'providers/messages_provider.dart';
import 'providers/qiscus_sdk_provider.dart';
import 'providers/room_id_provider.dart';
import 'providers/room_provider.dart';
import 'providers/states_provider.dart';
import 'states/app_state.dart';
import 'states/app_theme.dart';
import 'storage_provider.dart';
import 'utils/extensions.dart';

class QMultichannelProvider extends ConsumerWidget {
  const QMultichannelProvider({
    Key? key,
    required this.appId,
    required this.builder,
    this.onURLTapped,
    this.avatar = const QAvatarConfig.enabled(),
    this.subtitle = const QSubtitleConfig.enabled(),
    this.title,
    this.channelId,
    this.hideEventUI = false,
    this.baseUrl = 'https://multichannel.qiscus.com',
    //
    this.theme = const QAppTheme(),
  }) : super(key: key);

  final String appId;
  final Widget Function(BuildContext) builder;
  final QAppTheme theme;
  final QAvatarConfig avatar;
  final QSubtitleConfig subtitle;
  final String? title;
  final String? channelId;
  final bool hideEventUI;
  final String baseUrl;
  final void Function(String url)? onURLTapped;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var overrides = <Override>[
      appIdProvider.overrideWithValue(appId),
      appThemeConfigProvider.overrideWithValue(theme),
      baseUrlProvider.overrideWithValue(baseUrl),
      avatarConfigProvider.overrideWithValue(avatar),
      subtitleConfigProvider.overrideWithValue(subtitle),
      titleConfigProvider.overrideWithValue(title ?? 'Customer Service'),
      channelIdConfigProvider.overrideWithValue(channelId),
      systemEventConfigProvider.overrideWithValue(!hideEventUI),
      baseUrlProvider.overrideWithValue(baseUrl),
      onURLTappedProvider.overrideWithValue(onURLTapped),
    ];

    return ProviderScope(
      overrides: overrides,
      child: builder(context),
    );
  }
}

class ProvObserver extends ProviderObserver {
  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    print('@did-dispose-provider ${provider.name}');
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print('@did-update-provider ${provider.name}');
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}

class QMultichannelConsumer extends ConsumerWidget {
  const QMultichannelConsumer({Key? key, required this.builder})
      : super(key: key);

  final Widget Function(BuildContext, QMultichannel) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(localUserDataProvider.notifier).fetchData(),
      builder: (context, s) {
        return builder(context, QMultichannel(ref));
      },
    );
  }
}

extension StateProviderExt<T> on StateProvider<T> {
  Override overrideWithValue(T value) {
    return overrideWith((_) {
      return value;
    });
  }
}

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
    var roomId = ref.read(roomIdProvider);
    var account = ref.read(accountProvider);

    if (roomId.valueOrNull != null && account.valueOrNull != null) {
      ref.invalidate(initiateChatProvider);
      await ref.read(initiateChatProvider.future);
    } else {
      await ref.read(initiateChatProvider.future);
    }

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
    ref.read(messagesProvider.notifier).clear();
    ref.read(qiscusProvider.future).then((q) => q.clearUser());
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

class QNavObserver extends NavigatorObserver {
  QNavObserver();

  @override
  void didPop(Route route, Route? previousRoute) {
    var context = navigator?.context;
    if (context != null) {
      var ref = ProviderScope.containerOf(context);
      // _clearUser(ref);
      try {
        ref.read(onBackBtnTappedProvider).call(context);
      } catch (_) {}
    }

    super.didPop(route, previousRoute);
  }
}
