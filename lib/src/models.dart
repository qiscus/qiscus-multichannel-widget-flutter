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
    if (message.type == QMessageType.reply) {
      return QMessageReply.fromMessage(message);
    }
    return null;
  }

  QMessageReplyPayload get typedPayload {
    return QMessageReplyPayload(payload!);
  }
}

class QMessageReplyPayload {
  QMessageReplyPayload(Map<String, Object?> payload)
      : repliedCommentId = payload['replied_comment_id'] as int,
        repliedCommentIsDeleted = payload['replied_comment_is_deleted'] as bool,
        repliedCommentPayload =
            payload['replied_comment_payload'] as Map<String, Object?>?,
        repliedCommentSenderEmail =
            payload['replied_comment_sender_email'] as String,
        repliedCommentSenderUsername =
            payload['replied_comment_sender_username'] as String,
        repliedCommentType = payload['replied_comment_type'] as String,
        repliedCommentMessage = payload['replied_comment_message'] as String,
        message = payload['text'] as String;

  final int repliedCommentId;
  final bool repliedCommentIsDeleted;
  final String repliedCommentMessage;
  final Map<String, Object?>? repliedCommentPayload;
  final String repliedCommentSenderEmail;
  final String repliedCommentSenderUsername;
  final String repliedCommentType;
  final String message;
  // 0 = {map entry} "replied_comment_id" -> 2028902450
  // 1 = {map entry} "replied_comment_is_deleted" -> false
  // 2 = {map entry} "replied_comment_message" -> "lagi?"
  // 3 = {map entry} "replied_comment_payload" -> [_Map]
  // 4 = {map entry} "replied_comment_sender_email" -> "guest-1001"
  // 5 = {map entry} "replied_comment_sender_username" -> "guest-1001"
  // 6 = {map entry} "replied_comment_type" -> "text"
  // 7 = {map entry} "text" -> "ada yang bisa dibantu?"
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
