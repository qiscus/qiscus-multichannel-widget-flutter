// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int roomId, QAccount account) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int roomId, QAccount account)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int roomId, QAccount account)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppStateInitial value) initial,
    required TResult Function(_AppStateReady value) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateReady value)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateReady value)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res> implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  final AppState _value;
  // ignore: unused_field
  final $Res Function(AppState) _then;
}

/// @nodoc
abstract class _$$_AppStateInitialCopyWith<$Res> {
  factory _$$_AppStateInitialCopyWith(
          _$_AppStateInitial value, $Res Function(_$_AppStateInitial) then) =
      __$$_AppStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AppStateInitialCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res>
    implements _$$_AppStateInitialCopyWith<$Res> {
  __$$_AppStateInitialCopyWithImpl(
      _$_AppStateInitial _value, $Res Function(_$_AppStateInitial) _then)
      : super(_value, (v) => _then(v as _$_AppStateInitial));

  @override
  _$_AppStateInitial get _value => super._value as _$_AppStateInitial;
}

/// @nodoc

class _$_AppStateInitial implements _AppStateInitial {
  const _$_AppStateInitial();

  @override
  String toString() {
    return 'AppState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AppStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int roomId, QAccount account) ready,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int roomId, QAccount account)? ready,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int roomId, QAccount account)? ready,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppStateInitial value) initial,
    required TResult Function(_AppStateReady value) ready,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateReady value)? ready,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _AppStateInitial implements AppState {
  const factory _AppStateInitial() = _$_AppStateInitial;
}

/// @nodoc
abstract class _$$_AppStateReadyCopyWith<$Res> {
  factory _$$_AppStateReadyCopyWith(
          _$_AppStateReady value, $Res Function(_$_AppStateReady) then) =
      __$$_AppStateReadyCopyWithImpl<$Res>;
  $Res call({int roomId, QAccount account});
}

/// @nodoc
class __$$_AppStateReadyCopyWithImpl<$Res> extends _$AppStateCopyWithImpl<$Res>
    implements _$$_AppStateReadyCopyWith<$Res> {
  __$$_AppStateReadyCopyWithImpl(
      _$_AppStateReady _value, $Res Function(_$_AppStateReady) _then)
      : super(_value, (v) => _then(v as _$_AppStateReady));

  @override
  _$_AppStateReady get _value => super._value as _$_AppStateReady;

  @override
  $Res call({
    Object? roomId = freezed,
    Object? account = freezed,
  }) {
    return _then(_$_AppStateReady(
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as QAccount,
    ));
  }
}

/// @nodoc

class _$_AppStateReady implements _AppStateReady {
  const _$_AppStateReady({required this.roomId, required this.account});

  @override
  final int roomId;
  @override
  final QAccount account;

  @override
  String toString() {
    return 'AppState.ready(roomId: $roomId, account: $account)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppStateReady &&
            const DeepCollectionEquality().equals(other.roomId, roomId) &&
            const DeepCollectionEquality().equals(other.account, account));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(roomId),
      const DeepCollectionEquality().hash(account));

