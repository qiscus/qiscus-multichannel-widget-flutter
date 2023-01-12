import 'package:flutter/material.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import '../multichannel_provider.dart';
import '../utils/generate_link_text.dart';

class QChatText extends StatelessWidget {
  const QChatText({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessage message;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return QMultichannelConsumer(
      builder: (context, ref) {
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
      },
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

  Color _getBgColor(QMultichannel ref) {
    final account = ref.account.value!;
    if (account.id == message.sender.id) {
      return ref.theme.rightBubbleColor;
    } else {
      return ref.theme.leftBubbleColor;
    }
  }

  Color _getFgColor(QMultichannel ref) {
    final account = ref.account.value!;
    if (account.id == message.sender.id) {
      return ref.theme.rightBubbleTextColor;
    } else {
      return ref.theme.leftBubbleTextColor;
    }
  }
}
