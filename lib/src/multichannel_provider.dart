import 'package:flutter/material.dart';

import '../qiscus_multichannel_widget.dart';
import 'storage_provider.dart';

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
