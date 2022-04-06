import 'package:flutter/widgets.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../models.dart';
import '../widgets/chat_image.dart';
import '../widgets/chat_system.dart';
import '../widgets/chat_text.dart';

final fileRe = RegExp(r'(https?:\/\/.*\.(?:png|jpg|jpeg|gif))');

Widget buildMessageArea(QMessage message) {
  var url = fileRe.stringMatch(message.text);

  switch (message.runtimeType) {
    case QMessageSystem:
      return QChatSystem(message: message);
    case QMessageAttachment:
      return QChatImage(
        message: message,
        url: (message as QMessageAttachment).url,
      );
    default:
      return QChatText(message: message);
  }
}
