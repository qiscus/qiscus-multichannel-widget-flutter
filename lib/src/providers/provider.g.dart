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

String _$accountHash() => r'6b6be5c7243da64f8528583dc05f975f34cab36a';

/// See also [account].
@ProviderFor(account)
final accountProvider = AutoDisposeProvider<AsyncValue<QAccount>>.internal(
  account,
  name: r'accountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountRef = AutoDisposeProviderRef<AsyncValue<QAccount>>;
String _$accountIdHash() => r'7caebde3ae605e6285244f1c08e53341cb4c74a0';

/// See also [accountId].
@ProviderFor(accountId)
final accountIdProvider = AutoDisposeProvider<String?>.internal(
  accountId,
  name: r'accountIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$accountIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountIdRef = AutoDisposeProviderRef<String?>;
String _$avatarUrlHash() => r'd1c00e546e8e5e6171f20806219556e43dd1d099';

/// See also [avatarUrl].
@ProviderFor(avatarUrl)
final avatarUrlProvider = AutoDisposeProvider<String?>.internal(
  avatarUrl,
  name: r'avatarUrlProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$avatarUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AvatarUrlRef = AutoDisposeProviderRef<String?>;
String _$chatBubbleFgColorHash() => r'b3ec1dbb2ea83f013241c4685f3fe066708abeba';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [chatBubbleFgColor].
@ProviderFor(chatBubbleFgColor)
const chatBubbleFgColorProvider = ChatBubbleFgColorFamily();

/// See also [chatBubbleFgColor].
class ChatBubbleFgColorFamily extends Family<Color> {
  /// See also [chatBubbleFgColor].
  const ChatBubbleFgColorFamily();

  /// See also [chatBubbleFgColor].
  ChatBubbleFgColorProvider call(
    QUser sender,
  ) {
    return ChatBubbleFgColorProvider(
      sender,
    );
  }

  @override
  ChatBubbleFgColorProvider getProviderOverride(
    covariant ChatBubbleFgColorProvider provider,
  ) {
    return call(
      provider.sender,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatBubbleFgColorProvider';
}

/// See also [chatBubbleFgColor].
class ChatBubbleFgColorProvider extends AutoDisposeProvider<Color> {
  /// See also [chatBubbleFgColor].
  ChatBubbleFgColorProvider(
    QUser sender,
  ) : this._internal(
          (ref) => chatBubbleFgColor(
            ref as ChatBubbleFgColorRef,
            sender,
          ),
          from: chatBubbleFgColorProvider,
          name: r'chatBubbleFgColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatBubbleFgColorHash,
          dependencies: ChatBubbleFgColorFamily._dependencies,
          allTransitiveDependencies:
              ChatBubbleFgColorFamily._allTransitiveDependencies,
          sender: sender,
        );

  ChatBubbleFgColorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sender,
  }) : super.internal();

  final QUser sender;

  @override
  Override overrideWith(
    Color Function(ChatBubbleFgColorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatBubbleFgColorProvider._internal(
        (ref) => create(ref as ChatBubbleFgColorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sender: sender,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Color> createElement() {
    return _ChatBubbleFgColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatBubbleFgColorProvider && other.sender == sender;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sender.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatBubbleFgColorRef on AutoDisposeProviderRef<Color> {
  /// The parameter `sender` of this provider.
  QUser get sender;
}

class _ChatBubbleFgColorProviderElement
    extends AutoDisposeProviderElement<Color> with ChatBubbleFgColorRef {
  _ChatBubbleFgColorProviderElement(super.provider);

  @override
  QUser get sender => (origin as ChatBubbleFgColorProvider).sender;
}

String _$chatBubbleBgColorHash() => r'2f4109db6abc634f3b6f95739351a1001034149e';

/// See also [chatBubbleBgColor].
@ProviderFor(chatBubbleBgColor)
const chatBubbleBgColorProvider = ChatBubbleBgColorFamily();

/// See also [chatBubbleBgColor].
class ChatBubbleBgColorFamily extends Family<Color> {
  /// See also [chatBubbleBgColor].
  const ChatBubbleBgColorFamily();

  /// See also [chatBubbleBgColor].
  ChatBubbleBgColorProvider call(
    QUser sender,
  ) {
    return ChatBubbleBgColorProvider(
      sender,
    );
  }

  @override
  ChatBubbleBgColorProvider getProviderOverride(
    covariant ChatBubbleBgColorProvider provider,
  ) {
    return call(
      provider.sender,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'chatBubbleBgColorProvider';
}

/// See also [chatBubbleBgColor].
class ChatBubbleBgColorProvider extends AutoDisposeProvider<Color> {
  /// See also [chatBubbleBgColor].
  ChatBubbleBgColorProvider(
    QUser sender,
  ) : this._internal(
          (ref) => chatBubbleBgColor(
            ref as ChatBubbleBgColorRef,
            sender,
          ),
          from: chatBubbleBgColorProvider,
          name: r'chatBubbleBgColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatBubbleBgColorHash,
          dependencies: ChatBubbleBgColorFamily._dependencies,
          allTransitiveDependencies:
              ChatBubbleBgColorFamily._allTransitiveDependencies,
          sender: sender,
        );

  ChatBubbleBgColorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sender,
  }) : super.internal();

  final QUser sender;

  @override
  Override overrideWith(
    Color Function(ChatBubbleBgColorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatBubbleBgColorProvider._internal(
        (ref) => create(ref as ChatBubbleBgColorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sender: sender,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Color> createElement() {
    return _ChatBubbleBgColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatBubbleBgColorProvider && other.sender == sender;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sender.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatBubbleBgColorRef on AutoDisposeProviderRef<Color> {
  /// The parameter `sender` of this provider.
  QUser get sender;
}

class _ChatBubbleBgColorProviderElement
    extends AutoDisposeProviderElement<Color> with ChatBubbleBgColorRef {
  _ChatBubbleBgColorProviderElement(super.provider);

  @override
  QUser get sender => (origin as ChatBubbleBgColorProvider).sender;
}

String _$bubbleTextColorHash() => r'49e3cbffc5b32318113c47c618e0968367dae9d5';

/// See also [bubbleTextColor].
@ProviderFor(bubbleTextColor)
const bubbleTextColorProvider = BubbleTextColorFamily();

/// See also [bubbleTextColor].
class BubbleTextColorFamily extends Family<Color> {
  /// See also [bubbleTextColor].
  const BubbleTextColorFamily();

  /// See also [bubbleTextColor].
  BubbleTextColorProvider call(
    String senderId,
  ) {
    return BubbleTextColorProvider(
      senderId,
    );
  }

  @override
  BubbleTextColorProvider getProviderOverride(
    covariant BubbleTextColorProvider provider,
  ) {
    return call(
      provider.senderId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bubbleTextColorProvider';
}

/// See also [bubbleTextColor].
class BubbleTextColorProvider extends AutoDisposeProvider<Color> {
  /// See also [bubbleTextColor].
  BubbleTextColorProvider(
    String senderId,
  ) : this._internal(
          (ref) => bubbleTextColor(
            ref as BubbleTextColorRef,
            senderId,
          ),
          from: bubbleTextColorProvider,
          name: r'bubbleTextColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bubbleTextColorHash,
          dependencies: BubbleTextColorFamily._dependencies,
          allTransitiveDependencies:
              BubbleTextColorFamily._allTransitiveDependencies,
          senderId: senderId,
        );

  BubbleTextColorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.senderId,
  }) : super.internal();

  final String senderId;

  @override
  Override overrideWith(
    Color Function(BubbleTextColorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BubbleTextColorProvider._internal(
        (ref) => create(ref as BubbleTextColorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        senderId: senderId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Color> createElement() {
    return _BubbleTextColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BubbleTextColorProvider && other.senderId == senderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BubbleTextColorRef on AutoDisposeProviderRef<Color> {
  /// The parameter `senderId` of this provider.
  String get senderId;
}

class _BubbleTextColorProviderElement extends AutoDisposeProviderElement<Color>
    with BubbleTextColorRef {
  _BubbleTextColorProviderElement(super.provider);

  @override
  String get senderId => (origin as BubbleTextColorProvider).senderId;
}

String _$bubbleBgColorHash() => r'7a2374a9e5a03d204ada908e923d0da37a416e24';

/// See also [bubbleBgColor].
@ProviderFor(bubbleBgColor)
const bubbleBgColorProvider = BubbleBgColorFamily();

/// See also [bubbleBgColor].
class BubbleBgColorFamily extends Family<Color> {
  /// See also [bubbleBgColor].
  const BubbleBgColorFamily();

  /// See also [bubbleBgColor].
  BubbleBgColorProvider call(
    String senderId,
  ) {
    return BubbleBgColorProvider(
      senderId,
    );
  }

  @override
  BubbleBgColorProvider getProviderOverride(
    covariant BubbleBgColorProvider provider,
  ) {
    return call(
      provider.senderId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'bubbleBgColorProvider';
}

/// See also [bubbleBgColor].
class BubbleBgColorProvider extends AutoDisposeProvider<Color> {
  /// See also [bubbleBgColor].
  BubbleBgColorProvider(
    String senderId,
  ) : this._internal(
          (ref) => bubbleBgColor(
            ref as BubbleBgColorRef,
            senderId,
          ),
          from: bubbleBgColorProvider,
          name: r'bubbleBgColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bubbleBgColorHash,
          dependencies: BubbleBgColorFamily._dependencies,
          allTransitiveDependencies:
              BubbleBgColorFamily._allTransitiveDependencies,
          senderId: senderId,
        );

  BubbleBgColorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.senderId,
  }) : super.internal();

  final String senderId;

  @override
  Override overrideWith(
    Color Function(BubbleBgColorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BubbleBgColorProvider._internal(
        (ref) => create(ref as BubbleBgColorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        senderId: senderId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Color> createElement() {
    return _BubbleBgColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BubbleBgColorProvider && other.senderId == senderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, senderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BubbleBgColorRef on AutoDisposeProviderRef<Color> {
  /// The parameter `senderId` of this provider.
  String get senderId;
}

class _BubbleBgColorProviderElement extends AutoDisposeProviderElement<Color>
    with BubbleBgColorRef {
  _BubbleBgColorProviderElement(super.provider);

  @override
  String get senderId => (origin as BubbleBgColorProvider).senderId;
}

String _$initiateChatUrlHash() => r'e1df751e531e43d6d26684a5dbabef62a2e2039f';

/// See also [initiateChatUrl].
@ProviderFor(initiateChatUrl)
final initiateChatUrlProvider = AutoDisposeProvider<Uri>.internal(
  initiateChatUrl,
  name: r'initiateChatUrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$initiateChatUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef InitiateChatUrlRef = AutoDisposeProviderRef<Uri>;
String _$initiateChatHash() => r'2965f5dd1970ff879f734496fde770e4db0dd4d1';

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
String _$lastMessageHash() => r'8bbe9fb5a12f24054d07061c82c0215b538ef524';

/// See also [lastMessage].
@ProviderFor(lastMessage)
final lastMessageProvider = AutoDisposeProvider<QMessage>.internal(
  lastMessage,
  name: r'lastMessageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$lastMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LastMessageRef = AutoDisposeProviderRef<QMessage>;
String _$messageDeletedHash() => r'f9979ff59b1f1992d692f6ccde75dcb53eada9bc';

/// See also [messageDeleted].
@ProviderFor(messageDeleted)
final messageDeletedProvider = AutoDisposeStreamProvider<QMessage>.internal(
  messageDeleted,
  name: r'messageDeletedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageDeletedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageDeletedRef = AutoDisposeStreamProviderRef<QMessage>;
String _$messageDeliveredHash() => r'e20bb706cdcc7ea8ba3ef45f63dd6e189c958819';

/// See also [messageDelivered].
@ProviderFor(messageDelivered)
final messageDeliveredProvider = AutoDisposeStreamProvider<QMessage>.internal(
  messageDelivered,
  name: r'messageDeliveredProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageDeliveredHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageDeliveredRef = AutoDisposeStreamProviderRef<QMessage>;
String _$messageReadHash() => r'8cc9214beb0856d365d2c435132dd3dfb960f873';

/// See also [messageRead].
@ProviderFor(messageRead)
final messageReadProvider = AutoDisposeStreamProvider<QMessage>.internal(
  messageRead,
  name: r'messageReadProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$messageReadHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageReadRef = AutoDisposeStreamProviderRef<QMessage>;
String _$messageReceivedHash() => r'65cc28b6febbfe6c442163559a12e8bfddfddd0e';

/// See also [messageReceived].
@ProviderFor(messageReceived)
final messageReceivedProvider = AutoDisposeStreamProvider<QMessage>.internal(
  messageReceived,
  name: r'messageReceivedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageReceivedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageReceivedRef = AutoDisposeStreamProviderRef<QMessage>;
String _$sortedMessagesHash() => r'02bff6254f66805aae89b39a0f651eceb2bca05c';

/// See also [sortedMessages].
@ProviderFor(sortedMessages)
final sortedMessagesProvider = AutoDisposeProvider<List<QMessage>>.internal(
  sortedMessages,
  name: r'sortedMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sortedMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SortedMessagesRef = AutoDisposeProviderRef<List<QMessage>>;
String _$mappedMessagesHash() => r'062af1eb3eb74428ab7a959199c2dc9ab219c737';

/// See also [mappedMessages].
@ProviderFor(mappedMessages)
final mappedMessagesProvider = AutoDisposeProvider<List<QMessage>>.internal(
  mappedMessages,
  name: r'mappedMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mappedMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MappedMessagesRef = AutoDisposeProviderRef<List<QMessage>>;
String _$roomIdQHash() => r'6bcaf66f0898fbcd63742a8ec814f434735294bf';

/// See also [_roomIdQ].
@ProviderFor(_roomIdQ)
final _roomIdQProvider = AutoDisposeProvider<int?>.internal(
  _roomIdQ,
  name: r'_roomIdQProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomIdQHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _RoomIdQRef = AutoDisposeProviderRef<int?>;
String _$chatRoomHash() => r'0c34d83756a3b1c100b2a8a6a8a4050f2d7992e8';

/// See also [_chatRoom].
@ProviderFor(_chatRoom)
final _chatRoomProvider = AutoDisposeProvider<AsyncValue<QChatRoom>>.internal(
  _chatRoom,
  name: r'_chatRoomProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatRoomHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _ChatRoomRef = AutoDisposeProviderRef<AsyncValue<QChatRoom>>;
String _$multichannelHash() => r'e5f42c26010f15194e57d5e097336d25f2e040ca';

/// See also [multichannel].
@ProviderFor(multichannel)
final multichannelProvider = AutoDisposeProvider<IQMultichannel>.internal(
  multichannel,
  name: r'multichannelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$multichannelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MultichannelRef = AutoDisposeProviderRef<IQMultichannel>;
String _$qiscusSDKHash() => r'141fbd07e94490e7ac986dad3acd699ec1ed5e2a';

/// See also [qiscusSDK].
@ProviderFor(qiscusSDK)
final qiscusSDKProvider = Provider<QiscusSDK>.internal(
  qiscusSDK,
  name: r'qiscusSDKProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$qiscusSDKHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QiscusSDKRef = ProviderRef<QiscusSDK>;
String _$qiscusHash() => r'd331ec23290a9fcc9aba159059deaa9e0c8a211a';

/// See also [qiscus].
@ProviderFor(qiscus)
final qiscusProvider = FutureProvider<QiscusSDK>.internal(
  qiscus,
  name: r'qiscusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$qiscusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef QiscusRef = FutureProviderRef<QiscusSDK>;
String _$roomIdHash() => r'8e671fc1ea2d7c9e104f1b9d4fd80daa37de57a4';

/// See also [roomId].
@ProviderFor(roomId)
final roomIdProvider = AutoDisposeFutureProvider<int>.internal(
  roomId,
  name: r'roomIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RoomIdRef = AutoDisposeFutureProviderRef<int>;
String _$roomHash() => r'5609055ef041a30faa524a1070bb00395af54168';

/// See also [room].
@ProviderFor(room)
final roomProvider =
    AutoDisposeProvider<AsyncValue<QChatRoomWithMessages>>.internal(
  room,
  name: r'roomProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RoomRef = AutoDisposeProviderRef<AsyncValue<QChatRoomWithMessages>>;
String _$sessionalHash() => r'37d7e44c30707ea4a4a98d247f33719146472086';

/// See also [sessional].
@ProviderFor(sessional)
final sessionalProvider = AutoDisposeFutureProvider<bool>.internal(
  sessional,
  name: r'sessionalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sessionalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SessionalRef = AutoDisposeFutureProviderRef<bool>;
String _$encSharedPreferenceHash() =>
    r'939afe8d6547ebac90d688b1db64b416e404d00a';

/// See also [encSharedPreference].
@ProviderFor(encSharedPreference)
final encSharedPreferenceProvider =
    AutoDisposeProvider<FlutterSecureStorage>.internal(
  encSharedPreference,
  name: r'encSharedPreferenceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$encSharedPreferenceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EncSharedPreferenceRef = AutoDisposeProviderRef<FlutterSecureStorage>;
String _$userPresenceHash() => r'c248fb34997b74dd8c8f98fdfcf04b8778ae5a03';

/// See also [userPresence].
@ProviderFor(userPresence)
final userPresenceProvider = AutoDisposeStreamProvider<QUserPresence>.internal(
  userPresence,
  name: r'userPresenceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userPresenceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserPresenceRef = AutoDisposeStreamProviderRef<QUserPresence>;
String _$userTypingHash() => r'e3b0cfef2e3a9d47fe38fa0bcb83853732916526';

/// See also [userTyping].
@ProviderFor(userTyping)
final userTypingProvider = AutoDisposeStreamProvider<QUserTyping>.internal(
  userTyping,
  name: r'userTypingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userTypingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserTypingRef = AutoDisposeStreamProviderRef<QUserTyping>;
String _$messagesNotifierHash() => r'b335eae428942bb60eb4ec1c2325c4cd7a013600';

/// See also [MessagesNotifier].
@ProviderFor(MessagesNotifier)
final messagesNotifierProvider =
    AutoDisposeNotifierProvider<MessagesNotifier, List<QMessage>>.internal(
  MessagesNotifier.new,
  name: r'messagesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messagesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessagesNotifier = AutoDisposeNotifier<List<QMessage>>;
String _$uploadNotifierHash() => r'e4e321d9cf075247d711265df4ed44c4fa33bbb9';

/// See also [UploadNotifier].
@ProviderFor(UploadNotifier)
final uploadNotifierProvider =
    AutoDisposeNotifierProvider<UploadNotifier, Set<QUpload>>.internal(
  UploadNotifier.new,
  name: r'uploadNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$uploadNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UploadNotifier = AutoDisposeNotifier<Set<QUpload>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
