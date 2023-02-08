import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../config/avatar_config.dart';
import '../config/subtitle_config.dart';
import '../multichannel_provider.dart';
import '../states/app_state.dart';
import '../states/app_theme.dart';
import '../widgets/chat_buttons.dart';
import 'messages_provider.dart';
import 'qiscus_sdk_provider.dart';

final appStateProvider =
    StateProvider((_) => const AppState.initial(), name: 'appStateProvider');
final baseUrlProvider = StateProvider((_) => 'https://multichannel.qiscus.com',
    name: 'baseUrlProvider');
final avatarConfigProvider = StateProvider((_) => const QAvatarConfig.enabled(),
    name: 'avatarConfigProvider');
final subtitleConfigProvider = StateProvider(
    (_) => const QSubtitleConfig.disabled(),
    name: 'subtitleConfigProvider');
final titleConfigProvider =
    StateProvider((_) => 'Customer Service', name: 'titleConfigProvider');
final channelIdConfigProvider =
    StateProvider<String?>((_) => null, name: 'channelIdConfigProvider');
final deviceIdConfigProvider =
    StateProvider<String?>((_) => null, name: 'deviceIdConfigProvider');
final deviceIdDevelopmentModeProvider =
    StateProvider((_) => false, name: 'deviceIdDevelopmentModeProvider');
final systemEventConfigProvider =
    StateProvider<bool>((_) => true, name: 'systemEventConfigProvider');
final appThemeConfigProvider =
    StateProvider((_) => const QAppTheme(), name: 'appThemeConfigProvider');
final appIdProvider =
    StateProvider<String?>((_) => null, name: 'appIdProvider');
final userIdProvider =
    StateProvider<String?>((_) => null, name: 'userIdProvider');
final displayNameProvider =
    StateProvider<String?>((_) => null, name: 'displayNameProvider');
final userAvatarUrl =
    StateProvider<String?>((_) => null, name: 'userAvatarUrlProvider');
final userPropertiesProvider = StateProvider<Map<String, dynamic>?>((_) => null,
    name: 'userPropertiesProvider');
final sdkUserExtrasProvider = StateProvider<Map<String, dynamic>?>((_) => null,
    name: 'sdkUserExtrasProvider');
final isSessionalRoomProvider =
    StateProvider<bool>((_) => false, name: 'isSessionalRoomProvider');
final isResolvedProvider =
    StateProvider<bool>((_) => false, name: 'isResolvedProvider');
final isSessionalProvider =
    StateProvider<bool>((_) => false, name: 'isSessionalProvider');

typedef URLTapper = void Function(String);
typedef QButtonTapper = void Function(QMultichannel, QMessage, QButtons);
final onURLTappedProvider =
    StateProvider<URLTapper?>((_) => null, name: 'onURLTappedProvider');
final onButtonTappedProvider = StateProvider<QButtonTapper>((ref) {
  return (ref, message, button) async {
    await button.next(ref);
  };
}, name: 'onButtonTappedProvider');

typedef OnBackBtnFn = void Function(BuildContext);
final onBackBtnTappedProvider = StateProvider<OnBackBtnFn>((ref) {
  return (context) {
    ref.read(userIdProvider.notifier).state = null;
    ref.read(displayNameProvider.notifier).state = null;
    ref.read(userPropertiesProvider.notifier).state = null;
    ref.read(sdkUserExtrasProvider.notifier).state = null;
    ref.read(appStateProvider.notifier).state = const AppState.initial();
    ref.read(messagesProvider.notifier).clear();
    ref.read(qiscusProvider.future).then((q) => q.clearUser());

    Navigator.of(context).pop();
  };
}, name: 'onBackBtnTappedProvider');
