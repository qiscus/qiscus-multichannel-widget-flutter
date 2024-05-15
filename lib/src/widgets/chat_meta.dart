import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../provider.dart';

class QChatMeta extends ConsumerWidget {
  const QChatMeta({
    super.key,
    required this.timestamp,
    this.status,
    this.isLeft = true,
  });

  final bool isLeft;
  final DateTime timestamp;
  final QMessageStatus? status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = ref.watch(appThemeConfigProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          formatDate(timestamp, [HH, ':', nn]),
          style: TextStyle(
            fontSize: 11,
            color: theme.timeLabelTextColor,
          ),
        ),
        if (status != null)
          Icon(
            status == QMessageStatus.delivered || status == QMessageStatus.read
                ? Icons.done_all
                : Icons.done,
            size: 15,
            color: status == QMessageStatus.read
                ? theme.rightBubbleColor
                : Colors.grey,
          ),
      ],
    );
  }
}
