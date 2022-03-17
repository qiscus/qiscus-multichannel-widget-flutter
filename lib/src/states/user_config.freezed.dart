// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$QUserConfigTearOff {
  const _$QUserConfigTearOff();

  _QUserConfig call(
      {required String userId,
      required String displayName,
      String? avatarUrl,
      Map<String, dynamic>? userProperties}) {
    return _QUserConfig(
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      userProperties: userProperties,
    );
  }
}

/// @nodoc
const $QUserConfig = _$QUserConfigTearOff();

/// @nodoc
mixin _$QUserConfig {
  String get userId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get userProperties =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QUserConfigCopyWith<QUserConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QUserConfigCopyWith<$Res> {
  factory $QUserConfigCopyWith(
          QUserConfig value, $Res Function(QUserConfig) then) =
      _$QUserConfigCopyWithImpl<$Res>;
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      Map<String, dynamic>? userProperties});
}

/// @nodoc
class _$QUserConfigCopyWithImpl<$Res> implements $QUserConfigCopyWith<$Res> {
  _$QUserConfigCopyWithImpl(this._value, this._then);

  final QUserConfig _value;
  // ignore: unused_field
  final $Res Function(QUserConfig) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? userProperties = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userProperties: userProperties == freezed
          ? _value.userProperties
          : userProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
abstract class _$QUserConfigCopyWith<$Res>
    implements $QUserConfigCopyWith<$Res> {
  factory _$QUserConfigCopyWith(
          _QUserConfig value, $Res Function(_QUserConfig) then) =
      __$QUserConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      Map<String, dynamic>? userProperties});
}

/// @nodoc
class __$QUserConfigCopyWithImpl<$Res> extends _$QUserConfigCopyWithImpl<$Res>
    implements _$QUserConfigCopyWith<$Res> {
  __$QUserConfigCopyWithImpl(
      _QUserConfig _value, $Res Function(_QUserConfig) _then)
      : super(_value, (v) => _then(v as _QUserConfig));

  @override
  _QUserConfig get _value => super._value as _QUserConfig;

  @override
  $Res call({
    Object? userId = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? userProperties = freezed,
  }) {
    return _then(_QUserConfig(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: avatarUrl == freezed
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userProperties: userProperties == freezed
          ? _value.userProperties
          : userProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$_QUserConfig implements _QUserConfig {
  const _$_QUserConfig(
      {required this.userId,
      required this.displayName,
      this.avatarUrl,
      this.userProperties});

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  @override
  final Map<String, dynamic>? userProperties;

  @override
  String toString() {
    return 'QUserConfig(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, userProperties: $userProperties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QUserConfig &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.avatarUrl, avatarUrl) &&
            const DeepCollectionEquality()
                .equals(other.userProperties, userProperties));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(avatarUrl),
      const DeepCollectionEquality().hash(userProperties));

  @JsonKey(ignore: true)
  @override
  _$QUserConfigCopyWith<_QUserConfig> get copyWith =>
      __$QUserConfigCopyWithImpl<_QUserConfig>(this, _$identity);
}

abstract class _QUserConfig implements QUserConfig {
  const factory _QUserConfig(
      {required String userId,
      required String displayName,
      String? avatarUrl,
      Map<String, dynamic>? userProperties}) = _$_QUserConfig;

  @override
  String get userId;
  @override
  String get displayName;
  @override
  String? get avatarUrl;
  @override
  Map<String, dynamic>? get userProperties;
  @override
  @JsonKey(ignore: true)
  _$QUserConfigCopyWith<_QUserConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
