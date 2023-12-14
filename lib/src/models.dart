import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' hide QAccount;

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

  static QMessageReply? tryParse(QMessage message) {
    if (message.type == QMessageType.custom &&
        message.payload?['type'] == 'reply') {
      return QMessageReply.fromMessage(message);
    }
    return null;
  }
}

class QMessageImage extends QMessage {
  static final fileRe = RegExp(r'(https?:\/\/.*\.(?:png|jpg|jpeg|gif))');
  late String url = fileRe.stringMatch(text)!;

  QMessageImage.fromMessage(QMessage message)
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

  static QMessageImage? tryParse(QMessage message) {
    var url = fileRe.stringMatch(message.text);
    if (message.type == QMessageType.attachment && url != null) {
      return QMessageImage.fromMessage(message);
    }

    return null;
  }
}

class QMessageVideo extends QMessage {
  static final fileRe = RegExp(r'(https?:\/\/.*\.(?:mp4|ogg|mkv|3gp|aac))');
  late final url = fileRe.stringMatch(text)!;

  QMessageVideo.fromMessage(QMessage message)
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

  static QMessageVideo? tryParse(QMessage message) {
    var url = fileRe.stringMatch(message.text);

    if (url != null) {
      message.type = QMessageType.attachment;
    }
    if (message.type == QMessageType.attachment && url != null) {
      return QMessageVideo.fromMessage(message);
    }

    return null;
  }
}

class QMessageFile extends QMessage {
  late final url = text //
      .replaceAll('[file]', '')
      .replaceAll('[/file]', '')
      .trim();

  QMessageFile.fromMessage(QMessage message)
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

  static QMessageFile? tryParse(QMessage message) {
    String? url;

    var containsFileTag =
        message.text.contains('[file]') && message.text.contains('[/file]');
    var isImage = QMessageImage.fileRe.hasMatch(message.text);
    var isVideo = QMessageVideo.fileRe.hasMatch(message.text);
    if (containsFileTag && !(isImage || isVideo)) {
      url = message.text
          .replaceAll('[file]', '')
          .replaceAll('[/file]', '')
          .trim();
    }

    if (url != null) {
      message.type = QMessageType.attachment;
    }
    if (message.type == QMessageType.attachment && url != null) {
      return QMessageFile.fromMessage(message);
    }

    return null;
  }
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

  static QMessageSystem? tryParse(QMessage message) {
    var type = message.type;
    var senderName = message.sender.name.isNotEmpty
        ? message.sender.name
        : message.payload?['object_username'] as String;

    if (type == QMessageType.custom && senderName.toLowerCase() == 'system') {
      return QMessageSystem.fromMessage(message);
    }
    return null;
  }
}
