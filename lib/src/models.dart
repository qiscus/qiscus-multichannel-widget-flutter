import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

class QMessageText extends QMessage {
  QMessageText({
    required int id,
    required int chatRoomId,
    required int previousMessageId,
    required String uniqueId,
    required String text,
    required QMessageStatus status,
    required QMessageType type,
    required Map<String, dynamic>? extras,
    required Map<String, dynamic>? payload,
    required QUser sender,
    required DateTime timestamp,
  }) : super(
          id: id,
          chatRoomId: chatRoomId,
          previousMessageId: previousMessageId,
          uniqueId: uniqueId,
          text: text,
          status: status,
          type: type,
          extras: extras,
          payload: payload,
          sender: sender,
          timestamp: timestamp,
        );
}

class QMessageReply extends QMessage {
  QMessageReply.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );
}

class QMessageAttachment extends QMessage {
  final fileRe = RegExp(r'(https?:\/\/.*\.(?:png|jpg|jpeg|gif))');
  late String url = fileRe.stringMatch(text)!;

  QMessageAttachment.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );
}

class QMessageSystem extends QMessage {
  QMessageSystem.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );
}
