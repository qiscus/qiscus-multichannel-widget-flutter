// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_carousel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QMessageCarouselPayload _$QMessageCarouselPayloadFromJson(
    Map<String, dynamic> json) {
  return _QMessageCarouselPayload.fromJson(json);
}

/// @nodoc
mixin _$QMessageCarouselPayload {
  List<QCarouselCard> get cards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QMessageCarouselPayloadCopyWith<QMessageCarouselPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QMessageCarouselPayloadCopyWith<$Res> {
  factory $QMessageCarouselPayloadCopyWith(QMessageCarouselPayload value,
          $Res Function(QMessageCarouselPayload) then) =
      _$QMessageCarouselPayloadCopyWithImpl<$Res, QMessageCarouselPayload>;
  @useResult
  $Res call({List<QCarouselCard> cards});
}

/// @nodoc
class _$QMessageCarouselPayloadCopyWithImpl<$Res,
        $Val extends QMessageCarouselPayload>
    implements $QMessageCarouselPayloadCopyWith<$Res> {
  _$QMessageCarouselPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_value.copyWith(
      cards: null == cards
          ? _value.cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<QCarouselCard>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QMessageCarouselPayloadCopyWith<$Res>
    implements $QMessageCarouselPayloadCopyWith<$Res> {
  factory _$$_QMessageCarouselPayloadCopyWith(_$_QMessageCarouselPayload value,
          $Res Function(_$_QMessageCarouselPayload) then) =
      __$$_QMessageCarouselPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<QCarouselCard> cards});
}

/// @nodoc
class __$$_QMessageCarouselPayloadCopyWithImpl<$Res>
    extends _$QMessageCarouselPayloadCopyWithImpl<$Res,
        _$_QMessageCarouselPayload>
    implements _$$_QMessageCarouselPayloadCopyWith<$Res> {
  __$$_QMessageCarouselPayloadCopyWithImpl(_$_QMessageCarouselPayload _value,
      $Res Function(_$_QMessageCarouselPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cards = null,
  }) {
    return _then(_$_QMessageCarouselPayload(
      cards: null == cards
          ? _value._cards
          : cards // ignore: cast_nullable_to_non_nullable
              as List<QCarouselCard>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QMessageCarouselPayload implements _QMessageCarouselPayload {
  const _$_QMessageCarouselPayload({required final List<QCarouselCard> cards})
      : _cards = cards;

  factory _$_QMessageCarouselPayload.fromJson(Map<String, dynamic> json) =>
      _$$_QMessageCarouselPayloadFromJson(json);

  final List<QCarouselCard> _cards;
  @override
  List<QCarouselCard> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  @override
  String toString() {
    return 'QMessageCarouselPayload(cards: $cards)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QMessageCarouselPayload &&
            const DeepCollectionEquality().equals(other._cards, _cards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_cards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QMessageCarouselPayloadCopyWith<_$_QMessageCarouselPayload>
      get copyWith =>
          __$$_QMessageCarouselPayloadCopyWithImpl<_$_QMessageCarouselPayload>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QMessageCarouselPayloadToJson(
      this,
    );
  }
}

abstract class _QMessageCarouselPayload implements QMessageCarouselPayload {
  const factory _QMessageCarouselPayload(
      {required final List<QCarouselCard> cards}) = _$_QMessageCarouselPayload;

  factory _QMessageCarouselPayload.fromJson(Map<String, dynamic> json) =
      _$_QMessageCarouselPayload.fromJson;

  @override
  List<QCarouselCard> get cards;
  @override
  @JsonKey(ignore: true)
  _$$_QMessageCarouselPayloadCopyWith<_$_QMessageCarouselPayload>
      get copyWith => throw _privateConstructorUsedError;
}

QCarouselCard _$QCarouselCardFromJson(Map<String, dynamic> json) {
  return _QCarouselCard.fromJson(json);
}

/// @nodoc
mixin _$QCarouselCard {
  String get image => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'default_action')
  QCarouselAction get defaultAction => throw _privateConstructorUsedError;
  List<QButtons> get buttons => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QCarouselCardCopyWith<QCarouselCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QCarouselCardCopyWith<$Res> {
  factory $QCarouselCardCopyWith(
          QCarouselCard value, $Res Function(QCarouselCard) then) =
      _$QCarouselCardCopyWithImpl<$Res, QCarouselCard>;
  @useResult
  $Res call(
      {String image,
      String title,
      String? description,
      @JsonKey(name: 'default_action') QCarouselAction defaultAction,
      List<QButtons> buttons});

  $QCarouselActionCopyWith<$Res> get defaultAction;
}

/// @nodoc
class _$QCarouselCardCopyWithImpl<$Res, $Val extends QCarouselCard>
    implements $QCarouselCardCopyWith<$Res> {
  _$QCarouselCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? title = null,
    Object? description = freezed,
    Object? defaultAction = null,
    Object? buttons = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultAction: null == defaultAction
          ? _value.defaultAction
          : defaultAction // ignore: cast_nullable_to_non_nullable
              as QCarouselAction,
      buttons: null == buttons
          ? _value.buttons
          : buttons // ignore: cast_nullable_to_non_nullable
              as List<QButtons>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QCarouselActionCopyWith<$Res> get defaultAction {
    return $QCarouselActionCopyWith<$Res>(_value.defaultAction, (value) {
      return _then(_value.copyWith(defaultAction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_QCarouselCardCopyWith<$Res>
    implements $QCarouselCardCopyWith<$Res> {
  factory _$$_QCarouselCardCopyWith(
          _$_QCarouselCard value, $Res Function(_$_QCarouselCard) then) =
      __$$_QCarouselCardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String image,
      String title,
      String? description,
      @JsonKey(name: 'default_action') QCarouselAction defaultAction,
      List<QButtons> buttons});

  @override
  $QCarouselActionCopyWith<$Res> get defaultAction;
}

/// @nodoc
class __$$_QCarouselCardCopyWithImpl<$Res>
    extends _$QCarouselCardCopyWithImpl<$Res, _$_QCarouselCard>
    implements _$$_QCarouselCardCopyWith<$Res> {
  __$$_QCarouselCardCopyWithImpl(
      _$_QCarouselCard _value, $Res Function(_$_QCarouselCard) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? title = null,
    Object? description = freezed,
    Object? defaultAction = null,
    Object? buttons = null,
  }) {
    return _then(_$_QCarouselCard(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultAction: null == defaultAction
          ? _value.defaultAction
          : defaultAction // ignore: cast_nullable_to_non_nullable
              as QCarouselAction,
      buttons: null == buttons
          ? _value._buttons
          : buttons // ignore: cast_nullable_to_non_nullable
              as List<QButtons>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QCarouselCard implements _QCarouselCard {
  const _$_QCarouselCard(
      {required this.image,
      required this.title,
      this.description,
      @JsonKey(name: 'default_action') required this.defaultAction,
      required final List<QButtons> buttons})
      : _buttons = buttons;

  factory _$_QCarouselCard.fromJson(Map<String, dynamic> json) =>
      _$$_QCarouselCardFromJson(json);

  @override
  final String image;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey(name: 'default_action')
  final QCarouselAction defaultAction;
  final List<QButtons> _buttons;
  @override
  List<QButtons> get buttons {
    if (_buttons is EqualUnmodifiableListView) return _buttons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_buttons);
  }

  @override
  String toString() {
    return 'QCarouselCard(image: $image, title: $title, description: $description, defaultAction: $defaultAction, buttons: $buttons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QCarouselCard &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.defaultAction, defaultAction) ||
                other.defaultAction == defaultAction) &&
            const DeepCollectionEquality().equals(other._buttons, _buttons));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, image, title, description,
      defaultAction, const DeepCollectionEquality().hash(_buttons));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QCarouselCardCopyWith<_$_QCarouselCard> get copyWith =>
      __$$_QCarouselCardCopyWithImpl<_$_QCarouselCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QCarouselCardToJson(
      this,
    );
  }
}

abstract class _QCarouselCard implements QCarouselCard {
  const factory _QCarouselCard(
      {required final String image,
      required final String title,
      final String? description,
      @JsonKey(name: 'default_action')
      required final QCarouselAction defaultAction,
      required final List<QButtons> buttons}) = _$_QCarouselCard;

  factory _QCarouselCard.fromJson(Map<String, dynamic> json) =
      _$_QCarouselCard.fromJson;

  @override
  String get image;
  @override
  String get title;
  @override
  String? get description;
  @override
  @JsonKey(name: 'default_action')
  QCarouselAction get defaultAction;
  @override
  List<QButtons> get buttons;
  @override
  @JsonKey(ignore: true)
  _$$_QCarouselCardCopyWith<_$_QCarouselCard> get copyWith =>
      throw _privateConstructorUsedError;
}

QCarouselAction _$QCarouselActionFromJson(Map<String, dynamic> json) {
  return _QCarouselAction.fromJson(json);
}

/// @nodoc
mixin _$QCarouselAction {
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'postback_text')
  String get postbackText => throw _privateConstructorUsedError;
  QCarouselActionPayload get payload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QCarouselActionCopyWith<QCarouselAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QCarouselActionCopyWith<$Res> {
  factory $QCarouselActionCopyWith(
          QCarouselAction value, $Res Function(QCarouselAction) then) =
      _$QCarouselActionCopyWithImpl<$Res, QCarouselAction>;
  @useResult
  $Res call(
      {String type,
      @JsonKey(name: 'postback_text') String postbackText,
      QCarouselActionPayload payload});

  $QCarouselActionPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class _$QCarouselActionCopyWithImpl<$Res, $Val extends QCarouselAction>
    implements $QCarouselActionCopyWith<$Res> {
  _$QCarouselActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? postbackText = null,
    Object? payload = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      postbackText: null == postbackText
          ? _value.postbackText
          : postbackText // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as QCarouselActionPayload,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QCarouselActionPayloadCopyWith<$Res> get payload {
    return $QCarouselActionPayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_QCarouselActionCopyWith<$Res>
    implements $QCarouselActionCopyWith<$Res> {
  factory _$$_QCarouselActionCopyWith(
          _$_QCarouselAction value, $Res Function(_$_QCarouselAction) then) =
      __$$_QCarouselActionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      @JsonKey(name: 'postback_text') String postbackText,
      QCarouselActionPayload payload});

  @override
  $QCarouselActionPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$_QCarouselActionCopyWithImpl<$Res>
    extends _$QCarouselActionCopyWithImpl<$Res, _$_QCarouselAction>
    implements _$$_QCarouselActionCopyWith<$Res> {
  __$$_QCarouselActionCopyWithImpl(
      _$_QCarouselAction _value, $Res Function(_$_QCarouselAction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? postbackText = null,
    Object? payload = null,
  }) {
    return _then(_$_QCarouselAction(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      postbackText: null == postbackText
          ? _value.postbackText
          : postbackText // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as QCarouselActionPayload,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QCarouselAction implements _QCarouselAction {
  const _$_QCarouselAction(
      {required this.type,
      @JsonKey(name: 'postback_text') required this.postbackText,
      required this.payload});

  factory _$_QCarouselAction.fromJson(Map<String, dynamic> json) =>
      _$$_QCarouselActionFromJson(json);

  @override
  final String type;
  @override
  @JsonKey(name: 'postback_text')
  final String postbackText;
  @override
  final QCarouselActionPayload payload;

  @override
  String toString() {
    return 'QCarouselAction(type: $type, postbackText: $postbackText, payload: $payload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QCarouselAction &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.postbackText, postbackText) ||
                other.postbackText == postbackText) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, postbackText, payload);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QCarouselActionCopyWith<_$_QCarouselAction> get copyWith =>
      __$$_QCarouselActionCopyWithImpl<_$_QCarouselAction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QCarouselActionToJson(
      this,
    );
  }
}

abstract class _QCarouselAction implements QCarouselAction {
  const factory _QCarouselAction(
      {required final String type,
      @JsonKey(name: 'postback_text') required final String postbackText,
      required final QCarouselActionPayload payload}) = _$_QCarouselAction;

  factory _QCarouselAction.fromJson(Map<String, dynamic> json) =
      _$_QCarouselAction.fromJson;

  @override
  String get type;
  @override
  @JsonKey(name: 'postback_text')
  String get postbackText;
  @override
  QCarouselActionPayload get payload;
  @override
  @JsonKey(ignore: true)
  _$$_QCarouselActionCopyWith<_$_QCarouselAction> get copyWith =>
      throw _privateConstructorUsedError;
}

QCarouselActionPayload _$QCarouselActionPayloadFromJson(
    Map<String, dynamic> json) {
  return _QCarouselActionPayload.fromJson(json);
}

/// @nodoc
mixin _$QCarouselActionPayload {
  String get method => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  Map<String, Object?>? get payload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QCarouselActionPayloadCopyWith<QCarouselActionPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QCarouselActionPayloadCopyWith<$Res> {
  factory $QCarouselActionPayloadCopyWith(QCarouselActionPayload value,
          $Res Function(QCarouselActionPayload) then) =
      _$QCarouselActionPayloadCopyWithImpl<$Res, QCarouselActionPayload>;
  @useResult
  $Res call({String method, String url, Map<String, Object?>? payload});
}

/// @nodoc
class _$QCarouselActionPayloadCopyWithImpl<$Res,
        $Val extends QCarouselActionPayload>
    implements $QCarouselActionPayloadCopyWith<$Res> {
  _$QCarouselActionPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? url = null,
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QCarouselActionPayloadCopyWith<$Res>
    implements $QCarouselActionPayloadCopyWith<$Res> {
  factory _$$_QCarouselActionPayloadCopyWith(_$_QCarouselActionPayload value,
          $Res Function(_$_QCarouselActionPayload) then) =
      __$$_QCarouselActionPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String method, String url, Map<String, Object?>? payload});
}

/// @nodoc
class __$$_QCarouselActionPayloadCopyWithImpl<$Res>
    extends _$QCarouselActionPayloadCopyWithImpl<$Res,
        _$_QCarouselActionPayload>
    implements _$$_QCarouselActionPayloadCopyWith<$Res> {
  __$$_QCarouselActionPayloadCopyWithImpl(_$_QCarouselActionPayload _value,
      $Res Function(_$_QCarouselActionPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? url = null,
    Object? payload = freezed,
  }) {
    return _then(_$_QCarouselActionPayload(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
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
class _$_QCarouselActionPayload implements _QCarouselActionPayload {
  const _$_QCarouselActionPayload(
      {required this.method,
      required this.url,
      final Map<String, Object?>? payload})
      : _payload = payload;

  factory _$_QCarouselActionPayload.fromJson(Map<String, dynamic> json) =>
      _$$_QCarouselActionPayloadFromJson(json);

  @override
  final String method;
  @override
  final String url;
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
    return 'QCarouselActionPayload(method: $method, url: $url, payload: $payload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QCarouselActionPayload &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, method, url, const DeepCollectionEquality().hash(_payload));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QCarouselActionPayloadCopyWith<_$_QCarouselActionPayload> get copyWith =>
      __$$_QCarouselActionPayloadCopyWithImpl<_$_QCarouselActionPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QCarouselActionPayloadToJson(
      this,
    );
  }
}

abstract class _QCarouselActionPayload implements QCarouselActionPayload {
  const factory _QCarouselActionPayload(
      {required final String method,
      required final String url,
      final Map<String, Object?>? payload}) = _$_QCarouselActionPayload;

  factory _QCarouselActionPayload.fromJson(Map<String, dynamic> json) =
      _$_QCarouselActionPayload.fromJson;

  @override
  String get method;
  @override
  String get url;
  @override
  Map<String, Object?>? get payload;
  @override
  @JsonKey(ignore: true)
  _$$_QCarouselActionPayloadCopyWith<_$_QCarouselActionPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
