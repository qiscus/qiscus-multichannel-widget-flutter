import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
// ignore: implementation_imports
import 'package:qiscus_multichannel_widget/src/states/app_state.dart';

import 'support/fake_qiscus.dart';

// Mode secure: id akun SDK berbeda dari userId yang di-set aplikasi.
const accountId = 'app_customer@example.com';
const appUserId = 'customer@example.com';
const agentId = 'agent@example.com';
const me = QUser(id: accountId, name: 'Customer');

final t0 = DateTime(2026, 10, 2, 9);

const supervisorId = 'supervisor@example.com';

QChatRoom room(
  int id, {
  List<QParticipant> participants = const [
    QParticipant(id: accountId, name: 'Customer'),
    QParticipant(id: agentId, name: 'Agent'),
  ],
}) =>
    QChatRoom(id: id, uniqueId: 'room-$id', participants: participants);

Future<ProviderContainer> pumpChatRoom(
  WidgetTester tester,
  FakeQiscus fake, {
  List<QMessage> messages = const [],
  QChatRoom? chatRoom,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        qiscusProvider.overrideWith((ref) async => fake),
        appStateProvider.overrideWith(
          (ref) => AppState.ready(
            roomId: 1,
            account: QAccount(id: accountId, name: 'Customer'),
          ),
        ),
        userIdProvider.overrideWith((ref) => appUserId),
        roomStateProvider.overrideWith(
          (ref) => QChatRoomWithMessages(chatRoom ?? room(1), messages),
        ),
      ],
      child: const MaterialApp(home: QChatRoomScreen()),
    ),
  );
  await tester.pump();
  await tester.pump();
  return ProviderScope.containerOf(
    tester.element(find.byType(QChatRoomScreen)),
  );
}

Future<void> disposeChatRoom(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pump();
}

/// Event fake SDK dikirim asinkron (broadcast stream/microtask); frame baru
/// dijadwalkan setelah state berubah, jadi pump dua kali: kirim event lalu
/// gambar frame hasilnya.
Future<void> deliver(WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
}

