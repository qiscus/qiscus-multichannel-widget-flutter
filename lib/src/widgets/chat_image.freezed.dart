// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QImagePayload _$QImagePayloadFromJson(Map<String, dynamic> json) {
  return _QImagePayload.fromJson(json);
}

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
      _$QImagePayloadCopyWithImpl<$Res, QImagePayload>;
  @useResult
  $Res call(
      {String url,
      String? caption,
      @JsonKey(name: 'file_name') String? fileName,
      int? size,
      int? pages,
      @JsonKey(name: 'encryption_key') String? encryptionKey});
}

/// @nodoc
class _$QImagePayloadCopyWithImpl<$Res, $Val extends QImagePayload>
    implements $QImagePayloadCopyWith<$Res> {
  _$QImagePayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? caption = freezed,
    Object? fileName = freezed,
    Object? size = freezed,
    Object? pages = freezed,
    Object? encryptionKey = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      pages: freezed == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as int?,
      encryptionKey: freezed == encryptionKey
          ? _value.encryptionKey
          : encryptionKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QImagePayloadCopyWith<$Res>
    implements $QImagePayloadCopyWith<$Res> {
  factory _$$_QImagePayloadCopyWith(
          _$_QImagePayload value, $Res Function(_$_QImagePayload) then) =
      __$$_QImagePayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String? caption,
      @JsonKey(name: 'file_name') String? fileName,
      int? size,
      int? pages,
      @JsonKey(name: 'encryption_key') String? encryptionKey});
}

/// @nodoc
class __$$_QImagePayloadCopyWithImpl<$Res>
    extends _$QImagePayloadCopyWithImpl<$Res, _$_QImagePayload>
    implements _$$_QImagePayloadCopyWith<$Res> {
  __$$_QImagePayloadCopyWithImpl(
      _$_QImagePayload _value, $Res Function(_$_QImagePayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? caption = freezed,
    Object? fileName = freezed,
    Object? size = freezed,
    Object? pages = freezed,
    Object? encryptionKey = freezed,
  }) {
    return _then(_$_QImagePayload(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
      pages: freezed == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as int?,
      encryptionKey: freezed == encryptionKey
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
            other is _$_QImagePayload &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.pages, pages) || other.pages == pages) &&
            (identical(other.encryptionKey, encryptionKey) ||
                other.encryptionKey == encryptionKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, caption, fileName, size, pages, encryptionKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QImagePayloadCopyWith<_$_QImagePayload> get copyWith =>
      __$$_QImagePayloadCopyWithImpl<_$_QImagePayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QImagePayloadToJson(
      this,
    );
  }
}

abstract class _QImagePayload implements QImagePayload {
  const factory _QImagePayload(
      {required final String url,
      required final String? caption,
      @JsonKey(name: 'file_name') required final String? fileName,
      required final int? size,
      required final int? pages,
      @JsonKey(name: 'encryption_key')
      required final String? encryptionKey}) = _$_QImagePayload;

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
  _$$_QImagePayloadCopyWith<_$_QImagePayload> get copyWith =>
      throw _privateConstructorUsedError;
}