  @JsonKey(ignore: true)
  @override
  _$$_AppStateReadyCopyWith<_$_AppStateReady> get copyWith =>
      __$$_AppStateReadyCopyWithImpl<_$_AppStateReady>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int roomId, QAccount account) ready,
  }) {
    return ready(roomId, account);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int roomId, QAccount account)? ready,
  }) {
    return ready?.call(roomId, account);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int roomId, QAccount account)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(roomId, account);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppStateInitial value) initial,
    required TResult Function(_AppStateReady value) ready,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateReady value)? ready,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class _AppStateReady implements AppState {
  const factory _AppStateReady(
      {required final int roomId,
      required final QAccount account}) = _$_AppStateReady;

  int get roomId => throw _privateConstructorUsedError;
  QAccount get account => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$_AppStateReadyCopyWith<_$_AppStateReady> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$QAppState {
  QAppConfig get appConfig => throw _privateConstructorUsedError;
  QAppTheme get theme => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(QAppConfig appConfig, QAppTheme theme) initial,
    required TResult Function(
            String appId, QAppConfig appConfig, QAppTheme theme)
        setup,
    required TResult Function(String appId, QUserConfig userConfig,
            QAppConfig appConfig, QAppTheme theme)
        authenticated,
    required TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QAppStateInitial value) initial,
    required TResult Function(_QAppStateSetup value) setup,
    required TResult Function(_QAppStateAuthenticated value) authenticated,
    required TResult Function(_QAppStateReady value) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QAppStateCopyWith<QAppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QAppStateCopyWith<$Res> {
  factory $QAppStateCopyWith(QAppState value, $Res Function(QAppState) then) =
      _$QAppStateCopyWithImpl<$Res>;
  $Res call({QAppConfig appConfig, QAppTheme theme});

  $QAppConfigCopyWith<$Res> get appConfig;
  $QAppThemeCopyWith<$Res> get theme;
}

/// @nodoc
class _$QAppStateCopyWithImpl<$Res> implements $QAppStateCopyWith<$Res> {
  _$QAppStateCopyWithImpl(this._value, this._then);

  final QAppState _value;
  // ignore: unused_field
  final $Res Function(QAppState) _then;

  @override
  $Res call({
    Object? appConfig = freezed,
    Object? theme = freezed,
  }) {
    return _then(_value.copyWith(
      appConfig: appConfig == freezed
          ? _value.appConfig
          : appConfig // ignore: cast_nullable_to_non_nullable
              as QAppConfig,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as QAppTheme,
    ));
  }

  @override
  $QAppConfigCopyWith<$Res> get appConfig {
    return $QAppConfigCopyWith<$Res>(_value.appConfig, (value) {
      return _then(_value.copyWith(appConfig: value));
    });
  }

  @override
  $QAppThemeCopyWith<$Res> get theme {
    return $QAppThemeCopyWith<$Res>(_value.theme, (value) {
      return _then(_value.copyWith(theme: value));
    });
  }
}

/// @nodoc
abstract class _$$_QAppStateInitialCopyWith<$Res>
    implements $QAppStateCopyWith<$Res> {
  factory _$$_QAppStateInitialCopyWith(
          _$_QAppStateInitial value, $Res Function(_$_QAppStateInitial) then) =
      __$$_QAppStateInitialCopyWithImpl<$Res>;
  @override
  $Res call({QAppConfig appConfig, QAppTheme theme});

  @override
  $QAppConfigCopyWith<$Res> get appConfig;
  @override
  $QAppThemeCopyWith<$Res> get theme;
}

/// @nodoc
class __$$_QAppStateInitialCopyWithImpl<$Res>
    extends _$QAppStateCopyWithImpl<$Res>
    implements _$$_QAppStateInitialCopyWith<$Res> {
  __$$_QAppStateInitialCopyWithImpl(
      _$_QAppStateInitial _value, $Res Function(_$_QAppStateInitial) _then)
      : super(_value, (v) => _then(v as _$_QAppStateInitial));

  @override
  _$_QAppStateInitial get _value => super._value as _$_QAppStateInitial;

  @override
  $Res call({
    Object? appConfig = freezed,
    Object? theme = freezed,
  }) {
    return _then(_$_QAppStateInitial(
      appConfig: appConfig == freezed
          ? _value.appConfig
          : appConfig // ignore: cast_nullable_to_non_nullable
              as QAppConfig,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as QAppTheme,
    ));
  }
}

/// @nodoc

class _$_QAppStateInitial implements _QAppStateInitial {
  _$_QAppStateInitial(
      {this.appConfig = const QAppConfig(), this.theme = const QAppTheme()});

  @override
  @JsonKey()
  final QAppConfig appConfig;
  @override
  @JsonKey()
  final QAppTheme theme;

  @override
  String toString() {
    return 'QAppState.initial(appConfig: $appConfig, theme: $theme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QAppStateInitial &&
            const DeepCollectionEquality().equals(other.appConfig, appConfig) &&
            const DeepCollectionEquality().equals(other.theme, theme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appConfig),
      const DeepCollectionEquality().hash(theme));

  @JsonKey(ignore: true)
  @override
  _$$_QAppStateInitialCopyWith<_$_QAppStateInitial> get copyWith =>
      __$$_QAppStateInitialCopyWithImpl<_$_QAppStateInitial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(QAppConfig appConfig, QAppTheme theme) initial,
    required TResult Function(
            String appId, QAppConfig appConfig, QAppTheme theme)
        setup,
    required TResult Function(String appId, QUserConfig userConfig,
            QAppConfig appConfig, QAppTheme theme)
        authenticated,
    required TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)
        ready,
  }) {
    return initial(appConfig, theme);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
  }) {
    return initial?.call(appConfig, theme);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(appConfig, theme);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QAppStateInitial value) initial,
    required TResult Function(_QAppStateSetup value) setup,
    required TResult Function(_QAppStateAuthenticated value) authenticated,
    required TResult Function(_QAppStateReady value) ready,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _QAppStateInitial implements QAppState {
  factory _QAppStateInitial(
      {final QAppConfig appConfig,
      final QAppTheme theme}) = _$_QAppStateInitial;

  @override
  QAppConfig get appConfig => throw _privateConstructorUsedError;
  @override
  QAppTheme get theme => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QAppStateInitialCopyWith<_$_QAppStateInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_QAppStateSetupCopyWith<$Res>
    implements $QAppStateCopyWith<$Res> {
  factory _$$_QAppStateSetupCopyWith(
          _$_QAppStateSetup value, $Res Function(_$_QAppStateSetup) then) =
      __$$_QAppStateSetupCopyWithImpl<$Res>;
  @override
  $Res call({String appId, QAppConfig appConfig, QAppTheme theme});

  @override
  $QAppConfigCopyWith<$Res> get appConfig;
  @override
  $QAppThemeCopyWith<$Res> get theme;
}

/// @nodoc
class __$$_QAppStateSetupCopyWithImpl<$Res>
    extends _$QAppStateCopyWithImpl<$Res>
    implements _$$_QAppStateSetupCopyWith<$Res> {
  __$$_QAppStateSetupCopyWithImpl(
      _$_QAppStateSetup _value, $Res Function(_$_QAppStateSetup) _then)
      : super(_value, (v) => _then(v as _$_QAppStateSetup));

  @override
  _$_QAppStateSetup get _value => super._value as _$_QAppStateSetup;

  @override
  $Res call({
    Object? appId = freezed,
    Object? appConfig = freezed,
    Object? theme = freezed,
  }) {
    return _then(_$_QAppStateSetup(
      appId: appId == freezed
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
      appConfig: appConfig == freezed
          ? _value.appConfig
          : appConfig // ignore: cast_nullable_to_non_nullable
              as QAppConfig,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as QAppTheme,
    ));
  }
}

/// @nodoc

class _$_QAppStateSetup implements _QAppStateSetup {
  _$_QAppStateSetup(
      {required this.appId,
      this.appConfig = const QAppConfig(),
      this.theme = const QAppTheme()});

  @override
  final String appId;
  @override
  @JsonKey()
  final QAppConfig appConfig;
  @override
  @JsonKey()
  final QAppTheme theme;

  @override
  String toString() {
    return 'QAppState.setup(appId: $appId, appConfig: $appConfig, theme: $theme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QAppStateSetup &&
            const DeepCollectionEquality().equals(other.appId, appId) &&
            const DeepCollectionEquality().equals(other.appConfig, appConfig) &&
            const DeepCollectionEquality().equals(other.theme, theme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appId),
      const DeepCollectionEquality().hash(appConfig),
      const DeepCollectionEquality().hash(theme));

  @JsonKey(ignore: true)
  @override
  _$$_QAppStateSetupCopyWith<_$_QAppStateSetup> get copyWith =>
      __$$_QAppStateSetupCopyWithImpl<_$_QAppStateSetup>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(QAppConfig appConfig, QAppTheme theme) initial,
    required TResult Function(
            String appId, QAppConfig appConfig, QAppTheme theme)
        setup,
    required TResult Function(String appId, QUserConfig userConfig,
            QAppConfig appConfig, QAppTheme theme)
        authenticated,
    required TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)
        ready,
  }) {
    return setup(appId, appConfig, theme);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
  }) {
    return setup?.call(appId, appConfig, theme);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
    required TResult orElse(),
  }) {
    if (setup != null) {
      return setup(appId, appConfig, theme);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QAppStateInitial value) initial,
    required TResult Function(_QAppStateSetup value) setup,
    required TResult Function(_QAppStateAuthenticated value) authenticated,
    required TResult Function(_QAppStateReady value) ready,
  }) {
    return setup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
  }) {
    return setup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (setup != null) {
      return setup(this);
    }
    return orElse();
  }
}

