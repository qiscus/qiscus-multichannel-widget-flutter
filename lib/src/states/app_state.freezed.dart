// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
    required TResult Function(String appId) loading,
    required TResult Function(int roomId, QAccount account) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String appId)? loading,
    TResult? Function(int roomId, QAccount account)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String appId)? loading,
    TResult Function(int roomId, QAccount account)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppStateInitial value) initial,
    required TResult Function(_AppStateLoading value) loading,
    required TResult Function(_AppStateReady value) ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppStateInitial value)? initial,
    TResult? Function(_AppStateLoading value)? loading,
    TResult? Function(_AppStateReady value)? ready,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateLoading value)? loading,
    TResult Function(_AppStateReady value)? ready,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AppStateInitialCopyWith<$Res> {
  factory _$$_AppStateInitialCopyWith(
          _$_AppStateInitial value, $Res Function(_$_AppStateInitial) then) =
      __$$_AppStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AppStateInitialCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppStateInitial>
    implements _$$_AppStateInitialCopyWith<$Res> {
  __$$_AppStateInitialCopyWithImpl(
      _$_AppStateInitial _value, $Res Function(_$_AppStateInitial) _then)
      : super(_value, _then);
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
    required TResult Function(String appId) loading,
    required TResult Function(int roomId, QAccount account) ready,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String appId)? loading,
    TResult? Function(int roomId, QAccount account)? ready,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String appId)? loading,
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
    required TResult Function(_AppStateLoading value) loading,
    required TResult Function(_AppStateReady value) ready,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppStateInitial value)? initial,
    TResult? Function(_AppStateLoading value)? loading,
    TResult? Function(_AppStateReady value)? ready,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateLoading value)? loading,
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
abstract class _$$_AppStateLoadingCopyWith<$Res> {
  factory _$$_AppStateLoadingCopyWith(
          _$_AppStateLoading value, $Res Function(_$_AppStateLoading) then) =
      __$$_AppStateLoadingCopyWithImpl<$Res>;
  @useResult
  $Res call({String appId});
}

/// @nodoc
class __$$_AppStateLoadingCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppStateLoading>
    implements _$$_AppStateLoadingCopyWith<$Res> {
  __$$_AppStateLoadingCopyWithImpl(
      _$_AppStateLoading _value, $Res Function(_$_AppStateLoading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appId = null,
  }) {
    return _then(_$_AppStateLoading(
      appId: null == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AppStateLoading implements _AppStateLoading {
  const _$_AppStateLoading({required this.appId});

  @override
  final String appId;

  @override
  String toString() {
    return 'AppState.loading(appId: $appId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppStateLoading &&
            (identical(other.appId, appId) || other.appId == appId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, appId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStateLoadingCopyWith<_$_AppStateLoading> get copyWith =>
      __$$_AppStateLoadingCopyWithImpl<_$_AppStateLoading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String appId) loading,
    required TResult Function(int roomId, QAccount account) ready,
  }) {
    return loading(appId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String appId)? loading,
    TResult? Function(int roomId, QAccount account)? ready,
  }) {
    return loading?.call(appId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String appId)? loading,
    TResult Function(int roomId, QAccount account)? ready,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(appId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AppStateInitial value) initial,
    required TResult Function(_AppStateLoading value) loading,
    required TResult Function(_AppStateReady value) ready,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppStateInitial value)? initial,
    TResult? Function(_AppStateLoading value)? loading,
    TResult? Function(_AppStateReady value)? ready,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateLoading value)? loading,
    TResult Function(_AppStateReady value)? ready,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AppStateLoading implements AppState {
  const factory _AppStateLoading({required final String appId}) =
      _$_AppStateLoading;

  String get appId;
  @JsonKey(ignore: true)
  _$$_AppStateLoadingCopyWith<_$_AppStateLoading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_AppStateReadyCopyWith<$Res> {
  factory _$$_AppStateReadyCopyWith(
          _$_AppStateReady value, $Res Function(_$_AppStateReady) then) =
      __$$_AppStateReadyCopyWithImpl<$Res>;
  @useResult
  $Res call({int roomId, QAccount account});
}

/// @nodoc
class __$$_AppStateReadyCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppStateReady>
    implements _$$_AppStateReadyCopyWith<$Res> {
  __$$_AppStateReadyCopyWithImpl(
      _$_AppStateReady _value, $Res Function(_$_AppStateReady) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? account = null,
  }) {
    return _then(_$_AppStateReady(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      account: null == account
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
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, roomId, account);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStateReadyCopyWith<_$_AppStateReady> get copyWith =>
      __$$_AppStateReadyCopyWithImpl<_$_AppStateReady>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String appId) loading,
    required TResult Function(int roomId, QAccount account) ready,
  }) {
    return ready(roomId, account);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String appId)? loading,
    TResult? Function(int roomId, QAccount account)? ready,
  }) {
    return ready?.call(roomId, account);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String appId)? loading,
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
    required TResult Function(_AppStateLoading value) loading,
    required TResult Function(_AppStateReady value) ready,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AppStateInitial value)? initial,
    TResult? Function(_AppStateLoading value)? loading,
    TResult? Function(_AppStateReady value)? ready,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AppStateInitial value)? initial,
    TResult Function(_AppStateLoading value)? loading,
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

  int get roomId;
  QAccount get account;
  @JsonKey(ignore: true)
  _$$_AppStateReadyCopyWith<_$_AppStateReady> get copyWith =>
      throw _privateConstructorUsedError;
}
