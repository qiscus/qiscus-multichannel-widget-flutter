import 'package:flutter/material.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../utils/colors.dart';

class QChatSystem extends StatelessWidget {
  const QChatSystem({
    super.key,
    required this.message,
  });

  final QMessage message;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      // padding: const EdgeInsets.only(left: 10, right: 5, top: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: size.width * 0.4,
          // width: 100,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: '#01416C'.toColor(),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Text(
              message.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: '#01416C'.toColor(),
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
