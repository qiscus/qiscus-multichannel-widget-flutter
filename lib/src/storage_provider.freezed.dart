// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$QLocalUserDataCopyWithImpl<$Res>;
  $Res call({String? appId, int? roomId, String? token, QAccount? account});
}

/// @nodoc
class _$QLocalUserDataCopyWithImpl<$Res>
    implements $QLocalUserDataCopyWith<$Res> {
  _$QLocalUserDataCopyWithImpl(this._value, this._then);

  final QLocalUserData _value;
  // ignore: unused_field
  final $Res Function(QLocalUserData) _then;

  @override
  $Res call({
    Object? appId = freezed,
    Object? roomId = freezed,
    Object? token = freezed,
    Object? account = freezed,
  }) {
    return _then(_value.copyWith(
      appId: appId == freezed
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int?,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as QAccount?,
    ));
  }
}

/// @nodoc
abstract class _$$_QLocalUserDataCopyWith<$Res>
    implements $QLocalUserDataCopyWith<$Res> {
  factory _$$_QLocalUserDataCopyWith(
          _$_QLocalUserData value, $Res Function(_$_QLocalUserData) then) =
      __$$_QLocalUserDataCopyWithImpl<$Res>;
  @override
  $Res call({String? appId, int? roomId, String? token, QAccount? account});
}

/// @nodoc
class __$$_QLocalUserDataCopyWithImpl<$Res>
    extends _$QLocalUserDataCopyWithImpl<$Res>
    implements _$$_QLocalUserDataCopyWith<$Res> {
  __$$_QLocalUserDataCopyWithImpl(
      _$_QLocalUserData _value, $Res Function(_$_QLocalUserData) _then)
      : super(_value, (v) => _then(v as _$_QLocalUserData));

  @override
  _$_QLocalUserData get _value => super._value as _$_QLocalUserData;

  @override
  $Res call({
    Object? appId = freezed,
    Object? roomId = freezed,
    Object? token = freezed,
    Object? account = freezed,
  }) {
    return _then(_$_QLocalUserData(
      appId: appId == freezed
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String?,
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int?,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      account: account == freezed
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
            const DeepCollectionEquality().equals(other.appId, appId) &&
            const DeepCollectionEquality().equals(other.roomId, roomId) &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality().equals(other.account, account));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appId),
      const DeepCollectionEquality().hash(roomId),
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(account));

  @JsonKey(ignore: true)
  @override
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
  String? get appId => throw _privateConstructorUsedError;
  @override
  int? get roomId => throw _privateConstructorUsedError;
  @override
  String? get token => throw _privateConstructorUsedError;
  @override
  QAccount? get account => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QLocalUserDataCopyWith<_$_QLocalUserData> get copyWith =>
      throw _privateConstructorUsedError;
}
