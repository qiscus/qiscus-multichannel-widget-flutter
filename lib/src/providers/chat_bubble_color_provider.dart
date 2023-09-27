part of 'provider.dart';

final chatBubbleFgColorProvider =
    Provider.autoDispose.family((ref, QUser sender) {
  var accountId = ref.watch(accountIdProvider);
  var theme = ref.watch(appThemeConfigProvider);
  if (accountId == sender.id) {
    return theme.rightBubbleTextColor;
  } else {
    return theme.leftBubbleTextColor;
  }
});

final chatBubbleBgColorProvider =
    Provider.autoDispose.family((ref, QUser sender) {
  var accountId = ref.watch(accountIdProvider);
  var theme = ref.watch(appThemeConfigProvider);

  if (accountId == sender.id) {
    return theme.rightBubbleColor;
  } else {
    return theme.leftBubbleColor;
  }
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
