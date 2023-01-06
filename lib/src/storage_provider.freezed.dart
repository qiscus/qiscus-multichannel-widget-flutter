// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QLocalUserData {
  String? get appId => throw _privateConstructorUsedError;
  int? get roomId => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  QAccount? get account => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QLocalUserDataCopyWith<QLocalUserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QLocalUserDataCopyWith<$Res> {
  factory $QLocalUserDataCopyWith(
          QLocalUserData value, $Res Function(QLocalUserData) then) =
      _$QLocalUserDataCopyWithImpl<$Res, QLocalUserData>;
  @useResult
  $Res call({String? appId, int? roomId, String? token, QAccount? account});
}

/// @nodoc
class _$QLocalUserDataCopyWithImpl<$Res, $Val extends QLocalUserData>
    implements $QLocalUserDataCopyWith<$Res> {
  _$QLocalUserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appId = freezed,
    Object? roomId = freezed,
    Object? token = freezed,
    Object? account = freezed,
  }) {
    return _then(_value.copyWith(
      appId: freezed == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as QAccount?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QLocalUserDataCopyWith<$Res>
    implements $QLocalUserDataCopyWith<$Res> {
  factory _$$_QLocalUserDataCopyWith(
          _$_QLocalUserData value, $Res Function(_$_QLocalUserData) then) =
      __$$_QLocalUserDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? appId, int? roomId, String? token, QAccount? account});
}

/// @nodoc
class __$$_QLocalUserDataCopyWithImpl<$Res>
    extends _$QLocalUserDataCopyWithImpl<$Res, _$_QLocalUserData>
    implements _$$_QLocalUserDataCopyWith<$Res> {
  __$$_QLocalUserDataCopyWithImpl(
      _$_QLocalUserData _value, $Res Function(_$_QLocalUserData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appId = freezed,
    Object? roomId = freezed,
    Object? token = freezed,
    Object? account = freezed,
  }) {
    return _then(_$_QLocalUserData(
      appId: freezed == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: freezed == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as QAccount?,
    ));
  }
}

/// @nodoc

class _$_QLocalUserData implements _QLocalUserData {
  const _$_QLocalUserData(
      {required this.appId,
      required this.roomId,
      required this.token,
      required this.account});

  @override
  final String? appId;
  @override
  final int? roomId;
  @override
  final String? token;
  @override
  final QAccount? account;

  @override
  String toString() {
    return 'QLocalUserData(appId: $appId, roomId: $roomId, token: $token, account: $account)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QLocalUserData &&
            (identical(other.appId, appId) || other.appId == appId) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, appId, roomId, token, account);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QLocalUserDataCopyWith<_$_QLocalUserData> get copyWith =>
      __$$_QLocalUserDataCopyWithImpl<_$_QLocalUserData>(this, _$identity);
}

abstract class _QLocalUserData implements QLocalUserData {
  const factory _QLocalUserData(
      {required final String? appId,
      required final int? roomId,
      required final String? token,
      required final QAccount? account}) = _$_QLocalUserData;

  @override
  String? get appId;
  @override
  int? get roomId;
  @override
  String? get token;
  @override
  QAccount? get account;
  @override
  @JsonKey(ignore: true)
  _$$_QLocalUserDataCopyWith<_$_QLocalUserData> get copyWith =>
      throw _privateConstructorUsedError;
}
