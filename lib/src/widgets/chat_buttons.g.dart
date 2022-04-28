// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_buttons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QMessageButtonPayload _$$_QMessageButtonPayloadFromJson(
        Map<String, dynamic> json) =>
    _$_QMessageButtonPayload(
      text: json['text'] as String,
      buttons: (json['buttons'] as List<dynamic>)
          .map((e) => QButtons.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$_QMessageButtonPayloadToJson(
        _$_QMessageButtonPayload instance) =>
    <String, dynamic>{
      'text': instance.text,
      'buttons': instance.buttons,
      'type': instance.type,
    };

_$_QButtons _$$_QButtonsFromJson(Map<String, dynamic> json) => _$_QButtons(
      label: json['label'] as String,
      postbackText: json['postback_text'] as String,
      type: json['type'] as String,
      payload: QButtonsPostbackPayload.fromJson(
          json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_QButtonsToJson(_$_QButtons instance) =>
    <String, dynamic>{
      'label': instance.label,
      'postback_text': instance.postbackText,
      'type': instance.type,
      'payload': instance.payload,
    };

_$_QButtonsPayload _$$_QButtonsPayloadFromJson(Map<String, dynamic> json) =>
    _$_QButtonsPayload(
      url: json['url'] as String,
      method: json['method'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_QButtonsPayloadToJson(_$_QButtonsPayload instance) =>
    <String, dynamic>{
      'url': instance.url,
      'method': instance.method,
      'payload': instance.payload,
    };
