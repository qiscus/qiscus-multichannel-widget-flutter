// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SecureSession _$SecureSessionFromJson(Map<String, dynamic> json) {
  return _SecureSession.fromJson(json);
}

/// @nodoc
mixin _$SecureSession {
  String get appId => throw _privateConstructorUsedError;
  String get channelId => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SecureSessionCopyWith<SecureSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecureSessionCopyWith<$Res> {
  factory $SecureSessionCopyWith(
          SecureSession value, $Res Function(SecureSession) then) =
      _$SecureSessionCopyWithImpl<$Res, SecureSession>;
  @useResult
  $Res call({String appId, String channelId, String id, String userId});
}

/// @nodoc
class _$SecureSessionCopyWithImpl<$Res, $Val extends SecureSession>
    implements $SecureSessionCopyWith<$Res> {
  _$SecureSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appId = null,
    Object? channelId = null,
    Object? id = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      appId: null == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SecureSessionCopyWith<$Res>
    implements $SecureSessionCopyWith<$Res> {
  factory _$$_SecureSessionCopyWith(
          _$_SecureSession value, $Res Function(_$_SecureSession) then) =
      __$$_SecureSessionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appId, String channelId, String id, String userId});
}

/// @nodoc
class __$$_SecureSessionCopyWithImpl<$Res>
    extends _$SecureSessionCopyWithImpl<$Res, _$_SecureSession>
    implements _$$_SecureSessionCopyWith<$Res> {
  __$$_SecureSessionCopyWithImpl(
      _$_SecureSession _value, $Res Function(_$_SecureSession) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appId = null,
    Object? channelId = null,
    Object? id = null,
    Object? userId = null,
  }) {
    return _then(_$_SecureSession(
      appId: null == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
      channelId: null == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SecureSession implements _SecureSession {
  const _$_SecureSession(
      {required this.appId,
      required this.channelId,
      required this.id,
      required this.userId});

  factory _$_SecureSession.fromJson(Map<String, dynamic> json) =>
      _$$_SecureSessionFromJson(json);

  @override
  final String appId;
  @override
  final String channelId;
  @override
  final String id;
  @override
  final String userId;

  @override
  String toString() {
    return 'SecureSession(appId: $appId, channelId: $channelId, id: $id, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SecureSession &&
            (identical(other.appId, appId) || other.appId == appId) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, appId, channelId, id, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SecureSessionCopyWith<_$_SecureSession> get copyWith =>
      __$$_SecureSessionCopyWithImpl<_$_SecureSession>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SecureSessionToJson(
      this,
    );
  }
}

abstract class _SecureSession implements SecureSession {
  const factory _SecureSession(
      {required final String appId,
      required final String channelId,
      required final String id,
      required final String userId}) = _$_SecureSession;

  factory _SecureSession.fromJson(Map<String, dynamic> json) =
      _$_SecureSession.fromJson;

  @override
  String get appId;
  @override
  String get channelId;
  @override
  String get id;
  @override
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$_SecureSessionCopyWith<_$_SecureSession> get copyWith =>
      throw _privateConstructorUsedError;
}
