import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:qiscus_multichannel_widget/src/utils/colors.dart';

class QChatMeta extends StatelessWidget {
  const QChatMeta({
    Key? key,
    required this.timestamp,
    required this.status,
    this.isLeft = true,
  }) : super(key: key);

  final bool isLeft;
  final DateTime timestamp;
  final QMessageStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          formatDate(timestamp, ['HH', ':', 'mm']),
          style: TextStyle(
            fontSize: 11,
            color: "#adadad".toColor(),
          ),
        ),
        Icon(
          status == QMessageStatus.delivered || status == QMessageStatus.read
              ? Icons.done_all
              : Icons.done,
          size: 15,
          color: status == QMessageStatus.read
              ? Theme.of(context).primaryColor
              : Colors.grey,
        ),
      ],
    );
  }
}
