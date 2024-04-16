import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:qiscus_multichannel_widget/src/providers/provider.dart';
import 'package:qiscus_multichannel_widget/src/widgets/chat_meta.dart';

import '../utils/build_message_area.dart';
import 'avatar.dart';

class QChatBubbleLeft extends ConsumerWidget {
  QChatBubbleLeft({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessage message;
  final fileRe = RegExp(r'(https?:\/\/.*\.(?:png|jpg|jpeg|gif))');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var avatarUrl = ref.watch(avatarConfigProvider).when<String?>(
          disabled: () => null,
          enabled: () => message.sender.avatarUrl,
          editable: (url) => url,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (avatarUrl != null)
            QAvatar(
              avatarUrl: avatarUrl,
            ),
          buildMessageArea(message),
          QChatMeta(
            timestamp: message.timestamp,
          ),
        ],
      ),
    );
  }
}
