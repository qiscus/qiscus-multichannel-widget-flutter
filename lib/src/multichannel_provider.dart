import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide Provider, ChangeNotifierProvider;

import 'config/avatar_config.dart';
import 'config/subtitle_config.dart';
import 'provider.dart';
import 'states/app_theme.dart';

class QMultichannelProvider extends ConsumerStatefulWidget {
  const QMultichannelProvider({
    super.key,
    required this.appId,
    required this.builder,
    this.onURLTapped,
    this.avatar = const QAvatarConfig.enabled(),
    this.rightAvatar = const QAvatarConfig.enabled(),
    this.subtitle = const QSubtitleConfig.enabled(),
    this.title,
    this.channelId,
    this.hideEventUI = false,
    this.baseUrl = 'https://multichannel.qiscus.com',
    this.sdkBaseUrl = 'https://api3.qiscus.com',
    //
    this.theme = const QAppTheme(),
    this.parentProviderContainer,
  });

  final String appId;
  final Widget Function(BuildContext) builder;
  final QAppTheme theme;
  final QAvatarConfig avatar;
  final QAvatarConfig rightAvatar;
  final QSubtitleConfig subtitle;
  final String? title;
  final String? channelId;
  final bool hideEventUI;
  final String baseUrl;
  final String sdkBaseUrl;
  final void Function(String url)? onURLTapped;
  final ProviderContainer? parentProviderContainer;

  @override
  ConsumerState<QMultichannelProvider> createState() =>
      _QMultichannelProviderState();
}

class _QMultichannelProviderState extends ConsumerState<QMultichannelProvider> {
  @override
  void initState() {
    super.initState();

    if (widget.parentProviderContainer != null) {
      Future.microtask(() {
        ref.read(appIdProvider.notifier).state = widget.appId;
        ref.read(appThemeConfigProvider.notifier).state = widget.theme;
        ref.read(baseUrlProvider.notifier).state = widget.baseUrl;
        ref.read(avatarConfigProvider.notifier).state = widget.avatar;
        ref.read(rightAvatarConfigProvider.notifier).state = widget.rightAvatar;
        ref.read(subtitleConfigProvider.notifier).state = widget.subtitle;
        ref.read(titleConfigProvider.notifier).state =
            widget.title ?? 'Customer Service';
        ref.read(channelIdConfigProvider.notifier).state = widget.channelId;
        ref.read(systemEventVisibleConfigProvider.notifier).state =
            !widget.hideEventUI;
        ref.read(baseUrlProvider.notifier).state = widget.baseUrl;
        ref.read(sdkBaseUrlProvider.notifier).state = widget.sdkBaseUrl;
        ref.read(onURLTappedProvider.notifier).state = widget.onURLTapped;
      });
    }
  }

  List<Override> get _overrides {
    if (widget.parentProviderContainer != null) return [];
    return [
      appIdProvider.overrideWithValue(widget.appId),
      appThemeConfigProvider.overrideWithValue(widget.theme),
      baseUrlProvider.overrideWithValue(widget.baseUrl),
      avatarConfigProvider.overrideWithValue(widget.avatar),
      rightAvatarConfigProvider.overrideWithValue(widget.rightAvatar),
      subtitleConfigProvider.overrideWithValue(widget.subtitle),
      titleConfigProvider.overrideWithValue(widget.title ?? 'Customer Service'),
      channelIdConfigProvider.overrideWithValue(widget.channelId),
      systemEventVisibleConfigProvider.overrideWithValue(!widget.hideEventUI),
      baseUrlProvider.overrideWithValue(widget.baseUrl),
      sdkBaseUrlProvider.overrideWithValue(widget.sdkBaseUrl),
      onURLTappedProvider.overrideWithValue(widget.onURLTapped),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      parent: widget.parentProviderContainer,
      overrides: _overrides,
      child: widget.builder(context),
    );
  }
}

class Q_MultichannelProvider extends StatelessWidget {
  const Q_MultichannelProvider({
    Key? key,
    required this.appId,
    required this.builder,
    this.onURLTapped,
    this.avatar = const QAvatarConfig.enabled(),
    this.rightAvatar = const QAvatarConfig.enabled(),
    this.subtitle = const QSubtitleConfig.enabled(),
    this.title,
    this.channelId,
    this.hideEventUI = false,
    this.baseUrl = 'https://multichannel.qiscus.com',
    this.sdkBaseUrl = 'https://api3.qiscus.com',
    //
    this.theme = const QAppTheme(),
    this.parentProviderContainer,
  }) : super(key: key);

  final String appId;
  final Widget Function(BuildContext) builder;
  final QAppTheme theme;
  final QAvatarConfig avatar;
  final QAvatarConfig rightAvatar;
  final QSubtitleConfig subtitle;
  final String? title;
  final String? channelId;
  final bool hideEventUI;
  final String baseUrl;
  final String sdkBaseUrl;
  final void Function(String url)? onURLTapped;
  final ProviderContainer? parentProviderContainer;

  @override
  Widget build(BuildContext context) {
    var overrides = <Override>[
      appIdProvider.overrideWithValue(appId),
      appThemeConfigProvider.overrideWithValue(theme),
      baseUrlProvider.overrideWithValue(baseUrl),
      avatarConfigProvider.overrideWithValue(avatar),
      rightAvatarConfigProvider.overrideWithValue(rightAvatar),
      subtitleConfigProvider.overrideWithValue(subtitle),
      titleConfigProvider.overrideWithValue(title ?? 'Customer Service'),
      channelIdConfigProvider.overrideWithValue(channelId),
      systemEventVisibleConfigProvider.overrideWithValue(!hideEventUI),
      baseUrlProvider.overrideWithValue(baseUrl),
      sdkBaseUrlProvider.overrideWithValue(sdkBaseUrl),
      onURLTappedProvider.overrideWithValue(onURLTapped),
    ];

    return ProviderScope(
      overrides: overrides,
      parent: parentProviderContainer,
      child: builder(context),
    );
  }
}

class QMultichannelConsumer extends ConsumerWidget {
  const QMultichannelConsumer({Key? key, required this.builder})
      : super(key: key);

  final Widget Function(BuildContext, QMultichannel) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return builder(context, QMultichannel(ref));
  }
}

extension StateProviderExt<T> on StateProvider<T> {
  Override overrideWithValue(T value) {
    return overrideWith((_) {
      return value;
    });
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
