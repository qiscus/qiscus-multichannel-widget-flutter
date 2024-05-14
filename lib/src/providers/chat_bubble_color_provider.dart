part of 'provider.dart';

@riverpod
Color chatBubbleFgColor(ChatBubbleFgColorRef ref, QUser sender) {
  var accountId = ref.watch(accountIdProvider);
  var theme = ref.watch(appThemeConfigProvider);
  if (accountId == sender.id) {
    return theme.rightBubbleTextColor;
  } else {
    return theme.leftBubbleTextColor;
  }
}

@riverpod
Color chatBubbleBgColor(ChatBubbleBgColorRef ref, QUser sender) {
  var accountId = ref.watch(accountIdProvider);
  var theme = ref.watch(appThemeConfigProvider);

  if (accountId == sender.id) {
    return theme.rightBubbleColor;
  } else {
    return theme.leftBubbleColor;
  }
}

@riverpod
Color bubbleTextColor(BubbleTextColorRef ref, String senderId) {
  final account = ref.watch(accountIdProvider)!;
  final theme = ref.watch(appThemeConfigProvider);

  if (account == senderId) {
    return theme.rightBubbleTextColor;
  } else {
    return theme.leftBubbleTextColor;
  }
}

@riverpod
Color bubbleBgColor(BubbleBgColorRef ref, String senderId) {
  final account = ref.watch(accountIdProvider)!;
  final theme = ref.watch(appThemeConfigProvider);

  if (account == senderId) {
    return theme.rightBubbleColor;
  } else {
    return theme.leftBubbleColor;
  }
}
