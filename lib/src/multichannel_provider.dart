import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_multichannel_widget/src/storage_provider.dart';

import 'config/avatar_config.dart';
import 'config/subtitle_config.dart';
import 'provider.dart';
import 'states/app_theme.dart';

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
    return ProviderScope(
      overrides: [
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
        // messagesProvider.overrideWithValue(messagesProviderDummy),
      ],
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
    return overrideWithProvider(StateProvider((_) => value));
  }
}
