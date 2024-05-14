import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../provider.dart';
import '../utils/generate_link_text.dart';

class QChatText extends ConsumerWidget {
  const QChatText({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessage message;

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    final bgColor = _getBgColor(ref);
    final fgColor = _getFgColor(ref);

    return _buildContainer(
      size: size,
      bgColor: bgColor,
      fgColor: fgColor,
      child: RichLinkText(
        text: message.text,
        sender: message.sender,
      ),
    );
  }

  Widget _buildContainer({
    required Size size,
    required Color bgColor,
    required Color fgColor,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Color _getBgColor(WidgetRef ref) {
    final account = ref.read(accountProvider).requireValue;
    final theme = ref.read(appThemeConfigProvider);
    if (account.id == message.sender.id) {
      return theme.rightBubbleColor;
    } else {
      return theme.leftBubbleColor;
    }
  }

  Color _getFgColor(WidgetRef ref) {
    final account = ref.read(accountProvider).requireValue;
    final theme = ref.read(appThemeConfigProvider);

    if (account.id == message.sender.id) {
      return theme.rightBubbleTextColor;
    } else {
      return theme.leftBubbleTextColor;
    }
  }
}
