// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QChatReplyPayload _$QChatReplyPayloadFromJson(Map<String, dynamic> json) {
  return _QChatReplyPayload.fromJson(json);
}

/// @nodoc
mixin _$QChatReplyPayload {
  @JsonKey(name: 'replied_comment_id')
  int get repliedCommentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'replied_comment_is_deleted')
  bool get repliedCommentDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'replied_comment_message')
  String get repliedCommentMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'replied_comment_payload')
  Map<String, Object?>? get repliedCommentPayload =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'replied_comment_sender_email')
  String get repliedCommentSenderEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'replied_comment_sender_username')
  String get repliedCommentSenderUsername => throw _privateConstructorUsedError;
  @JsonKey(name: 'replied_comment_type')
  String get repliedCommentType => throw _privateConstructorUsedError;
  @JsonKey(name: 'text')
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QChatReplyPayloadCopyWith<QChatReplyPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QChatReplyPayloadCopyWith<$Res> {
  factory $QChatReplyPayloadCopyWith(
          QChatReplyPayload value, $Res Function(QChatReplyPayload) then) =
      _$QChatReplyPayloadCopyWithImpl<$Res, QChatReplyPayload>;
  @useResult
  $Res call(
      {@JsonKey(name: 'replied_comment_id') int repliedCommentId,
      @JsonKey(name: 'replied_comment_is_deleted') bool repliedCommentDeleted,
      @JsonKey(name: 'replied_comment_message') String repliedCommentMessage,
      @JsonKey(name: 'replied_comment_payload')
      Map<String, Object?>? repliedCommentPayload,
      @JsonKey(name: 'replied_comment_sender_email')
      String repliedCommentSenderEmail,
      @JsonKey(name: 'replied_comment_sender_username')
      String repliedCommentSenderUsername,
      @JsonKey(name: 'replied_comment_type') String repliedCommentType,
      @JsonKey(name: 'text') String message});
}

/// @nodoc
class _$QChatReplyPayloadCopyWithImpl<$Res, $Val extends QChatReplyPayload>
    implements $QChatReplyPayloadCopyWith<$Res> {
  _$QChatReplyPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repliedCommentId = null,
    Object? repliedCommentDeleted = null,
    Object? repliedCommentMessage = null,
    Object? repliedCommentPayload = freezed,
    Object? repliedCommentSenderEmail = null,
    Object? repliedCommentSenderUsername = null,
    Object? repliedCommentType = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      repliedCommentId: null == repliedCommentId
          ? _value.repliedCommentId
          : repliedCommentId // ignore: cast_nullable_to_non_nullable
              as int,
      repliedCommentDeleted: null == repliedCommentDeleted
          ? _value.repliedCommentDeleted
          : repliedCommentDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      repliedCommentMessage: null == repliedCommentMessage
          ? _value.repliedCommentMessage
          : repliedCommentMessage // ignore: cast_nullable_to_non_nullable
              as String,
      repliedCommentPayload: freezed == repliedCommentPayload
          ? _value.repliedCommentPayload
          : repliedCommentPayload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      repliedCommentSenderEmail: null == repliedCommentSenderEmail
          ? _value.repliedCommentSenderEmail
          : repliedCommentSenderEmail // ignore: cast_nullable_to_non_nullable
              as String,
      repliedCommentSenderUsername: null == repliedCommentSenderUsername
          ? _value.repliedCommentSenderUsername
          : repliedCommentSenderUsername // ignore: cast_nullable_to_non_nullable
              as String,
      repliedCommentType: null == repliedCommentType
          ? _value.repliedCommentType
          : repliedCommentType // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QChatReplyPayloadCopyWith<$Res>
    implements $QChatReplyPayloadCopyWith<$Res> {
  factory _$$_QChatReplyPayloadCopyWith(_$_QChatReplyPayload value,
          $Res Function(_$_QChatReplyPayload) then) =
      __$$_QChatReplyPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'replied_comment_id') int repliedCommentId,
      @JsonKey(name: 'replied_comment_is_deleted') bool repliedCommentDeleted,
      @JsonKey(name: 'replied_comment_message') String repliedCommentMessage,
      @JsonKey(name: 'replied_comment_payload')
      Map<String, Object?>? repliedCommentPayload,
      @JsonKey(name: 'replied_comment_sender_email')
      String repliedCommentSenderEmail,
      @JsonKey(name: 'replied_comment_sender_username')
      String repliedCommentSenderUsername,
      @JsonKey(name: 'replied_comment_type') String repliedCommentType,
      @JsonKey(name: 'text') String message});
}

