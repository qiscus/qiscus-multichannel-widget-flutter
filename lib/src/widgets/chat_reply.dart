import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';
import '../provider.dart';
import '../utils/generate_link_text.dart';

part 'chat_reply.freezed.dart';
part 'chat_reply.g.dart';

class QChatReply extends ConsumerWidget {
  const QChatReply({
    super.key,
    required this.message,
  });

  final QMessageReply message;

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    var payload = QChatReplyPayload.fromJson(message.payload!);

    final bgColor = _getBgColor(ref);
    final fgColor = _getFgColor(ref);
    var replyBoxColor = _getReplyBoxColor(ref);
    var replyTextColor = _getReplyTextColor(ref);

    return _buildContainer(
      size: size,
      bgColor: bgColor,
      fgColor: fgColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: replyBoxColor,
              borderRadius: const BorderRadius.all(Radius.circular(3)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _processRepliedMessage(payload.repliedCommentMessage),
                style: TextStyle(
                  color: replyTextColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SizedBox(
              width: double.infinity,
              child: RichLinkText(
                text: message.text,
                sender: message.sender,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer({
    required Size size,
    required Color bgColor,
    required Color fgColor,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Color _getBgColor(WidgetRef ref) {
    var account = ref.read(accountProvider).value!;
    var theme = ref.read(appThemeConfigProvider);

    if (account.id == message.sender.id) {
      return theme.rightBubbleColor;
    } else {
      return theme.leftBubbleColor;
    }
  }

  Color _getFgColor(WidgetRef ref) {
    var account = ref.read(accountProvider).value!;
    var theme = ref.read(appThemeConfigProvider);

    if (account.id == message.sender.id) {
      return theme.rightBubbleTextColor;
    } else {
      return theme.leftBubbleTextColor;
    }
  }

  String _processRepliedMessage(String repliedCommentMessage) {
    if (repliedCommentMessage.startsWith('[file]')) {
      return 'File attachment';
    }
    return repliedCommentMessage;
  }

  Color _getReplyBoxColor(WidgetRef ref) {
    var account = ref.read(accountProvider).requireValue;
    var theme = ref.read(appThemeConfigProvider);

    if (account.id == message.sender.id) {
      return theme.rightBubbleReplyBoxColor;
    } else {
      return theme.leftBubbleReplyBoxColor;
    }
  }

  Color _getReplyTextColor(WidgetRef ref) {
    var account = ref.read(accountProvider).requireValue;
    var theme = ref.read(appThemeConfigProvider);

    if (account.id == message.sender.id) {
      return theme.rightBubbleReplyTextColor;
    } else {
      return theme.leftBubbleReplyTextColor;
    }
  }
}

@freezed
class QChatReplyPayload with _$QChatReplyPayload {
  const factory QChatReplyPayload({
    @JsonKey(name: 'replied_comment_id') required int repliedCommentId,
    @JsonKey(name: 'replied_comment_is_deleted')
    required bool repliedCommentDeleted,
    @JsonKey(name: 'replied_comment_message')
    required String repliedCommentMessage,
    @JsonKey(name: 'replied_comment_payload')
    Map<String, Object?>? repliedCommentPayload,
    @JsonKey(name: 'replied_comment_sender_email')
    required String repliedCommentSenderEmail,
    @JsonKey(name: 'replied_comment_sender_username')
    required String repliedCommentSenderUsername,
    @JsonKey(name: 'replied_comment_type') required String repliedCommentType,
    @JsonKey(name: 'text') required String message,
  }) = _QChatReplyPayload;

  factory QChatReplyPayload.fromJson(Map<String, Object?> json) =>
      _$QChatReplyPayloadFromJson(json);
}
