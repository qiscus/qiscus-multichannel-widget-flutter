import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:qiscus_multichannel_widget/src/utils/build_message_area.dart';
import 'package:qiscus_multichannel_widget/src/widgets/avatar.dart';
import 'package:qiscus_multichannel_widget/src/widgets/chat_meta.dart';

import '../provider.dart';

class QChatBubbleRight extends ConsumerWidget {
  const QChatBubbleRight({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessage message;

  @override
  Widget build(BuildContext context, ref) {
    var avatarUrl = ref.watch(rightAvatarConfigProvider).when<String?>(
          disabled: () => null,
          enabled: () => message.sender.avatarUrl,
          editable: (url) => url,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QChatMeta(
            timestamp: message.timestamp,
            status: message.status,
            isLeft: false,
          ),
          buildMessageArea(message),
          if (avatarUrl != null) QAvatar(avatarUrl: avatarUrl)
        ],
      ),
    );
  }
}

class QChatBubbleRightEmpty extends ConsumerWidget {
  const QChatBubbleRightEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var bgColor = Colors.black.withOpacity(0.2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: size.width * 0.6,
                decoration: BoxDecoration(
                  color: bgColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  child: SizedBox(
                    height: 20,
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              color: bgColor,
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
