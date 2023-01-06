// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_parameter, unused_element

part of 'chat_carousel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QMessageCarouselPayload _$$_QMessageCarouselPayloadFromJson(
        Map<String, dynamic> json) =>
    _$_QMessageCarouselPayload(
      cards: (json['cards'] as List<dynamic>)
          .map((e) => QCarouselCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_QMessageCarouselPayloadToJson(
        _$_QMessageCarouselPayload instance) =>
    <String, dynamic>{
      'cards': instance.cards,
    };

_$_QCarouselCard _$$_QCarouselCardFromJson(Map<String, dynamic> json) =>
    _$_QCarouselCard(
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      defaultAction: QCarouselAction.fromJson(
          json['default_action'] as Map<String, dynamic>),
      buttons: (json['buttons'] as List<dynamic>)
          .map((e) => QButtons.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_QCarouselCardToJson(_$_QCarouselCard instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'default_action': instance.defaultAction,
      'buttons': instance.buttons,
    };

_$_QCarouselAction _$$_QCarouselActionFromJson(Map<String, dynamic> json) =>
    _$_QCarouselAction(
      type: json['type'] as String,
      postbackText: json['postback_text'] as String,
      payload: QCarouselActionPayload.fromJson(
          json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_QCarouselActionToJson(_$_QCarouselAction instance) =>
    <String, dynamic>{
      'type': instance.type,
      'postback_text': instance.postbackText,
      'payload': instance.payload,
    };

_$_QCarouselActionPayload _$$_QCarouselActionPayloadFromJson(
        Map<String, dynamic> json) =>
    _$_QCarouselActionPayload(
      method: json['method'] as String,
      url: json['url'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_QCarouselActionPayloadToJson(
        _$_QCarouselActionPayload instance) =>
    <String, dynamic>{
      'method': instance.method,
      'url': instance.url,
      'payload': instance.payload,
    };
