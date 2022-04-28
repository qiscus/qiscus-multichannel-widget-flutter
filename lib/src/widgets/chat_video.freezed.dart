// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QImagePayload _$QImagePayloadFromJson(Map<String, dynamic> json) {
  return _QImagePayload.fromJson(json);
}

/// @nodoc
class _$QImagePayloadTearOff {
  const _$QImagePayloadTearOff();

  _QImagePayload call(
      {required String url,
      required String? caption,
      @JsonKey(name: 'file_name') required String? fileName,
      required int? size,
      required int? pages,
      @JsonKey(name: 'encryption_key') required String? encryptionKey}) {
    return _QImagePayload(
      url: url,
      caption: caption,
      fileName: fileName,
      size: size,
      pages: pages,
      encryptionKey: encryptionKey,
    );
  }

  QImagePayload fromJson(Map<String, Object?> json) {
    return QImagePayload.fromJson(json);
  }
}

/// @nodoc
const $QImagePayload = _$QImagePayloadTearOff();

/// @nodoc
mixin _$QImagePayload {
  String get url => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_name')
  String? get fileName => throw _privateConstructorUsedError;
  int? get size => throw _privateConstructorUsedError;
  int? get pages => throw _privateConstructorUsedError;
  @JsonKey(name: 'encryption_key')
  String? get encryptionKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QImagePayloadCopyWith<QImagePayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QImagePayloadCopyWith<$Res> {
  factory $QImagePayloadCopyWith(
          QImagePayload value, $Res Function(QImagePayload) then) =
      _$QImagePayloadCopyWithImpl<$Res>;
  $Res call(
      {String url,
      String? caption,
      @JsonKey(name: 'file_name') String? fileName,
      int? size,
      int? pages,
      @JsonKey(name: 'encryption_key') String? encryptionKey});
}

/// @nodoc
class _$QImagePayloadCopyWithImpl<$Res>
    implements $QImagePayloadCopyWith<$Res> {
  _$QImagePayloadCopyWithImpl(this._value, this._then);

  final QImagePayload _value;
  // ignore: unused_field
  final $Res Function(QImagePayload) _then;

  @override
  $Res call({
    Object? url = freezed,
    Object? caption = freezed,
    Object? fileName = freezed,
    Object? size = freezed,
    Object? pages = freezed,
    Object? encryptionKey = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      caption: caption == freezed
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: fileName == freezed
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      pages: pages == freezed
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as int?,
      encryptionKey: encryptionKey == freezed
          ? _value.encryptionKey
          : encryptionKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$QImagePayloadCopyWith<$Res>
    implements $QImagePayloadCopyWith<$Res> {
  factory _$QImagePayloadCopyWith(
          _QImagePayload value, $Res Function(_QImagePayload) then) =
      __$QImagePayloadCopyWithImpl<$Res>;
  @override
  $Res call(
      {String url,
      String? caption,
      @JsonKey(name: 'file_name') String? fileName,
      int? size,
      int? pages,
      @JsonKey(name: 'encryption_key') String? encryptionKey});
}

/// @nodoc
class __$QImagePayloadCopyWithImpl<$Res>
    extends _$QImagePayloadCopyWithImpl<$Res>
    implements _$QImagePayloadCopyWith<$Res> {
  __$QImagePayloadCopyWithImpl(
      _QImagePayload _value, $Res Function(_QImagePayload) _then)
      : super(_value, (v) => _then(v as _QImagePayload));

  @override
  _QImagePayload get _value => super._value as _QImagePayload;

  @override
  $Res call({
    Object? url = freezed,
    Object? caption = freezed,
    Object? fileName = freezed,
    Object? size = freezed,
    Object? pages = freezed,
    Object? encryptionKey = freezed,
  }) {
    return _then(_QImagePayload(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      caption: caption == freezed
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: fileName == freezed
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      pages: pages == freezed
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as int?,
      encryptionKey: encryptionKey == freezed
          ? _value.encryptionKey
          : encryptionKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QImagePayload implements _QImagePayload {
  const _$_QImagePayload(
      {required this.url,
      required this.caption,
      @JsonKey(name: 'file_name') required this.fileName,
      required this.size,
      required this.pages,
      @JsonKey(name: 'encryption_key') required this.encryptionKey});

  factory _$_QImagePayload.fromJson(Map<String, dynamic> json) =>
      _$$_QImagePayloadFromJson(json);

  @override
  final String url;
  @override
  final String? caption;
  @override
  @JsonKey(name: 'file_name')
  final String? fileName;
  @override
  final int? size;
  @override
  final int? pages;
  @override
  @JsonKey(name: 'encryption_key')
  final String? encryptionKey;

  @override
  String toString() {
    return 'QImagePayload(url: $url, caption: $caption, fileName: $fileName, size: $size, pages: $pages, encryptionKey: $encryptionKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QImagePayload &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.caption, caption) &&
            const DeepCollectionEquality().equals(other.fileName, fileName) &&
            const DeepCollectionEquality().equals(other.size, size) &&
            const DeepCollectionEquality().equals(other.pages, pages) &&
            const DeepCollectionEquality()
                .equals(other.encryptionKey, encryptionKey));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(caption),
      const DeepCollectionEquality().hash(fileName),
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(pages),
      const DeepCollectionEquality().hash(encryptionKey));

  @JsonKey(ignore: true)
  @override
  _$QImagePayloadCopyWith<_QImagePayload> get copyWith =>
      __$QImagePayloadCopyWithImpl<_QImagePayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QImagePayloadToJson(this);
  }
}

abstract class _QImagePayload implements QImagePayload {
  const factory _QImagePayload(
          {required String url,
          required String? caption,
          @JsonKey(name: 'file_name') required String? fileName,
          required int? size,
          required int? pages,
          @JsonKey(name: 'encryption_key') required String? encryptionKey}) =
      _$_QImagePayload;

  factory _QImagePayload.fromJson(Map<String, dynamic> json) =
      _$_QImagePayload.fromJson;

  @override
  String get url;
  @override
  String? get caption;
  @override
  @JsonKey(name: 'file_name')
  String? get fileName;
  @override
  int? get size;
  @override
  int? get pages;
  @override
  @JsonKey(name: 'encryption_key')
  String? get encryptionKey;
  @override
  @JsonKey(ignore: true)
  _$QImagePayloadCopyWith<_QImagePayload> get copyWith =>
      throw _privateConstructorUsedError;
}
