// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_parameter, unused_element

part of 'chat_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QImagePayload _$$_QImagePayloadFromJson(Map<String, dynamic> json) =>
    _$_QImagePayload(
      url: json['url'] as String,
      caption: json['caption'] as String?,
      fileName: json['file_name'] as String?,
      size: json['size'] as int?,
      pages: json['pages'] as int?,
      encryptionKey: json['encryption_key'] as String?,
    );

Map<String, dynamic> _$$_QImagePayloadToJson(_$_QImagePayload instance) =>
    <String, dynamic>{
      'url': instance.url,
      'caption': instance.caption,
      'file_name': instance.fileName,
      'size': instance.size,
      'pages': instance.pages,
      'encryption_key': instance.encryptionKey,
    };
