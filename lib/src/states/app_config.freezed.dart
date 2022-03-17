// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$QAppConfigTearOff {
  const _$QAppConfigTearOff();

  _QAppConfig call(
      {String baseUrl = 'https://multichannel.qiscus.com',
      String? title,
      QSubtitleConfig? subtitle,
      QAvatarConfig? avatar,
      String? channelId,
      String? deviceId,
      bool showSystemEvent = true,
      bool showSenderAvatar = true}) {
    return _QAppConfig(
      baseUrl: baseUrl,
      title: title,
      subtitle: subtitle,
      avatar: avatar,
      channelId: channelId,
      deviceId: deviceId,
      showSystemEvent: showSystemEvent,
      showSenderAvatar: showSenderAvatar,
    );
  }
}

/// @nodoc
const $QAppConfig = _$QAppConfigTearOff();

/// @nodoc
mixin _$QAppConfig {
  String get baseUrl => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  QSubtitleConfig? get subtitle => throw _privateConstructorUsedError;
  QAvatarConfig? get avatar => throw _privateConstructorUsedError;
  String? get channelId => throw _privateConstructorUsedError;
  String? get deviceId => throw _privateConstructorUsedError;
  bool get showSystemEvent => throw _privateConstructorUsedError;
  bool get showSenderAvatar => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QAppConfigCopyWith<QAppConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QAppConfigCopyWith<$Res> {
  factory $QAppConfigCopyWith(
          QAppConfig value, $Res Function(QAppConfig) then) =
      _$QAppConfigCopyWithImpl<$Res>;
  $Res call(
      {String baseUrl,
      String? title,
      QSubtitleConfig? subtitle,
      QAvatarConfig? avatar,
      String? channelId,
      String? deviceId,
      bool showSystemEvent,
      bool showSenderAvatar});

  $QSubtitleConfigCopyWith<$Res>? get subtitle;
  $QAvatarConfigCopyWith<$Res>? get avatar;
}

/// @nodoc
class _$QAppConfigCopyWithImpl<$Res> implements $QAppConfigCopyWith<$Res> {
  _$QAppConfigCopyWithImpl(this._value, this._then);

  final QAppConfig _value;
  // ignore: unused_field
  final $Res Function(QAppConfig) _then;

  @override
  $Res call({
    Object? baseUrl = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? avatar = freezed,
    Object? channelId = freezed,
    Object? deviceId = freezed,
    Object? showSystemEvent = freezed,
    Object? showSenderAvatar = freezed,
  }) {
    return _then(_value.copyWith(
      baseUrl: baseUrl == freezed
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as QSubtitleConfig?,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as QAvatarConfig?,
      channelId: channelId == freezed
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      showSystemEvent: showSystemEvent == freezed
          ? _value.showSystemEvent
          : showSystemEvent // ignore: cast_nullable_to_non_nullable
              as bool,
      showSenderAvatar: showSenderAvatar == freezed
          ? _value.showSenderAvatar
          : showSenderAvatar // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $QSubtitleConfigCopyWith<$Res>? get subtitle {
    if (_value.subtitle == null) {
      return null;
    }

    return $QSubtitleConfigCopyWith<$Res>(_value.subtitle!, (value) {
      return _then(_value.copyWith(subtitle: value));
    });
  }

  @override
  $QAvatarConfigCopyWith<$Res>? get avatar {
    if (_value.avatar == null) {
      return null;
    }

    return $QAvatarConfigCopyWith<$Res>(_value.avatar!, (value) {
      return _then(_value.copyWith(avatar: value));
    });
  }
}

/// @nodoc
abstract class _$QAppConfigCopyWith<$Res> implements $QAppConfigCopyWith<$Res> {
  factory _$QAppConfigCopyWith(
          _QAppConfig value, $Res Function(_QAppConfig) then) =
      __$QAppConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {String baseUrl,
      String? title,
      QSubtitleConfig? subtitle,
      QAvatarConfig? avatar,
      String? channelId,
      String? deviceId,
      bool showSystemEvent,
      bool showSenderAvatar});

  @override
  $QSubtitleConfigCopyWith<$Res>? get subtitle;
  @override
  $QAvatarConfigCopyWith<$Res>? get avatar;
}

/// @nodoc
class __$QAppConfigCopyWithImpl<$Res> extends _$QAppConfigCopyWithImpl<$Res>
    implements _$QAppConfigCopyWith<$Res> {
  __$QAppConfigCopyWithImpl(
      _QAppConfig _value, $Res Function(_QAppConfig) _then)
      : super(_value, (v) => _then(v as _QAppConfig));

  @override
  _QAppConfig get _value => super._value as _QAppConfig;

  @override
  $Res call({
    Object? baseUrl = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? avatar = freezed,
    Object? channelId = freezed,
    Object? deviceId = freezed,
    Object? showSystemEvent = freezed,
    Object? showSenderAvatar = freezed,
  }) {
    return _then(_QAppConfig(
      baseUrl: baseUrl == freezed
          ? _value.baseUrl
          : baseUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as QSubtitleConfig?,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as QAvatarConfig?,
      channelId: channelId == freezed
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: deviceId == freezed
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      showSystemEvent: showSystemEvent == freezed
          ? _value.showSystemEvent
          : showSystemEvent // ignore: cast_nullable_to_non_nullable
              as bool,
      showSenderAvatar: showSenderAvatar == freezed
          ? _value.showSenderAvatar
          : showSenderAvatar // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_QAppConfig implements _QAppConfig {
  const _$_QAppConfig(
      {this.baseUrl = 'https://multichannel.qiscus.com',
      this.title,
      this.subtitle,
      this.avatar,
      this.channelId,
      this.deviceId,
      this.showSystemEvent = true,
      this.showSenderAvatar = true});

  @JsonKey()
  @override
  final String baseUrl;
  @override
  final String? title;
  @override
  final QSubtitleConfig? subtitle;
  @override
  final QAvatarConfig? avatar;
  @override
  final String? channelId;
  @override
  final String? deviceId;
  @JsonKey()
  @override
  final bool showSystemEvent;
  @JsonKey()
  @override
  final bool showSenderAvatar;

  @override
  String toString() {
    return 'QAppConfig(baseUrl: $baseUrl, title: $title, subtitle: $subtitle, avatar: $avatar, channelId: $channelId, deviceId: $deviceId, showSystemEvent: $showSystemEvent, showSenderAvatar: $showSenderAvatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QAppConfig &&
            const DeepCollectionEquality().equals(other.baseUrl, baseUrl) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.subtitle, subtitle) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            const DeepCollectionEquality().equals(other.channelId, channelId) &&
            const DeepCollectionEquality().equals(other.deviceId, deviceId) &&
            const DeepCollectionEquality()
                .equals(other.showSystemEvent, showSystemEvent) &&
            const DeepCollectionEquality()
                .equals(other.showSenderAvatar, showSenderAvatar));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(baseUrl),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(subtitle),
      const DeepCollectionEquality().hash(avatar),
      const DeepCollectionEquality().hash(channelId),
      const DeepCollectionEquality().hash(deviceId),
      const DeepCollectionEquality().hash(showSystemEvent),
      const DeepCollectionEquality().hash(showSenderAvatar));

  @JsonKey(ignore: true)
  @override
  _$QAppConfigCopyWith<_QAppConfig> get copyWith =>
      __$QAppConfigCopyWithImpl<_QAppConfig>(this, _$identity);
}

abstract class _QAppConfig implements QAppConfig {
  const factory _QAppConfig(
      {String baseUrl,
      String? title,
      QSubtitleConfig? subtitle,
      QAvatarConfig? avatar,
      String? channelId,
      String? deviceId,
      bool showSystemEvent,
      bool showSenderAvatar}) = _$_QAppConfig;

  @override
  String get baseUrl;
  @override
  String? get title;
  @override
  QSubtitleConfig? get subtitle;
  @override
  QAvatarConfig? get avatar;
  @override
  String? get channelId;
  @override
  String? get deviceId;
  @override
  bool get showSystemEvent;
  @override
  bool get showSenderAvatar;
  @override
  @JsonKey(ignore: true)
  _$QAppConfigCopyWith<_QAppConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
