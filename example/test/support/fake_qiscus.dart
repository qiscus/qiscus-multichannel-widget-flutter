import 'dart:async';

import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

/// Fake [QiscusSDK] tanpa jaringan/MQTT untuk test realtime widget.
///
/// Event realtime disuntikkan lewat controller publik; subscribe/unsubscribe
/// topic dicatat supaya test bisa memverifikasi lifecycle subscription.
/// Method SDK lain yang tidak di-override akan melempar [NoSuchMethodError]
/// sehingga pemakaian tak terduga langsung ketahuan.
class FakeQiscus implements QiscusSDK {
  final received = StreamController<QMessage>.broadcast();
  final read = StreamController<QMessage>.broadcast();
  final delivered = StreamController<QMessage>.broadcast();
  final deleted = StreamController<QMessage>.broadcast();
  final typing = StreamController<QUserTyping>.broadcast();
  final presence = StreamController<QUserPresence>.broadcast();

  final roomSubscribes = <int>[];
  final roomUnsubscribes = <int>[];
  final presenceSubscribes = <String>[];
  final presenceUnsubscribes = <String>[];
  final sentMessages = <QMessage>[];

  /// Respons server untuk [sendMessage]; default: salin pesan dengan id baru
  /// dan status `sent`.
  QMessage Function(QMessage message)? onSend;

  int _nextId = 1000;

  @override
  Stream<QMessage> onMessageReceived() => received.stream;
  @override
  Stream<QMessage> onMessageRead() => read.stream;
  @override
  Stream<QMessage> onMessageDelivered() => delivered.stream;
  @override
  Stream<QMessage> onMessageDeleted() => deleted.stream;
  @override
  Stream<QUserTyping> onUserTyping() => typing.stream;
  @override
  Stream<QUserPresence> onUserOnlinePresence() => presence.stream;

  @override
  void subscribeChatRoom(QChatRoom room) => roomSubscribes.add(room.id);
  @override
  void unsubscribeChatRoom(QChatRoom room) => roomUnsubscribes.add(room.id);
  @override
  void subscribeUserOnlinePresence(String userId) =>
      presenceSubscribes.add(userId);
  @override
  void unsubscribeUserOnlinePresence(String userId) =>
      presenceUnsubscribes.add(userId);

  @override
  Future<QMessage> sendMessage({required QMessage message}) async {
    sentMessages.add(message);
    var respond = onSend;
    if (respond != null) return respond(message);
    return copyMessage(message, id: _nextId++, status: QMessageStatus.sent);
  }

  @override
  void synchronize({String? lastMessageId}) {}

  /// Jumlah subscription room topic yang masih aktif menurut fake ini.
  int activeRoomSubscriptions(int roomId) =>
      roomSubscribes.where((id) => id == roomId).length -
      roomUnsubscribes.where((id) => id == roomId).length;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Salinan [QMessage] (instance berbeda) — meniru objek yang dipancarkan SDK
/// dari storage internalnya, bukan instance yang dipegang widget.
QMessage copyMessage(
  QMessage m, {
  int? id,
  String? uniqueId,
  QMessageStatus? status,
}) {
  return QMessage(
    id: id ?? m.id,
    chatRoomId: m.chatRoomId,
    previousMessageId: m.previousMessageId,
    uniqueId: uniqueId ?? m.uniqueId,
    text: m.text,
    status: status ?? m.status,
    type: m.type,
    extras: m.extras,
    payload: m.payload,
    sender: m.sender,
    timestamp: m.timestamp,
  );
}

QMessage textMessage({
  required int id,
  required String uniqueId,
  required QUser sender,
  required DateTime timestamp,
  int roomId = 1,
  QMessageStatus status = QMessageStatus.sent,
  String? text,
}) {
  return QMessage(
    id: id,
    chatRoomId: roomId,
    previousMessageId: 0,
    uniqueId: uniqueId,
    text: text ?? 'message $uniqueId',
    status: status,
    type: QMessageType.text,
    extras: null,
    payload: null,
    sender: sender,
    timestamp: timestamp,
  );
}
