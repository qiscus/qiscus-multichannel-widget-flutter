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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QMessageButtonPayload _$QMessageButtonPayloadFromJson(
    Map<String, dynamic> json) {
  return _QMessageButtonPayload.fromJson(json);
}

/// @nodoc
class _$QMessageButtonPayloadTearOff {
  const _$QMessageButtonPayloadTearOff();

  _QMessageButtonPayload call(
      {required String text,
      required List<QButtons> buttons,
      required String type}) {
    return _QMessageButtonPayload(
      text: text,
      buttons: buttons,
      type: type,
    );
  }

  QMessageButtonPayload fromJson(Map<String, Object?> json) {
    return QMessageButtonPayload.fromJson(json);
  }
}

/// @nodoc
const $QMessageButtonPayload = _$QMessageButtonPayloadTearOff();

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
abstract class _$QMessageButtonPayloadCopyWith<$Res>
    implements $QMessageButtonPayloadCopyWith<$Res> {
  factory _$QMessageButtonPayloadCopyWith(_QMessageButtonPayload value,
          $Res Function(_QMessageButtonPayload) then) =
      __$QMessageButtonPayloadCopyWithImpl<$Res>;
  @override
  $Res call({String text, List<QButtons> buttons, String type});
}

/// @nodoc
class __$QMessageButtonPayloadCopyWithImpl<$Res>
    extends _$QMessageButtonPayloadCopyWithImpl<$Res>
    implements _$QMessageButtonPayloadCopyWith<$Res> {
  __$QMessageButtonPayloadCopyWithImpl(_QMessageButtonPayload _value,
      $Res Function(_QMessageButtonPayload) _then)
      : super(_value, (v) => _then(v as _QMessageButtonPayload));

  @override
  _QMessageButtonPayload get _value => super._value as _QMessageButtonPayload;

  @override
  $Res call({
    Object? text = freezed,
    Object? buttons = freezed,
    Object? type = freezed,
  }) {
    return _then(_QMessageButtonPayload(
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
@JsonSerializable()
class _$_QMessageButtonPayload implements _QMessageButtonPayload {
  const _$_QMessageButtonPayload(
      {required this.text, required this.buttons, required this.type});

  factory _$_QMessageButtonPayload.fromJson(Map<String, dynamic> json) =>
      _$$_QMessageButtonPayloadFromJson(json);

  @override
  final String text;
  @override
  final List<QButtons> buttons;
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
            other is _QMessageButtonPayload &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.buttons, buttons) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(buttons),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$QMessageButtonPayloadCopyWith<_QMessageButtonPayload> get copyWith =>
      __$QMessageButtonPayloadCopyWithImpl<_QMessageButtonPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QMessageButtonPayloadToJson(this);
  }
}

abstract class _QMessageButtonPayload implements QMessageButtonPayload {
  const factory _QMessageButtonPayload(
      {required String text,
      required List<QButtons> buttons,
      required String type}) = _$_QMessageButtonPayload;

  factory _QMessageButtonPayload.fromJson(Map<String, dynamic> json) =
      _$_QMessageButtonPayload.fromJson;

  @override
  String get text;
  @override
  List<QButtons> get buttons;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$QMessageButtonPayloadCopyWith<_QMessageButtonPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

QButtons _$QButtonsFromJson(Map<String, dynamic> json) {
  return _QButtons.fromJson(json);
}

/// @nodoc
class _$QButtonsTearOff {
  const _$QButtonsTearOff();

  _QButtons call(
      {required String label,
      @JsonKey(name: 'postback_text') required String postbackText,
      required String type,
      required QButtonsPostbackPayload payload}) {
    return _QButtons(
      label: label,
      postbackText: postbackText,
      type: type,
      payload: payload,
    );
  }

  QButtons fromJson(Map<String, Object?> json) {
    return QButtons.fromJson(json);
  }
}

/// @nodoc
const $QButtons = _$QButtonsTearOff();

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
abstract class _$QButtonsCopyWith<$Res> implements $QButtonsCopyWith<$Res> {
  factory _$QButtonsCopyWith(_QButtons value, $Res Function(_QButtons) then) =
      __$QButtonsCopyWithImpl<$Res>;
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
class __$QButtonsCopyWithImpl<$Res> extends _$QButtonsCopyWithImpl<$Res>
    implements _$QButtonsCopyWith<$Res> {
  __$QButtonsCopyWithImpl(_QButtons _value, $Res Function(_QButtons) _then)
      : super(_value, (v) => _then(v as _QButtons));

  @override
  _QButtons get _value => super._value as _QButtons;

  @override
  $Res call({
    Object? label = freezed,
    Object? postbackText = freezed,
    Object? type = freezed,
    Object? payload = freezed,
  }) {
    return _then(_QButtons(
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
            other is _QButtons &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality()
                .equals(other.postbackText, postbackText) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(label),
      const DeepCollectionEquality().hash(postbackText),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(payload));

  @JsonKey(ignore: true)
  @override
  _$QButtonsCopyWith<_QButtons> get copyWith =>
      __$QButtonsCopyWithImpl<_QButtons>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QButtonsToJson(this);
  }
}

abstract class _QButtons implements QButtons {
  const factory _QButtons(
      {required String label,
      @JsonKey(name: 'postback_text') required String postbackText,
      required String type,
      required QButtonsPostbackPayload payload}) = _$_QButtons;

  factory _QButtons.fromJson(Map<String, dynamic> json) = _$_QButtons.fromJson;

  @override
  String get label;
  @override
  @JsonKey(name: 'postback_text')
  String get postbackText;
  @override
  String get type;
  @override
  QButtonsPostbackPayload get payload;
  @override
  @JsonKey(ignore: true)
  _$QButtonsCopyWith<_QButtons> get copyWith =>
      throw _privateConstructorUsedError;
}

QButtonsPostbackPayload _$QButtonsPostbackPayloadFromJson(
    Map<String, dynamic> json) {
  return _QButtonsPayload.fromJson(json);
}

/// @nodoc
class _$QButtonsPostbackPayloadTearOff {
  const _$QButtonsPostbackPayloadTearOff();

  _QButtonsPayload call(
      {required String url,
      required String method,
      required Map<String, Object?>? payload}) {
    return _QButtonsPayload(
      url: url,
      method: method,
      payload: payload,
    );
  }

  QButtonsPostbackPayload fromJson(Map<String, Object?> json) {
    return QButtonsPostbackPayload.fromJson(json);
  }
}

/// @nodoc
const $QButtonsPostbackPayload = _$QButtonsPostbackPayloadTearOff();

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
abstract class _$QButtonsPayloadCopyWith<$Res>
    implements $QButtonsPostbackPayloadCopyWith<$Res> {
  factory _$QButtonsPayloadCopyWith(
          _QButtonsPayload value, $Res Function(_QButtonsPayload) then) =
      __$QButtonsPayloadCopyWithImpl<$Res>;
  @override
  $Res call({String url, String method, Map<String, Object?>? payload});
}

/// @nodoc
class __$QButtonsPayloadCopyWithImpl<$Res>
    extends _$QButtonsPostbackPayloadCopyWithImpl<$Res>
    implements _$QButtonsPayloadCopyWith<$Res> {
  __$QButtonsPayloadCopyWithImpl(
      _QButtonsPayload _value, $Res Function(_QButtonsPayload) _then)
      : super(_value, (v) => _then(v as _QButtonsPayload));

  @override
  _QButtonsPayload get _value => super._value as _QButtonsPayload;

  @override
  $Res call({
    Object? url = freezed,
    Object? method = freezed,
    Object? payload = freezed,
  }) {
    return _then(_QButtonsPayload(
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
@JsonSerializable()
class _$_QButtonsPayload implements _QButtonsPayload {
  const _$_QButtonsPayload(
      {required this.url, required this.method, required this.payload});

  factory _$_QButtonsPayload.fromJson(Map<String, dynamic> json) =>
      _$$_QButtonsPayloadFromJson(json);

  @override
  final String url;
  @override
  final String method;
  @override
  final Map<String, Object?>? payload;

  @override
  String toString() {
    return 'QButtonsPostbackPayload(url: $url, method: $method, payload: $payload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QButtonsPayload &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.method, method) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(method),
      const DeepCollectionEquality().hash(payload));

  @JsonKey(ignore: true)
  @override
  _$QButtonsPayloadCopyWith<_QButtonsPayload> get copyWith =>
      __$QButtonsPayloadCopyWithImpl<_QButtonsPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QButtonsPayloadToJson(this);
  }
}

abstract class _QButtonsPayload implements QButtonsPostbackPayload {
  const factory _QButtonsPayload(
      {required String url,
      required String method,
      required Map<String, Object?>? payload}) = _$_QButtonsPayload;

  factory _QButtonsPayload.fromJson(Map<String, dynamic> json) =
      _$_QButtonsPayload.fromJson;

  @override
  String get url;
  @override
  String get method;
  @override
  Map<String, Object?>? get payload;
  @override
  @JsonKey(ignore: true)
  _$QButtonsPayloadCopyWith<_QButtonsPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
