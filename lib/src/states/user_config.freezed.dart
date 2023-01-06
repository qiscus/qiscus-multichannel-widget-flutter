// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
      _$QUserConfigCopyWithImpl<$Res, QUserConfig>;
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      Map<String, dynamic>? userProperties});
}

/// @nodoc
class _$QUserConfigCopyWithImpl<$Res, $Val extends QUserConfig>
    implements $QUserConfigCopyWith<$Res> {
  _$QUserConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? userProperties = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userProperties: freezed == userProperties
          ? _value.userProperties
          : userProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QUserConfigCopyWith<$Res>
    implements $QUserConfigCopyWith<$Res> {
  factory _$$_QUserConfigCopyWith(
          _$_QUserConfig value, $Res Function(_$_QUserConfig) then) =
      __$$_QUserConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String displayName,
      String? avatarUrl,
      Map<String, dynamic>? userProperties});
}

/// @nodoc
class __$$_QUserConfigCopyWithImpl<$Res>
    extends _$QUserConfigCopyWithImpl<$Res, _$_QUserConfig>
    implements _$$_QUserConfigCopyWith<$Res> {
  __$$_QUserConfigCopyWithImpl(
      _$_QUserConfig _value, $Res Function(_$_QUserConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? userProperties = freezed,
  }) {
    return _then(_$_QUserConfig(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userProperties: freezed == userProperties
          ? _value._userProperties
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
      final Map<String, dynamic>? userProperties})
      : _userProperties = userProperties;

  @override
  final String userId;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
  final Map<String, dynamic>? _userProperties;
  @override
  Map<String, dynamic>? get userProperties {
    final value = _userProperties;
    if (value == null) return null;
    if (_userProperties is EqualUnmodifiableMapView) return _userProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'QUserConfig(userId: $userId, displayName: $displayName, avatarUrl: $avatarUrl, userProperties: $userProperties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QUserConfig &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            const DeepCollectionEquality()
                .equals(other._userProperties, _userProperties));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, displayName, avatarUrl,
      const DeepCollectionEquality().hash(_userProperties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QUserConfigCopyWith<_$_QUserConfig> get copyWith =>
      __$$_QUserConfigCopyWithImpl<_$_QUserConfig>(this, _$identity);
}

abstract class _QUserConfig implements QUserConfig {
  const factory _QUserConfig(
      {required final String userId,
      required final String displayName,
      final String? avatarUrl,
      final Map<String, dynamic>? userProperties}) = _$_QUserConfig;

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
  _$$_QUserConfigCopyWith<_$_QUserConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
