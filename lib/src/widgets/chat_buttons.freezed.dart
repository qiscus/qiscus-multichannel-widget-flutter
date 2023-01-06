// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_buttons.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QMessagePostbackResponse {
  int get roomId => throw _privateConstructorUsedError;
  QButtons get button => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QMessagePostbackResponseCopyWith<QMessagePostbackResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QMessagePostbackResponseCopyWith<$Res> {
  factory $QMessagePostbackResponseCopyWith(QMessagePostbackResponse value,
          $Res Function(QMessagePostbackResponse) then) =
      _$QMessagePostbackResponseCopyWithImpl<$Res, QMessagePostbackResponse>;
  @useResult
  $Res call({int roomId, QButtons button});

  $QButtonsCopyWith<$Res> get button;
}

/// @nodoc
class _$QMessagePostbackResponseCopyWithImpl<$Res,
        $Val extends QMessagePostbackResponse>
    implements $QMessagePostbackResponseCopyWith<$Res> {
  _$QMessagePostbackResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? button = null,
  }) {
    return _then(_value.copyWith(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      button: null == button
          ? _value.button
          : button // ignore: cast_nullable_to_non_nullable
              as QButtons,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QButtonsCopyWith<$Res> get button {
    return $QButtonsCopyWith<$Res>(_value.button, (value) {
      return _then(_value.copyWith(button: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_QMessagePostbackResponseCopyWith<$Res>
    implements $QMessagePostbackResponseCopyWith<$Res> {
  factory _$$_QMessagePostbackResponseCopyWith(
          _$_QMessagePostbackResponse value,
          $Res Function(_$_QMessagePostbackResponse) then) =
      __$$_QMessagePostbackResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int roomId, QButtons button});

  @override
  $QButtonsCopyWith<$Res> get button;
}

/// @nodoc
class __$$_QMessagePostbackResponseCopyWithImpl<$Res>
    extends _$QMessagePostbackResponseCopyWithImpl<$Res,
        _$_QMessagePostbackResponse>
    implements _$$_QMessagePostbackResponseCopyWith<$Res> {
  __$$_QMessagePostbackResponseCopyWithImpl(_$_QMessagePostbackResponse _value,
      $Res Function(_$_QMessagePostbackResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? button = null,
  }) {
    return _then(_$_QMessagePostbackResponse(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      button: null == button
          ? _value.button
          : button // ignore: cast_nullable_to_non_nullable
              as QButtons,
    ));
  }
}

/// @nodoc

class _$_QMessagePostbackResponse implements _QMessagePostbackResponse {
  const _$_QMessagePostbackResponse(
      {required this.roomId, required this.button});

  @override
  final int roomId;
  @override
  final QButtons button;

  @override
  String toString() {
    return 'QMessagePostbackResponse(roomId: $roomId, button: $button)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QMessagePostbackResponse &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.button, button) || other.button == button));
  }

  @override
  int get hashCode => Object.hash(runtimeType, roomId, button);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QMessagePostbackResponseCopyWith<_$_QMessagePostbackResponse>
      get copyWith => __$$_QMessagePostbackResponseCopyWithImpl<
          _$_QMessagePostbackResponse>(this, _$identity);
}

abstract class _QMessagePostbackResponse implements QMessagePostbackResponse {
  const factory _QMessagePostbackResponse(
      {required final int roomId,
      required final QButtons button}) = _$_QMessagePostbackResponse;

  @override
  int get roomId;
  @override
  QButtons get button;
  @override
  @JsonKey(ignore: true)
  _$$_QMessagePostbackResponseCopyWith<_$_QMessagePostbackResponse>
      get copyWith => throw _privateConstructorUsedError;
}

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
      _$QMessageButtonPayloadCopyWithImpl<$Res, QMessageButtonPayload>;
  @useResult
  $Res call({String text, List<QButtons> buttons, String type});
}

/// @nodoc
class _$QMessageButtonPayloadCopyWithImpl<$Res,
        $Val extends QMessageButtonPayload>
    implements $QMessageButtonPayloadCopyWith<$Res> {
  _$QMessageButtonPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? buttons = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      buttons: null == buttons
          ? _value.buttons
          : buttons // ignore: cast_nullable_to_non_nullable
              as List<QButtons>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QMessageButtonPayloadCopyWith<$Res>
    implements $QMessageButtonPayloadCopyWith<$Res> {
  factory _$$_QMessageButtonPayloadCopyWith(_$_QMessageButtonPayload value,
          $Res Function(_$_QMessageButtonPayload) then) =
      __$$_QMessageButtonPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, List<QButtons> buttons, String type});
}

/// @nodoc
class __$$_QMessageButtonPayloadCopyWithImpl<$Res>
    extends _$QMessageButtonPayloadCopyWithImpl<$Res, _$_QMessageButtonPayload>
    implements _$$_QMessageButtonPayloadCopyWith<$Res> {
  __$$_QMessageButtonPayloadCopyWithImpl(_$_QMessageButtonPayload _value,
      $Res Function(_$_QMessageButtonPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? buttons = null,
    Object? type = null,
  }) {
    return _then(_$_QMessageButtonPayload(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      buttons: null == buttons
          ? _value._buttons
          : buttons // ignore: cast_nullable_to_non_nullable
              as List<QButtons>,
      type: null == type
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
    if (_buttons is EqualUnmodifiableListView) return _buttons;
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
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._buttons, _buttons) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, text, const DeepCollectionEquality().hash(_buttons), type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QMessageButtonPayloadCopyWith<_$_QMessageButtonPayload> get copyWith =>
      __$$_QMessageButtonPayloadCopyWithImpl<_$_QMessageButtonPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QMessageButtonPayloadToJson(
      this,
    );
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
  String get text;
  @override
  List<QButtons> get buttons;
  @override
  String get type;
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
  String? get postbackText => throw _privateConstructorUsedError;
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
      _$QButtonsCopyWithImpl<$Res, QButtons>;
  @useResult
  $Res call(
      {String label,
      @JsonKey(name: 'postback_text') String? postbackText,
      String type,
      QButtonsPostbackPayload payload});

  $QButtonsPostbackPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class _$QButtonsCopyWithImpl<$Res, $Val extends QButtons>
    implements $QButtonsCopyWith<$Res> {
  _$QButtonsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? postbackText = freezed,
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      postbackText: freezed == postbackText
          ? _value.postbackText
          : postbackText // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as QButtonsPostbackPayload,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QButtonsPostbackPayloadCopyWith<$Res> get payload {
    return $QButtonsPostbackPayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_QButtonsCopyWith<$Res> implements $QButtonsCopyWith<$Res> {
  factory _$$_QButtonsCopyWith(
          _$_QButtons value, $Res Function(_$_QButtons) then) =
      __$$_QButtonsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String label,
      @JsonKey(name: 'postback_text') String? postbackText,
      String type,
      QButtonsPostbackPayload payload});

  @override
  $QButtonsPostbackPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$_QButtonsCopyWithImpl<$Res>
    extends _$QButtonsCopyWithImpl<$Res, _$_QButtons>
    implements _$$_QButtonsCopyWith<$Res> {
  __$$_QButtonsCopyWithImpl(
      _$_QButtons _value, $Res Function(_$_QButtons) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? postbackText = freezed,
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_$_QButtons(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      postbackText: freezed == postbackText
          ? _value.postbackText
          : postbackText // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
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
      @JsonKey(name: 'postback_text') this.postbackText,
      required this.type,
      required this.payload});

  factory _$_QButtons.fromJson(Map<String, dynamic> json) =>
      _$$_QButtonsFromJson(json);

  @override
  final String label;
  @override
  @JsonKey(name: 'postback_text')
  final String? postbackText;
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
            (identical(other.label, label) || other.label == label) &&
            (identical(other.postbackText, postbackText) ||
                other.postbackText == postbackText) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, label, postbackText, type, payload);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QButtonsCopyWith<_$_QButtons> get copyWith =>
      __$$_QButtonsCopyWithImpl<_$_QButtons>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QButtonsToJson(
      this,
    );
  }
}

abstract class _QButtons implements QButtons {
  const factory _QButtons(
      {required final String label,
      @JsonKey(name: 'postback_text') final String? postbackText,
      required final String type,
      required final QButtonsPostbackPayload payload}) = _$_QButtons;

  factory _QButtons.fromJson(Map<String, dynamic> json) = _$_QButtons.fromJson;

  @override
  String get label;
  @override
  @JsonKey(name: 'postback_text')
  String? get postbackText;
  @override
  String get type;
  @override
  QButtonsPostbackPayload get payload;
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
      _$QButtonsPostbackPayloadCopyWithImpl<$Res, QButtonsPostbackPayload>;
  @useResult
  $Res call({String url, String method, Map<String, Object?>? payload});
}

/// @nodoc
class _$QButtonsPostbackPayloadCopyWithImpl<$Res,
        $Val extends QButtonsPostbackPayload>
    implements $QButtonsPostbackPayloadCopyWith<$Res> {
  _$QButtonsPostbackPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? method = null,
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QButtonsPayloadCopyWith<$Res>
    implements $QButtonsPostbackPayloadCopyWith<$Res> {
  factory _$$_QButtonsPayloadCopyWith(
          _$_QButtonsPayload value, $Res Function(_$_QButtonsPayload) then) =
      __$$_QButtonsPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String method, Map<String, Object?>? payload});
}

/// @nodoc
class __$$_QButtonsPayloadCopyWithImpl<$Res>
    extends _$QButtonsPostbackPayloadCopyWithImpl<$Res, _$_QButtonsPayload>
    implements _$$_QButtonsPayloadCopyWith<$Res> {
  __$$_QButtonsPayloadCopyWithImpl(
      _$_QButtonsPayload _value, $Res Function(_$_QButtonsPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? method = null,
    Object? payload = freezed,
  }) {
    return _then(_$_QButtonsPayload(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
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
    if (_payload is EqualUnmodifiableMapView) return _payload;
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
            (identical(other.url, url) || other.url == url) &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, method, const DeepCollectionEquality().hash(_payload));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QButtonsPayloadCopyWith<_$_QButtonsPayload> get copyWith =>
      __$$_QButtonsPayloadCopyWithImpl<_$_QButtonsPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QButtonsPayloadToJson(
      this,
    );
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
  String get url;
  @override
  String get method;
  @override
  Map<String, Object?>? get payload;
  @override
  @JsonKey(ignore: true)
  _$$_QButtonsPayloadCopyWith<_$_QButtonsPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
