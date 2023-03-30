import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../models.dart';
import '../utils/extensions.dart';
import '../widgets/chat_buttons.dart';
import '../widgets/chat_carousel.dart';
import 'message_delivered_provider.dart';
import 'message_read_provider.dart';
import 'message_received_provider.dart';
import 'qiscus_sdk_provider.dart';
import 'room_id_provider.dart';
import 'room_provider.dart';

final messagesProvider =
    StateNotifierProvider.autoDispose<MessagesStateNotifier, List<QMessage>>(
        (ref) {
  var roomData = ref.watch(roomProvider);
  var deliveredStream = ref.watch(messageDeliveredProvider.stream);
  var readStream = ref.watch(messageReadProvider.stream);
  var receivedStream = ref.watch(messageReceivedProvider.stream);

  return roomData.maybeWhen(
    orElse: () => MessagesStateNotifier(ref,
        deliveredStream: deliveredStream,
        readStream: readStream,
        receivedStream: receivedStream),
    data: (v) => MessagesStateNotifier(ref,
        state: v.messages,
        deliveredStream: deliveredStream,
        readStream: readStream,
        receivedStream: receivedStream),
  );
});

class MessagesStateNotifier extends StateNotifier<List<QMessage>> {
  final AutoDisposeStateNotifierProviderRef ref;
  final Stream<QMessage> readStream;
  final Stream<QMessage> deliveredStream;
  final Stream<QMessage> receivedStream;

  late final StreamSubscription? readSubs;
  late final StreamSubscription? deliveredSubs;
  late final StreamSubscription? receivedSubs;

  MessagesStateNotifier(
    this.ref, {
    required this.readStream,
    required this.deliveredStream,
    required this.receivedStream,
    List<QMessage> state = const [],
  }) : super(state) {
    readSubs = readStream.listen(_onMessageRead);
    deliveredSubs = deliveredStream.listen(_onMessageDelivered);
    receivedSubs = receivedStream.listen(_onMessageReceived);
  }

  @override
  void dispose() {
    readSubs?.cancel();
    deliveredSubs?.cancel();
    receivedSubs?.cancel();

    super.dispose();
  }

  void _onMessageRead(QMessage message) {
    state = state.map((m) {
      if (m.timestamp.isBefore(message.timestamp)) {
        m.status = QMessageStatus.read;
      }

      return m;
    }).toList();
  }

  void _onMessageDelivered(QMessage message) {
    state = state.map((m) {
      if (m.status != QMessageStatus.read &&
          m.timestamp.isBefore(message.timestamp)) {
        m.status = QMessageStatus.delivered;
      }
      return m;
    }).toList();
  }

  void Function(QMessage) get receive => _onMessageReceived;

  void _onMessageReceived(QMessage message) {
    message.status = QMessageStatus.read;
    var idx = state.indexWhere((v) => v.uniqueId == message.uniqueId);

    if (idx == -1) {
      state = [...state, message];
    } else {
      state = state.updateAt(
        index: idx,
        value: message,
      );
    }
  }

  Future<QMessage> sendMessage(QMessage message) async {
    var qiscus = await ref.read(qiscusProvider.future);
    message.status = QMessageStatus.sending;
    _onMessageReceived(message);

    Future.microtask(() async {
      var m = await qiscus.sendMessage(message: message);
      message.id = m.id;
      message.status = QMessageStatus.read;

      _onMessageReceived(message);
      _onMessageRead(message);
    });

    return message;
  }

  Future<QMessage> deleteMessage(String messageUniqueId) async {
    var qiscus = await ref.read(qiscusProvider.future);
    var messages = state.firstWhere((v) => v.uniqueId == messageUniqueId);

    await qiscus.deleteMessages(messageUniqueIds: [messageUniqueId]);
    state = state.where((v) => v.uniqueId != messageUniqueId).toList();

    return messages;
  }

  Future<List<QMessage>> loadMoreMessage([int lastMessageId = 0]) async {
    var qiscus = await ref.read(qiscusProvider.future);
    var roomId = await ref.watch(roomIdProvider).future;
    // var lastMessage = ref.watch(lastMessageProvider);
    // lastMessageId ??= lastMessage.id;

    var messages = await qiscus.getPreviousMessagesById(
      roomId: roomId,
      messageId: lastMessageId,
    );

    state = [
      ...messages,
      ...state,
    ];

    return messages;
  }

  void clear() {
    state = const [];
  }
}

final sortedMessagesProvider = Provider.autoDispose((ref) {
  var roomId = ref.watch(roomIdProvider).value;
  var messages = ref.watch(messagesProvider).where((m) {
    return m.chatRoomId == roomId;
  }).toList()
    ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  return messages;
});

final mappedMessagesProvider = Provider.autoDispose<List<QMessage>>((ref) {
  var messages = ref.watch(messagesProvider);

  return messages.map((it) {
    QMessage? message;

    message ??= QMessageSystem.tryParse(it);
    message ??= QMessageImage.tryParse(it);
    message ??= QMessageVideo.tryParse(it);
    message ??= QMessageFile.tryParse(it);
    // Not yet mature
    message ??= QMessageButton.tryParse(it);
    message ??= QMessageCarousel.tryParse(it);
    message ??= QMessageReply.tryParse(it);
    message ??= it;

    return message;
  }).toList();
});
