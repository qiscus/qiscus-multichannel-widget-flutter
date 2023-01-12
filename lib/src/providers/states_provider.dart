import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../config/avatar_config.dart';
import '../config/subtitle_config.dart';
import '../multichannel_provider.dart';
import '../states/app_state.dart';
import '../states/app_theme.dart';
import '../widgets/chat_buttons.dart';

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
final isResolvedProvider = StateProvider<bool>((_) => false);
final isSessionalProvider = StateProvider<bool>((_) => false);

typedef URLTapper = void Function(String);
typedef QButtonTapper = void Function(QMultichannel, QMessage, QButtons);
final onURLTappedProvider = StateProvider<URLTapper?>((_) => null);
final onButtonTappedProvider = StateProvider<QButtonTapper>((ref) {
  return (ref, message, button) async {
    print('is this called?');
    await button.next(ref);
  };
});
