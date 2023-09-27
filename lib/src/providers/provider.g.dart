// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: argument_type_not_assignable, implicit_dynamic_parameter, unused_element

part of 'provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SecureSession _$$_SecureSessionFromJson(Map<String, dynamic> json) =>
    _$_SecureSession(
      appId: json['appId'] as String,
      channelId: json['channelId'] as String,
      id: json['id'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$$_SecureSessionToJson(_$_SecureSession instance) =>
    <String, dynamic>{
      'appId': instance.appId,
      'channelId': instance.channelId,
      'id': instance.id,
      'userId': instance.userId,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$initiateChatHash() => r'8c3986c22e601262d87ce6c23bfe16da6f46cb93';

/// See also [initiateChat].
@ProviderFor(initiateChat)
final initiateChatProvider =
    AutoDisposeFutureProvider<Future<QChatRoom> Function()>.internal(
  initiateChat,
  name: r'initiateChatProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$initiateChatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InitiateChatRef
    = AutoDisposeFutureProviderRef<Future<QChatRoom> Function()>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
