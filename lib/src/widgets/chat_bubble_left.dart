import 'package:flutter/material.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:qiscus_multichannel_widget/src/widgets/avatar.dart';
import 'package:qiscus_multichannel_widget/src/widgets/chat_meta.dart';
import 'package:qiscus_multichannel_widget/src/widgets/chat_text.dart';

import 'chat_image.dart';

class QChatBubbleLeft extends StatelessWidget {
  QChatBubbleLeft({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessage message;
  final fileRe = RegExp(r'(https?:\/\/.*\.(?:png|jpg|jpeg|gif))');

  @override
  Widget build(BuildContext context) {
    var url = fileRe.stringMatch(message.text);
    print("URL: $url");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QAvatar(
            avatarUrl: message.sender.avatarUrl ??
                'https://via.placeholder.com/150x150',
          ),
          if (url != null) QChatImage(url: url),
          if (url == null) QChatText(message: message),
          QChatMeta(
            timestamp: message.timestamp,
            status: message.status,
          ),
        ],
      ),
    );
  }
}