void main() {
  testWidgets('outgoing bubble meta redraws with live delivered/read receipts',
      (tester) async {
    final fake = FakeQiscus();
    final m1 = textMessage(id: 10, uniqueId: 'u-10', sender: me, timestamp: t0);
    await pumpChatRoom(tester, fake, messages: [m1]);

    expect(find.byIcon(Icons.done), findsOneWidget);
    expect(find.byIcon(Icons.done_all), findsNothing);

    fake.delivered.add(copyMessage(m1, status: QMessageStatus.delivered));
    await deliver(tester);
    expect(find.byIcon(Icons.done), findsNothing);
    expect(tester.widget<Icon>(find.byIcon(Icons.done_all)).color, Colors.grey);

    fake.read.add(copyMessage(m1, status: QMessageStatus.read));
    await deliver(tester);
    expect(
      tester.widget<Icon>(find.byIcon(Icons.done_all)).color,
      const QAppTheme().rightBubbleColor,
    );

    await disposeChatRoom(tester);
  });

  testWidgets('header shows typing only for other users in the active room',
      (tester) async {
    final fake = FakeQiscus();
    final container = await pumpChatRoom(tester, fake);
    const typingLabel = 'Typing...';

    // Room lain dan diri sendiri diabaikan.
    fake.typing
        .add(const QUserTyping(userId: agentId, roomId: 2, isTyping: true));
    fake.typing
        .add(const QUserTyping(userId: accountId, roomId: 1, isTyping: true));
    fake.typing
        .add(const QUserTyping(userId: appUserId, roomId: 1, isTyping: true));
    await deliver(tester);
    expect(find.text(typingLabel), findsNothing);

    fake.typing
        .add(const QUserTyping(userId: agentId, roomId: 1, isTyping: true));
    await deliver(tester);
    expect(find.text(typingLabel), findsOneWidget);

    fake.typing
        .add(const QUserTyping(userId: agentId, roomId: 1, isTyping: false));
    await deliver(tester);
    expect(find.text(typingLabel), findsNothing);

    // Event isTyping=false yang hilang tidak membuat indikator stale.
    fake.typing
        .add(const QUserTyping(userId: agentId, roomId: 1, isTyping: true));
    await deliver(tester);
    expect(find.text(typingLabel), findsOneWidget);
    await tester.pump(const Duration(seconds: 11));
    expect(find.text(typingLabel), findsNothing);

    // Pindah room menghapus status typing room sebelumnya.
    fake.typing
        .add(const QUserTyping(userId: agentId, roomId: 1, isTyping: true));
    await deliver(tester);
    expect(find.text(typingLabel), findsOneWidget);
    container.read(roomStateProvider.notifier).state =
        QChatRoomWithMessages(room(2), const []);
    await deliver(tester);
    expect(find.text(typingLabel), findsNothing);

    await disposeChatRoom(tester);
  });

  testWidgets(
      'header presence targets counterpart participants, unknown until event',
      (tester) async {
    final fake = FakeQiscus();
    await pumpChatRoom(tester, fake);

    expect(fake.presenceSubscribes, [agentId]);
    expect(find.text('Online'), findsNothing);
    expect(find.text('Offline'), findsNothing);

    // Presence milik customer sendiri tidak pernah dilabeli sebagai agent.
    fake.presence.add(QUserPresence(
        userId: appUserId, isOnline: true, lastSeen: DateTime(2026)));
    fake.presence.add(QUserPresence(
        userId: accountId, isOnline: true, lastSeen: DateTime(2026)));
    await deliver(tester);
    expect(find.text('Online'), findsNothing);

    fake.presence.add(QUserPresence(
        userId: agentId, isOnline: true, lastSeen: DateTime(2026)));
    await deliver(tester);
    expect(find.text('Online'), findsOneWidget);

    fake.presence.add(QUserPresence(
        userId: agentId, isOnline: false, lastSeen: DateTime(2026)));
    await deliver(tester);
    expect(find.text('Online'), findsNothing);
    expect(find.text('Offline'), findsOneWidget);

    await disposeChatRoom(tester);
    expect(fake.presenceUnsubscribes, [agentId]);
    expect(fake.activeRoomSubscriptions(1), 0);
  });

  testWidgets(
      'multi-counterpart presence stays unknown until every peer is offline',
      (tester) async {
    final fake = FakeQiscus();
    await pumpChatRoom(
      tester,
      fake,
      chatRoom: room(1, participants: const [
        QParticipant(id: accountId, name: 'Customer'),
        QParticipant(id: agentId, name: 'Agent'),
        QParticipant(id: supervisorId, name: 'Supervisor'),
      ]),
    );

    expect(fake.presenceSubscribes, unorderedEquals([agentId, supervisorId]));

    // offline + unknown => unknown: supervisor bisa saja masih online.
    fake.presence.add(QUserPresence(
        userId: agentId, isOnline: false, lastSeen: DateTime(2026)));
    await deliver(tester);
    expect(find.text('Offline'), findsNothing);
    expect(find.text('Online'), findsNothing);

    // Semua counterpart offline => offline.
    fake.presence.add(QUserPresence(
        userId: supervisorId, isOnline: false, lastSeen: DateTime(2026)));
    await deliver(tester);
    expect(find.text('Offline'), findsOneWidget);
    expect(find.text('Online'), findsNothing);

    // Satu peer online cukup untuk online.
    fake.presence.add(QUserPresence(
        userId: supervisorId, isOnline: true, lastSeen: DateTime(2026)));
    await deliver(tester);
    expect(find.text('Online'), findsOneWidget);
    expect(find.text('Offline'), findsNothing);

    await disposeChatRoom(tester);
    expect(fake.presenceUnsubscribes, unorderedEquals([agentId, supervisorId]));
  });
}
