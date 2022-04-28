import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/avatar_config.dart';
import 'config/subtitle_config.dart';
import 'provider.dart';
import 'states/app_theme.dart';

class QMultichannelProvider extends ConsumerWidget {
  const QMultichannelProvider({
    Key? key,
    required this.appId,
    required this.builder,
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        appIdProvider.overrideWithValue(StateController(appId)),
        appThemeConfigProvider.overrideWithValue(StateController(theme)),
        baseUrlProvider.overrideWithValue(StateController(baseUrl)),
        avatarConfigProvider.overrideWithValue(StateController(avatar)),
        subtitleConfigProvider.overrideWithValue(StateController(subtitle)),
        titleConfigProvider
            .overrideWithValue(StateController(title ?? 'Customer Service')),
        channelIdConfigProvider.overrideWithValue(StateController(channelId)),
        systemEventConfigProvider
            .overrideWithValue(StateController(!hideEventUI)),
        baseUrlProvider.overrideWithValue(StateController(baseUrl)),
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
    return builder(context, QMultichannel(ref));
  }
}
