// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_parameter, unused_element

part of 'chat_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QChatReplyPayload _$$_QChatReplyPayloadFromJson(Map<String, dynamic> json) =>
    _$_QChatReplyPayload(
      repliedCommentId: json['replied_comment_id'] as int,
      repliedCommentDeleted: json['replied_comment_is_deleted'] as bool,
      repliedCommentMessage: json['replied_comment_message'] as String,
      repliedCommentPayload:
          json['replied_comment_payload'] as Map<String, dynamic>?,
      repliedCommentSenderEmail: json['replied_comment_sender_email'] as String,
      repliedCommentSenderUsername:
          json['replied_comment_sender_username'] as String,
      repliedCommentType: json['replied_comment_type'] as String,
      message: json['text'] as String,
    );

Map<String, dynamic> _$$_QChatReplyPayloadToJson(
        _$_QChatReplyPayload instance) =>
    <String, dynamic>{
      'replied_comment_id': instance.repliedCommentId,
      'replied_comment_is_deleted': instance.repliedCommentDeleted,
      'replied_comment_message': instance.repliedCommentMessage,
      'replied_comment_payload': instance.repliedCommentPayload,
      'replied_comment_sender_email': instance.repliedCommentSenderEmail,
      'replied_comment_sender_username': instance.repliedCommentSenderUsername,
      'replied_comment_type': instance.repliedCommentType,
      'text': instance.message,
    };
