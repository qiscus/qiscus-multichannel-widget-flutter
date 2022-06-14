// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_buttons.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QMessageButtonPayload _$QMessageButtonPayloadFromJson(
    Map<String, dynamic> json) {
  return _QMessageButtonPayload.fromJson(json);
}

/// @nodoc
mixin _$QMessageButtonPayload {
  String get text => throw _privateConstructorUsedError;
  List<QButtons> get buttons => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QMessageButtonPayloadCopyWith<QMessageButtonPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QMessageButtonPayloadCopyWith<$Res> {
  factory $QMessageButtonPayloadCopyWith(QMessageButtonPayload value,
          $Res Function(QMessageButtonPayload) then) =
      _$QMessageButtonPayloadCopyWithImpl<$Res>;
  $Res call({String text, List<QButtons> buttons, String type});
}

/// @nodoc
class _$QMessageButtonPayloadCopyWithImpl<$Res>
    implements $QMessageButtonPayloadCopyWith<$Res> {
  _$QMessageButtonPayloadCopyWithImpl(this._value, this._then);

  final QMessageButtonPayload _value;
  // ignore: unused_field
  final $Res Function(QMessageButtonPayload) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? buttons = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      buttons: buttons == freezed
          ? _value.buttons
          : buttons // ignore: cast_nullable_to_non_nullable
              as List<QButtons>,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_QMessageButtonPayloadCopyWith<$Res>
    implements $QMessageButtonPayloadCopyWith<$Res> {
  factory _$$_QMessageButtonPayloadCopyWith(_$_QMessageButtonPayload value,
          $Res Function(_$_QMessageButtonPayload) then) =
      __$$_QMessageButtonPayloadCopyWithImpl<$Res>;
  @override
  $Res call({String text, List<QButtons> buttons, String type});
}

/// @nodoc
class __$$_QMessageButtonPayloadCopyWithImpl<$Res>
    extends _$QMessageButtonPayloadCopyWithImpl<$Res>
    implements _$$_QMessageButtonPayloadCopyWith<$Res> {
  __$$_QMessageButtonPayloadCopyWithImpl(_$_QMessageButtonPayload _value,
      $Res Function(_$_QMessageButtonPayload) _then)
      : super(_value, (v) => _then(v as _$_QMessageButtonPayload));

  @override
  _$_QMessageButtonPayload get _value =>
      super._value as _$_QMessageButtonPayload;

  @override
  $Res call({
    Object? text = freezed,
    Object? buttons = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_QMessageButtonPayload(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      buttons: buttons == freezed
          ? _value._buttons
          : buttons // ignore: cast_nullable_to_non_nullable
              as List<QButtons>,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QMessageButtonPayload implements _QMessageButtonPayload {
  const _$_QMessageButtonPayload(
      {required this.text,
      required final List<QButtons> buttons,
      required this.type})
      : _buttons = buttons;

  factory _$_QMessageButtonPayload.fromJson(Map<String, dynamic> json) =>
      _$$_QMessageButtonPayloadFromJson(json);

  @override
  final String text;
  final List<QButtons> _buttons;
  @override
  List<QButtons> get buttons {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buttons);
  }

  @override
  final String type;

  @override
  String toString() {
    return 'QMessageButtonPayload(text: $text, buttons: $buttons, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QMessageButtonPayload &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other._buttons, _buttons) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(_buttons),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$$_QMessageButtonPayloadCopyWith<_$_QMessageButtonPayload> get copyWith =>
      __$$_QMessageButtonPayloadCopyWithImpl<_$_QMessageButtonPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QMessageButtonPayloadToJson(this);
  }
}

abstract class _QMessageButtonPayload implements QMessageButtonPayload {
  const factory _QMessageButtonPayload(
      {required final String text,
      required final List<QButtons> buttons,
      required final String type}) = _$_QMessageButtonPayload;

  factory _QMessageButtonPayload.fromJson(Map<String, dynamic> json) =
      _$_QMessageButtonPayload.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  List<QButtons> get buttons => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QMessageButtonPayloadCopyWith<_$_QMessageButtonPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

QButtons _$QButtonsFromJson(Map<String, dynamic> json) {
  return _QButtons.fromJson(json);
}

/// @nodoc
mixin _$QButtons {
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'postback_text')
  String get postbackText => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  QButtonsPostbackPayload get payload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QButtonsCopyWith<QButtons> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QButtonsCopyWith<$Res> {
  factory $QButtonsCopyWith(QButtons value, $Res Function(QButtons) then) =
      _$QButtonsCopyWithImpl<$Res>;
  $Res call(
      {String label,
      @JsonKey(name: 'postback_text') String postbackText,
      String type,
      QButtonsPostbackPayload payload});

  $QButtonsPostbackPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class _$QButtonsCopyWithImpl<$Res> implements $QButtonsCopyWith<$Res> {
  _$QButtonsCopyWithImpl(this._value, this._then);

  final QButtons _value;
  // ignore: unused_field
  final $Res Function(QButtons) _then;

  @override
  $Res call({
    Object? label = freezed,
    Object? postbackText = freezed,
    Object? type = freezed,
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      postbackText: postbackText == freezed
          ? _value.postbackText
          : postbackText // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: payload == freezed
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as QButtonsPostbackPayload,
    ));
  }

  @override
  $QButtonsPostbackPayloadCopyWith<$Res> get payload {
    return $QButtonsPostbackPayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value));
    });
  }
}

/// @nodoc
abstract class _$$_QButtonsCopyWith<$Res> implements $QButtonsCopyWith<$Res> {
  factory _$$_QButtonsCopyWith(
          _$_QButtons value, $Res Function(_$_QButtons) then) =
      __$$_QButtonsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String label,
      @JsonKey(name: 'postback_text') String postbackText,
      String type,
      QButtonsPostbackPayload payload});

  @override
  $QButtonsPostbackPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$_QButtonsCopyWithImpl<$Res> extends _$QButtonsCopyWithImpl<$Res>
    implements _$$_QButtonsCopyWith<$Res> {
  __$$_QButtonsCopyWithImpl(
      _$_QButtons _value, $Res Function(_$_QButtons) _then)
      : super(_value, (v) => _then(v as _$_QButtons));

  @override
  _$_QButtons get _value => super._value as _$_QButtons;

  @override
  $Res call({
    Object? label = freezed,
    Object? postbackText = freezed,
    Object? type = freezed,
    Object? payload = freezed,
  }) {
    return _then(_$_QButtons(
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      postbackText: postbackText == freezed
          ? _value.postbackText
          : postbackText // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: payload == freezed
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as QButtonsPostbackPayload,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QButtons implements _QButtons {
  const _$_QButtons(
      {required this.label,
      @JsonKey(name: 'postback_text') required this.postbackText,
      required this.type,
      required this.payload});

  factory _$_QButtons.fromJson(Map<String, dynamic> json) =>
      _$$_QButtonsFromJson(json);

  @override
  final String label;
  @override
  @JsonKey(name: 'postback_text')
  final String postbackText;
  @override
  final String type;
  @override
  final QButtonsPostbackPayload payload;

  @override
  String toString() {
    return 'QButtons(label: $label, postbackText: $postbackText, type: $type, payload: $payload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QButtons &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality()
                .equals(other.postbackText, postbackText) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(postbackText),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(payload));

  @JsonKey(ignore: true)
  @override
  _$$_QButtonsCopyWith<_$_QButtons> get copyWith =>
      __$$_QButtonsCopyWithImpl<_$_QButtons>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QButtonsToJson(this);
  }
}

abstract class _QButtons implements QButtons {
  const factory _QButtons(
      {required final String label,
      @JsonKey(name: 'postback_text') required final String postbackText,
      required final String type,
      required final QButtonsPostbackPayload payload}) = _$_QButtons;

  factory _QButtons.fromJson(Map<String, dynamic> json) = _$_QButtons.fromJson;

  @override
  String get label => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'postback_text')
  String get postbackText => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  QButtonsPostbackPayload get payload => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QButtonsCopyWith<_$_QButtons> get copyWith =>
      throw _privateConstructorUsedError;
}

QButtonsPostbackPayload _$QButtonsPostbackPayloadFromJson(
    Map<String, dynamic> json) {
  return _QButtonsPayload.fromJson(json);
}

/// @nodoc
mixin _$QButtonsPostbackPayload {
  String get url => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  Map<String, Object?>? get payload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QButtonsPostbackPayloadCopyWith<QButtonsPostbackPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QButtonsPostbackPayloadCopyWith<$Res> {
  factory $QButtonsPostbackPayloadCopyWith(QButtonsPostbackPayload value,
          $Res Function(QButtonsPostbackPayload) then) =
      _$QButtonsPostbackPayloadCopyWithImpl<$Res>;
  $Res call({String url, String method, Map<String, Object?>? payload});
}

/// @nodoc
class _$QButtonsPostbackPayloadCopyWithImpl<$Res>
    implements $QButtonsPostbackPayloadCopyWith<$Res> {
  _$QButtonsPostbackPayloadCopyWithImpl(this._value, this._then);

  final QButtonsPostbackPayload _value;
  // ignore: unused_field
  final $Res Function(QButtonsPostbackPayload) _then;

  @override
  $Res call({
    Object? url = freezed,
    Object? method = freezed,
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      method: method == freezed
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      payload: payload == freezed
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ));
  }
}

/// @nodoc
abstract class _$$_QButtonsPayloadCopyWith<$Res>
    implements $QButtonsPostbackPayloadCopyWith<$Res> {
  factory _$$_QButtonsPayloadCopyWith(
          _$_QButtonsPayload value, $Res Function(_$_QButtonsPayload) then) =
      __$$_QButtonsPayloadCopyWithImpl<$Res>;
  @override
  $Res call({String url, String method, Map<String, Object?>? payload});
}

/// @nodoc
class __$$_QButtonsPayloadCopyWithImpl<$Res>
    extends _$QButtonsPostbackPayloadCopyWithImpl<$Res>
    implements _$$_QButtonsPayloadCopyWith<$Res> {
  __$$_QButtonsPayloadCopyWithImpl(
      _$_QButtonsPayload _value, $Res Function(_$_QButtonsPayload) _then)
      : super(_value, (v) => _then(v as _$_QButtonsPayload));

  @override
  _$_QButtonsPayload get _value => super._value as _$_QButtonsPayload;

  @override
  $Res call({
    Object? url = freezed,
    Object? method = freezed,
    Object? payload = freezed,
  }) {
    return _then(_$_QButtonsPayload(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      method: method == freezed
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      payload: payload == freezed
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QButtonsPayload implements _QButtonsPayload {
  const _$_QButtonsPayload(
      {required this.url,
      required this.method,
      required final Map<String, Object?>? payload})
      : _payload = payload;

  factory _$_QButtonsPayload.fromJson(Map<String, dynamic> json) =>
      _$$_QButtonsPayloadFromJson(json);

  @override
  final String url;
  @override
  final String method;
  final Map<String, Object?>? _payload;
  @override
  Map<String, Object?>? get payload {
    final value = _payload;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'QButtonsPostbackPayload(url: $url, method: $method, payload: $payload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QButtonsPayload &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.method, method) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(method),
      const DeepCollectionEquality().hash(_payload));

  @JsonKey(ignore: true)
  @override
  _$$_QButtonsPayloadCopyWith<_$_QButtonsPayload> get copyWith =>
      __$$_QButtonsPayloadCopyWithImpl<_$_QButtonsPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QButtonsPayloadToJson(this);
  }
}

abstract class _QButtonsPayload implements QButtonsPostbackPayload {
  const factory _QButtonsPayload(
      {required final String url,
      required final String method,
      required final Map<String, Object?>? payload}) = _$_QButtonsPayload;

  factory _QButtonsPayload.fromJson(Map<String, dynamic> json) =
      _$_QButtonsPayload.fromJson;

  @override
  String get url => throw _privateConstructorUsedError;
  @override
  String get method => throw _privateConstructorUsedError;
  @override
  Map<String, Object?>? get payload => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_QButtonsPayloadCopyWith<_$_QButtonsPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