abstract class _QAppStateSetup implements QAppState {
  factory _QAppStateSetup(
      {required final String appId,
      final QAppConfig appConfig,
      final QAppTheme theme}) = _$_QAppStateSetup;

  String get appId => throw _privateConstructorUsedError;
  @override
  QAppConfig get appConfig => throw _privateConstructorUsedError;
  @override
  QAppTheme get theme => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QAppStateSetupCopyWith<_$_QAppStateSetup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_QAppStateAuthenticatedCopyWith<$Res>
    implements $QAppStateCopyWith<$Res> {
  factory _$$_QAppStateAuthenticatedCopyWith(_$_QAppStateAuthenticated value,
          $Res Function(_$_QAppStateAuthenticated) then) =
      __$$_QAppStateAuthenticatedCopyWithImpl<$Res>;
  @override
  $Res call(
      {String appId,
      QUserConfig userConfig,
      QAppConfig appConfig,
      QAppTheme theme});

  $QUserConfigCopyWith<$Res> get userConfig;
  @override
  $QAppConfigCopyWith<$Res> get appConfig;
  @override
  $QAppThemeCopyWith<$Res> get theme;
}

/// @nodoc
class __$$_QAppStateAuthenticatedCopyWithImpl<$Res>
    extends _$QAppStateCopyWithImpl<$Res>
    implements _$$_QAppStateAuthenticatedCopyWith<$Res> {
  __$$_QAppStateAuthenticatedCopyWithImpl(_$_QAppStateAuthenticated _value,
      $Res Function(_$_QAppStateAuthenticated) _then)
      : super(_value, (v) => _then(v as _$_QAppStateAuthenticated));

  @override
  _$_QAppStateAuthenticated get _value =>
      super._value as _$_QAppStateAuthenticated;

  @override
  $Res call({
    Object? appId = freezed,
    Object? userConfig = freezed,
    Object? appConfig = freezed,
    Object? theme = freezed,
  }) {
    return _then(_$_QAppStateAuthenticated(
      appId: appId == freezed
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
      userConfig: userConfig == freezed
          ? _value.userConfig
          : userConfig // ignore: cast_nullable_to_non_nullable
              as QUserConfig,
      appConfig: appConfig == freezed
          ? _value.appConfig
          : appConfig // ignore: cast_nullable_to_non_nullable
              as QAppConfig,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as QAppTheme,
    ));
  }

  @override
  $QUserConfigCopyWith<$Res> get userConfig {
    return $QUserConfigCopyWith<$Res>(_value.userConfig, (value) {
      return _then(_value.copyWith(userConfig: value));
    });
  }
}

/// @nodoc

class _$_QAppStateAuthenticated implements _QAppStateAuthenticated {
  _$_QAppStateAuthenticated(
      {required this.appId,
      required this.userConfig,
      this.appConfig = const QAppConfig(),
      this.theme = const QAppTheme()});

