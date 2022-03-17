import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class QChatText extends StatelessWidget {
  const QChatText({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessage message;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Text(
              message.text,
              style: const TextStyle(
                color: Colors.white,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