/// @nodoc
class __$$_QChatReplyPayloadCopyWithImpl<$Res>
    extends _$QChatReplyPayloadCopyWithImpl<$Res, _$_QChatReplyPayload>
    implements _$$_QChatReplyPayloadCopyWith<$Res> {
  __$$_QChatReplyPayloadCopyWithImpl(
      _$_QChatReplyPayload _value, $Res Function(_$_QChatReplyPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? repliedCommentId = null,
    Object? repliedCommentDeleted = null,
    Object? repliedCommentMessage = null,
    Object? repliedCommentPayload = freezed,
    Object? repliedCommentSenderEmail = null,
    Object? repliedCommentSenderUsername = null,
    Object? repliedCommentType = null,
    Object? message = null,
  }) {
    return _then(_$_QChatReplyPayload(
      repliedCommentId: null == repliedCommentId
          ? _value.repliedCommentId
          : repliedCommentId // ignore: cast_nullable_to_non_nullable
              as int,
      repliedCommentDeleted: null == repliedCommentDeleted
          ? _value.repliedCommentDeleted
          : repliedCommentDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      repliedCommentMessage: null == repliedCommentMessage
          ? _value.repliedCommentMessage
          : repliedCommentMessage // ignore: cast_nullable_to_non_nullable
              as String,
      repliedCommentPayload: freezed == repliedCommentPayload
          ? _value._repliedCommentPayload
          : repliedCommentPayload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
      repliedCommentSenderEmail: null == repliedCommentSenderEmail
          ? _value.repliedCommentSenderEmail
          : repliedCommentSenderEmail // ignore: cast_nullable_to_non_nullable
              as String,
      repliedCommentSenderUsername: null == repliedCommentSenderUsername
          ? _value.repliedCommentSenderUsername
          : repliedCommentSenderUsername // ignore: cast_nullable_to_non_nullable
              as String,
      repliedCommentType: null == repliedCommentType
          ? _value.repliedCommentType
          : repliedCommentType // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QChatReplyPayload implements _QChatReplyPayload {
  const _$_QChatReplyPayload(
      {@JsonKey(name: 'replied_comment_id') required this.repliedCommentId,
      @JsonKey(name: 'replied_comment_is_deleted')
      required this.repliedCommentDeleted,
      @JsonKey(name: 'replied_comment_message')
      required this.repliedCommentMessage,
      @JsonKey(name: 'replied_comment_payload')
      final Map<String, Object?>? repliedCommentPayload,
      @JsonKey(name: 'replied_comment_sender_email')
      required this.repliedCommentSenderEmail,
      @JsonKey(name: 'replied_comment_sender_username')
      required this.repliedCommentSenderUsername,
      @JsonKey(name: 'replied_comment_type') required this.repliedCommentType,
      @JsonKey(name: 'text') required this.message})
      : _repliedCommentPayload = repliedCommentPayload;

  factory _$_QChatReplyPayload.fromJson(Map<String, dynamic> json) =>
      _$$_QChatReplyPayloadFromJson(json);

  @override
  @JsonKey(name: 'replied_comment_id')
  final int repliedCommentId;
  @override
  @JsonKey(name: 'replied_comment_is_deleted')
  final bool repliedCommentDeleted;
  @override
  @JsonKey(name: 'replied_comment_message')
  final String repliedCommentMessage;
  final Map<String, Object?>? _repliedCommentPayload;
  @override
  @JsonKey(name: 'replied_comment_payload')
  Map<String, Object?>? get repliedCommentPayload {
    final value = _repliedCommentPayload;
    if (value == null) return null;
    if (_repliedCommentPayload is EqualUnmodifiableMapView)
      return _repliedCommentPayload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'replied_comment_sender_email')
  final String repliedCommentSenderEmail;
  @override
  @JsonKey(name: 'replied_comment_sender_username')
  final String repliedCommentSenderUsername;
  @override
  @JsonKey(name: 'replied_comment_type')
  final String repliedCommentType;
  @override
  @JsonKey(name: 'text')
  final String message;

  @override
  String toString() {
    return 'QChatReplyPayload(repliedCommentId: $repliedCommentId, repliedCommentDeleted: $repliedCommentDeleted, repliedCommentMessage: $repliedCommentMessage, repliedCommentPayload: $repliedCommentPayload, repliedCommentSenderEmail: $repliedCommentSenderEmail, repliedCommentSenderUsername: $repliedCommentSenderUsername, repliedCommentType: $repliedCommentType, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QChatReplyPayload &&
            (identical(other.repliedCommentId, repliedCommentId) ||
                other.repliedCommentId == repliedCommentId) &&
            (identical(other.repliedCommentDeleted, repliedCommentDeleted) ||
                other.repliedCommentDeleted == repliedCommentDeleted) &&
            (identical(other.repliedCommentMessage, repliedCommentMessage) ||
                other.repliedCommentMessage == repliedCommentMessage) &&
            const DeepCollectionEquality()
                .equals(other._repliedCommentPayload, _repliedCommentPayload) &&
            (identical(other.repliedCommentSenderEmail,
                    repliedCommentSenderEmail) ||
                other.repliedCommentSenderEmail == repliedCommentSenderEmail) &&
            (identical(other.repliedCommentSenderUsername,
                    repliedCommentSenderUsername) ||
                other.repliedCommentSenderUsername ==
                    repliedCommentSenderUsername) &&
            (identical(other.repliedCommentType, repliedCommentType) ||
                other.repliedCommentType == repliedCommentType) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      repliedCommentId,
      repliedCommentDeleted,
      repliedCommentMessage,
      const DeepCollectionEquality().hash(_repliedCommentPayload),
      repliedCommentSenderEmail,
      repliedCommentSenderUsername,
      repliedCommentType,
      message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QChatReplyPayloadCopyWith<_$_QChatReplyPayload> get copyWith =>
      __$$_QChatReplyPayloadCopyWithImpl<_$_QChatReplyPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QChatReplyPayloadToJson(
      this,
    );
  }
}

abstract class _QChatReplyPayload implements QChatReplyPayload {
  const factory _QChatReplyPayload(
      {@JsonKey(name: 'replied_comment_id') required final int repliedCommentId,
      @JsonKey(name: 'replied_comment_is_deleted')
      required final bool repliedCommentDeleted,
      @JsonKey(name: 'replied_comment_message')
      required final String repliedCommentMessage,
      @JsonKey(name: 'replied_comment_payload')
      final Map<String, Object?>? repliedCommentPayload,
      @JsonKey(name: 'replied_comment_sender_email')
      required final String repliedCommentSenderEmail,
      @JsonKey(name: 'replied_comment_sender_username')
      required final String repliedCommentSenderUsername,
      @JsonKey(name: 'replied_comment_type')
      required final String repliedCommentType,
      @JsonKey(name: 'text')
      required final String message}) = _$_QChatReplyPayload;

  factory _QChatReplyPayload.fromJson(Map<String, dynamic> json) =
      _$_QChatReplyPayload.fromJson;

  @override
  @JsonKey(name: 'replied_comment_id')
  int get repliedCommentId;
  @override
  @JsonKey(name: 'replied_comment_is_deleted')
  bool get repliedCommentDeleted;
  @override
  @JsonKey(name: 'replied_comment_message')
  String get repliedCommentMessage;
  @override
  @JsonKey(name: 'replied_comment_payload')
  Map<String, Object?>? get repliedCommentPayload;
  @override
  @JsonKey(name: 'replied_comment_sender_email')
  String get repliedCommentSenderEmail;
  @override
  @JsonKey(name: 'replied_comment_sender_username')
  String get repliedCommentSenderUsername;
  @override
  @JsonKey(name: 'replied_comment_type')
  String get repliedCommentType;
  @override
  @JsonKey(name: 'text')
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_QChatReplyPayloadCopyWith<_$_QChatReplyPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
