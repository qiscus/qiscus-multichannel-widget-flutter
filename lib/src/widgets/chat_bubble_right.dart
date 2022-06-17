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
    var avatarConfig = ref.watch(avatarConfigProvider);
    var senderAvatar = message.sender.avatarUrl;

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
          avatarConfig.maybeWhen(
            orElse: () => senderAvatar != null
                ? QAvatar(avatarUrl: senderAvatar)
                : Container(),
            disabled: () => Container(),
          ),
        ],
      ),
    );
  }
}