  @override
  final String appId;
  @override
  final QUserConfig userConfig;
  @override
  @JsonKey()
  final QAppConfig appConfig;
  @override
  @JsonKey()
  final QAppTheme theme;

  @override
  String toString() {
    return 'QAppState.authenticated(appId: $appId, userConfig: $userConfig, appConfig: $appConfig, theme: $theme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QAppStateAuthenticated &&
            const DeepCollectionEquality().equals(other.appId, appId) &&
            const DeepCollectionEquality()
                .equals(other.userConfig, userConfig) &&
            const DeepCollectionEquality().equals(other.appConfig, appConfig) &&
            const DeepCollectionEquality().equals(other.theme, theme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appId),
      const DeepCollectionEquality().hash(userConfig),
      const DeepCollectionEquality().hash(appConfig),
      const DeepCollectionEquality().hash(theme));

  @JsonKey(ignore: true)
  @override
  _$$_QAppStateAuthenticatedCopyWith<_$_QAppStateAuthenticated> get copyWith =>
      __$$_QAppStateAuthenticatedCopyWithImpl<_$_QAppStateAuthenticated>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(QAppConfig appConfig, QAppTheme theme) initial,
    required TResult Function(
            String appId, QAppConfig appConfig, QAppTheme theme)
        setup,
    required TResult Function(String appId, QUserConfig userConfig,
            QAppConfig appConfig, QAppTheme theme)
        authenticated,
    required TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)
        ready,
  }) {
    return authenticated(appId, userConfig, appConfig, theme);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
  }) {
    return authenticated?.call(appId, userConfig, appConfig, theme);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(appId, userConfig, appConfig, theme);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QAppStateInitial value) initial,
    required TResult Function(_QAppStateSetup value) setup,
    required TResult Function(_QAppStateAuthenticated value) authenticated,
    required TResult Function(_QAppStateReady value) ready,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _QAppStateAuthenticated implements QAppState {
  factory _QAppStateAuthenticated(
      {required final String appId,
      required final QUserConfig userConfig,
      final QAppConfig appConfig,
      final QAppTheme theme}) = _$_QAppStateAuthenticated;

  String get appId => throw _privateConstructorUsedError;
  QUserConfig get userConfig => throw _privateConstructorUsedError;
  @override
  QAppConfig get appConfig => throw _privateConstructorUsedError;
  @override
  QAppTheme get theme => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QAppStateAuthenticatedCopyWith<_$_QAppStateAuthenticated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_QAppStateReadyCopyWith<$Res>
    implements $QAppStateCopyWith<$Res> {
  factory _$$_QAppStateReadyCopyWith(
          _$_QAppStateReady value, $Res Function(_$_QAppStateReady) then) =
      __$$_QAppStateReadyCopyWithImpl<$Res>;
  @override
  $Res call(
      {String appId,
      QAccount account,
      QChatRoom room,
      List<QMessage> messages,
      QAppConfig appConfig,
      QAppTheme theme});

  @override
  $QAppConfigCopyWith<$Res> get appConfig;
  @override
  $QAppThemeCopyWith<$Res> get theme;
}

/// @nodoc
class __$$_QAppStateReadyCopyWithImpl<$Res>
    extends _$QAppStateCopyWithImpl<$Res>
    implements _$$_QAppStateReadyCopyWith<$Res> {
  __$$_QAppStateReadyCopyWithImpl(
      _$_QAppStateReady _value, $Res Function(_$_QAppStateReady) _then)
      : super(_value, (v) => _then(v as _$_QAppStateReady));

  @override
  _$_QAppStateReady get _value => super._value as _$_QAppStateReady;

  @override
  $Res call({
    Object? appId = freezed,
    Object? account = freezed,
    Object? room = freezed,
    Object? messages = freezed,
    Object? appConfig = freezed,
    Object? theme = freezed,
  }) {
    return _then(_$_QAppStateReady(
      appId: appId == freezed
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
      account: account == freezed
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as QAccount,
      room: room == freezed
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as QChatRoom,
      messages: messages == freezed
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<QMessage>,
      appConfig: appConfig == freezed
          ? _value.appConfig
          : appConfig // ignore: cast_nullable_to_non_nullable
              as QAppConfig,
      theme: theme == freezed
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as QAppTheme,
    ));
  }
}

/// @nodoc

class _$_QAppStateReady implements _QAppStateReady {
  _$_QAppStateReady(
      {required this.appId,
      required this.account,
      required this.room,
      final List<QMessage> messages = const [],
      this.appConfig = const QAppConfig(),
      this.theme = const QAppTheme()})
      : _messages = messages;

  @override
  final String appId;
  @override
  final QAccount account;
  @override
  final QChatRoom room;
  final List<QMessage> _messages;
  @override
  @JsonKey()
  List<QMessage> get messages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final QAppConfig appConfig;
  @override
  @JsonKey()
  final QAppTheme theme;

  @override
  String toString() {
    return 'QAppState.ready(appId: $appId, account: $account, room: $room, messages: $messages, appConfig: $appConfig, theme: $theme)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QAppStateReady &&
            const DeepCollectionEquality().equals(other.appId, appId) &&
            const DeepCollectionEquality().equals(other.account, account) &&
            const DeepCollectionEquality().equals(other.room, room) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality().equals(other.appConfig, appConfig) &&
            const DeepCollectionEquality().equals(other.theme, theme));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(appId),
      const DeepCollectionEquality().hash(account),
      const DeepCollectionEquality().hash(room),
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(appConfig),
      const DeepCollectionEquality().hash(theme));

  @JsonKey(ignore: true)
  @override
  _$$_QAppStateReadyCopyWith<_$_QAppStateReady> get copyWith =>
      __$$_QAppStateReadyCopyWithImpl<_$_QAppStateReady>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(QAppConfig appConfig, QAppTheme theme) initial,
    required TResult Function(
            String appId, QAppConfig appConfig, QAppTheme theme)
        setup,
    required TResult Function(String appId, QUserConfig userConfig,
            QAppConfig appConfig, QAppTheme theme)
        authenticated,
    required TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)
        ready,
  }) {
    return ready(appId, account, room, messages, appConfig, theme);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
  }) {
    return ready?.call(appId, account, room, messages, appConfig, theme);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(QAppConfig appConfig, QAppTheme theme)? initial,
    TResult Function(String appId, QAppConfig appConfig, QAppTheme theme)?
        setup,
    TResult Function(String appId, QUserConfig userConfig, QAppConfig appConfig,
            QAppTheme theme)?
        authenticated,
    TResult Function(String appId, QAccount account, QChatRoom room,
            List<QMessage> messages, QAppConfig appConfig, QAppTheme theme)?
        ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(appId, account, room, messages, appConfig, theme);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_QAppStateInitial value) initial,
    required TResult Function(_QAppStateSetup value) setup,
    required TResult Function(_QAppStateAuthenticated value) authenticated,
    required TResult Function(_QAppStateReady value) ready,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_QAppStateInitial value)? initial,
    TResult Function(_QAppStateSetup value)? setup,
    TResult Function(_QAppStateAuthenticated value)? authenticated,
    TResult Function(_QAppStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class _QAppStateReady implements QAppState {
  factory _QAppStateReady(
      {required final String appId,
      required final QAccount account,
      required final QChatRoom room,
      final List<QMessage> messages,
      final QAppConfig appConfig,
      final QAppTheme theme}) = _$_QAppStateReady;

  String get appId => throw _privateConstructorUsedError;
  QAccount get account => throw _privateConstructorUsedError;
  QChatRoom get room => throw _privateConstructorUsedError;
  List<QMessage> get messages => throw _privateConstructorUsedError;
  @override
  QAppConfig get appConfig => throw _privateConstructorUsedError;
  @override
  QAppTheme get theme => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QAppStateReadyCopyWith<_$_QAppStateReady> get copyWith =>
      throw _privateConstructorUsedError;
}
