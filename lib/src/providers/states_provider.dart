part of 'provider.dart';

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

// Security Enhancement
final secureSessionProvider =
    StateProvider<SecureSession?>((_) => null, name: 'secureSessionProvider');

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

@freezed
class SecureSession with _$SecureSession {
  const factory SecureSession({
    required String appId,
    required String channelId,
    required String id,
    required String userId,
  }) = _SecureSession;

  factory SecureSession.fromJson(Map<String, dynamic> json) =>
      _$SecureSessionFromJson(json);
}
