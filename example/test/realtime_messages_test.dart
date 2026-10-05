import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
// ignore: implementation_imports
import 'package:qiscus_multichannel_widget/src/states/app_state.dart';

import 'support/fake_qiscus.dart';

const customerId = 'customer@example.com';
const agentId = 'agent@example.com';
const customer = QUser(id: customerId, name: 'Customer');
const agent = QUser(id: agentId, name: 'Agent');

final t0 = DateTime(2026, 10, 2, 9);

QChatRoom room(int id) => QChatRoom(
      id: id,
      uniqueId: 'room-$id',
      participants: const [
        QParticipant(id: customerId, name: 'Customer'),
        QParticipant(id: agentId, name: 'Agent'),
      ],
    );

ProviderContainer createContainer(FakeQiscus fake, List<QMessage> messages) {
  final container = ProviderContainer(
    overrides: [qiscusProvider.overrideWith((ref) async => fake)],
  );
  addTearDown(container.dispose);
  container.read(appStateProvider.notifier).state = AppState.ready(
    roomId: 1,
    account: QAccount(id: customerId, name: 'Customer'),
  );
  container.read(roomStateProvider.notifier).state =
      QChatRoomWithMessages(room(1), messages);
  return container;
}

/// Biarkan async* provider (await qiscus/room) dan listener stream jalan.
Future<void> settle() async {
  for (var i = 0; i < 10; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

QMessageStatus statusOf(ProviderContainer c, String uniqueId) => c
    .read(messagesNotifierProvider)
    .firstWhere((m) => m.uniqueId == uniqueId)
    .status;

void main() {
  group('message receipts', () {
    late FakeQiscus fake;
    late ProviderContainer container;
    late QMessage m1, m2, a1;

    setUp(() async {
      fake = FakeQiscus();
      m1 = textMessage(
          id: 10, uniqueId: 'u-10', sender: customer, timestamp: t0);
      m2 = textMessage(
          id: 11,
          uniqueId: 'u-11',
          sender: customer,
          timestamp: t0.add(const Duration(minutes: 1)));
      a1 = textMessage(
          id: 12,
          uniqueId: 'u-12',
          sender: agent,
          timestamp: t0.add(const Duration(minutes: 2)));
      container = createContainer(fake, [m1, m2, a1]);
      container.listen(messagesNotifierProvider, (_, __) {});
      await settle();
    });

    test('delivered/read events update matching outgoing messages only',
        () async {
      // Receipt untuk pesan agent (mis. markAsDelivered milik customer
      // sendiri) bukan bukti pesan outgoing sudah diterima agent.
      fake.delivered.add(copyMessage(a1, status: QMessageStatus.delivered));
      await settle();
      expect(statusOf(container, 'u-10'), QMessageStatus.sent);
      expect(statusOf(container, 'u-11'), QMessageStatus.sent);

      // Cocok via id + uniqueId (instance berbeda, seperti dari storage SDK).
      // Hanya pesan yang cocok yang berubah, sama seperti handler SDK.
      fake.delivered.add(copyMessage(m2, status: QMessageStatus.delivered));
      await settle();
      expect(statusOf(container, 'u-11'), QMessageStatus.delivered);
      expect(statusOf(container, 'u-10'), QMessageStatus.sent,
          reason: 'receipt m2 tidak boleh mengubah m1');

      // Cocok via id saja.
      fake.read.add(copyMessage(m1,
          uniqueId: 'server-side-unique-id', status: QMessageStatus.read));
      await settle();
      expect(statusOf(container, 'u-10'), QMessageStatus.read);
      expect(statusOf(container, 'u-11'), QMessageStatus.delivered,
          reason: 'read untuk m1 tidak mengubah m2');

      // Cocok via uniqueId saja.
      fake.read.add(copyMessage(m2, id: 0, status: QMessageStatus.read));
      await settle();
      expect(statusOf(container, 'u-11'), QMessageStatus.read);
      expect(statusOf(container, 'u-10'), QMessageStatus.read);

      // Delivered yang datang terlambat tidak menurunkan status read.
      fake.delivered.add(copyMessage(m2, status: QMessageStatus.delivered));
      await settle();
      expect(statusOf(container, 'u-11'), QMessageStatus.read);

      // Receipt untuk pesan yang tidak dikenal diabaikan.
      fake.read.add(textMessage(
          id: 999, uniqueId: 'unknown', sender: customer, timestamp: t0));
      await settle();
      expect(container.read(messagesNotifierProvider), hasLength(3));
    });

    test('same-room snapshot refresh does not downgrade receipt status',
        () async {
      fake.read.add(copyMessage(m1, status: QMessageStatus.read));
      fake.delivered.add(copyMessage(m2, status: QMessageStatus.delivered));
      await settle();
      expect(statusOf(container, 'u-10'), QMessageStatus.read);
      expect(statusOf(container, 'u-11'), QMessageStatus.delivered);

      // initiateChat() ulang: snapshot server (lebih lama) masih `sent` dan
      // membawa pesan baru. QMessage equality tidak memuat status, jadi
      // snapshot hanya terpropagasi bila isinya berbeda (pesan baru).
      final a2 = textMessage(
          id: 13,
          uniqueId: 'u-13',
          sender: agent,
          timestamp: t0.add(const Duration(minutes: 3)));
      container.read(roomStateProvider.notifier).state = QChatRoomWithMessages(
        room(1),
        [
          copyMessage(m1, status: QMessageStatus.sent),
          copyMessage(m2, status: QMessageStatus.sent),
          copyMessage(a1),
          a2,
        ],
      );
      await container.pump();
      await settle();
      expect(container.read(messagesNotifierProvider), hasLength(4),
          reason: 'snapshot ter-merge');
      expect(statusOf(container, 'u-10'), QMessageStatus.read);
      expect(statusOf(container, 'u-11'), QMessageStatus.delivered);

      // Snapshot yang lebih maju tetap dipakai.
      final a3 = textMessage(
          id: 14,
          uniqueId: 'u-14',
          sender: agent,
          timestamp: t0.add(const Duration(minutes: 4)));
      container.read(roomStateProvider.notifier).state = QChatRoomWithMessages(
        room(1),
        [
          copyMessage(m1, status: QMessageStatus.sent),
          copyMessage(m2, status: QMessageStatus.read),
          copyMessage(a1),
          copyMessage(a2),
          a3,
        ],
      );
      await container.pump();
      await settle();
      expect(container.read(messagesNotifierProvider), hasLength(5),
          reason: 'snapshot ter-merge');
      expect(statusOf(container, 'u-10'), QMessageStatus.read);
      expect(statusOf(container, 'u-11'), QMessageStatus.read);
    });

    test('own message echo keeps its real status instead of forcing read',
        () async {
      fake.received.add(copyMessage(m1, status: QMessageStatus.sent));
      await settle();
      expect(statusOf(container, 'u-10'), QMessageStatus.sent);

      fake.delivered.add(copyMessage(m1, status: QMessageStatus.delivered));
      await settle();
      expect(statusOf(container, 'u-10'), QMessageStatus.delivered);

      // Echo/sync dengan status lebih rendah tidak menurunkan status.
      fake.received.add(copyMessage(m1, status: QMessageStatus.sent));
      await settle();
      expect(statusOf(container, 'u-10'), QMessageStatus.delivered);
    });

    test('sendMessage stays sent until a matching receipt arrives', () async {
      final draft = textMessage(
        id: 0,
        uniqueId: 'local-1',
        sender: customer,
        timestamp: t0.add(const Duration(minutes: 3)),
        status: QMessageStatus.sending,
      );
      await container
          .read(messagesNotifierProvider.notifier)
          .sendMessage(draft);
      await settle();

      expect(fake.sentMessages, hasLength(1));
      expect(statusOf(container, 'local-1'), QMessageStatus.sent);
      expect(statusOf(container, 'u-10'), QMessageStatus.sent,
          reason: 'mengirim pesan bukan bukti pesan lama sudah dibaca');

      final sentId = container.read(messagesNotifierProvider).last.id;
      fake.read
          .add(copyMessage(draft, id: sentId, status: QMessageStatus.read));
      await settle();
      expect(statusOf(container, 'local-1'), QMessageStatus.read);
    });
  });

  group('room topic subscription lifecycle', () {
    test('one consumer disposing does not unsubscribe topics others still use',
        () async {
      final fake = FakeQiscus();
      final container = createContainer(fake, const []);

      final received = container.listen(messageReceivedProvider, (_, __) {});
      final typing = container.listen(userTypingProvider, (_, __) {});
      final read = container.listen(messageReadProvider, (_, __) {});
      await settle();

      expect(fake.roomSubscribes, [1]);
      expect(fake.activeRoomSubscriptions(1), 1);

      typing.close();
      await container.pump();
      await settle();
      expect(fake.roomUnsubscribes, isEmpty,
          reason: 'receipt/received masih aktif');

      // Pindah room: topic room lama dilepas, room baru disubscribe sekali.
      container.read(roomStateProvider.notifier).state =
          QChatRoomWithMessages(room(2), const []);
      await container.pump();
      await settle();
      expect(fake.roomSubscribes, [1, 2]);
      expect(fake.roomUnsubscribes, [1]);
      expect(fake.activeRoomSubscriptions(1), 0);
      expect(fake.activeRoomSubscriptions(2), 1);

      received.close();
      read.close();
      await container.pump();
      await settle();
      expect(fake.roomUnsubscribes, [1, 2]);
      expect(fake.activeRoomSubscriptions(2), 0);
    });
  });
}
