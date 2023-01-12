import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import 'account_provider.dart';
import 'states_provider.dart';

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
