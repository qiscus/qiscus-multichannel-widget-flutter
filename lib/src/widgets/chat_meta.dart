import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class QChatMeta extends ConsumerWidget {
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
        Icon(
          status == QMessageStatus.delivered || status == QMessageStatus.read
              ? Icons.done_all
              : Icons.done,
          size: 15,
          color: status == QMessageStatus.read
              ? theme.timeLabelTextColor
              : Colors.grey,
        ),
      ],
    );
  }
}
