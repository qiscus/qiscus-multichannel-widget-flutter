part of 'provider.dart';

/// Subscription topic realtime room aktif (read/delivered/typing) yang dipakai
/// bersama oleh semua stream provider room.
///
/// `subscribeChatRoom`/`unsubscribeChatRoom` di SDK tidak menghitung
/// referensi: kalau setiap stream provider subscribe/unsubscribe sendiri,
/// provider pertama yang dispose (mis. indikator typing di header) mematikan
/// topic untuk consumer lain yang masih aktif (receipt, pesan masuk). Dengan
/// satu provider autoDispose yang di-watch semua consumer, Riverpod yang
/// menghitung referensinya: topic baru dilepas setelah consumer terakhir
/// berhenti, atau saat room aktif berganti.
final roomTopicSubscriptionProvider = FutureProvider.autoDispose<QChatRoom>(
  (ref) async {
    // Watch semua dependency secara sinkron sebelum await pertama: dependency
    // yang baru di-watch setelah await sempat dilepas Riverpod saat rebuild,
    // memicu invalidasi tambahan dan subscribe ganda.
    var qiscusFuture = ref.watch(qiscusProvider.future);
    var roomValue =
        ref.watch(roomProvider.select((data) => data.whenData((v) => v.room)));

    var disposed = false;
    ref.onDispose(() => disposed = true);

    var qiscus = await qiscusFuture;
    var room = await roomValue.future;
    // Build ini sudah digantikan (mis. room berganti saat menunggu).
    if (disposed) return room;

    qiscus.subscribeChatRoom(room);
    ref.onDispose(() {
      qiscus.unsubscribeChatRoom(room);
    });

    return room;
  },
  name: 'roomTopicSubscriptionProvider',
);

/// ID participant room aktif selain diri sendiri — target presence.
///
/// Akun SDK ([accountIdProvider]) dan `userId` aplikasi ([userIdProvider])
/// sama-sama dikecualikan (pada mode secure keduanya bisa berbeda), sehingga
/// customer tidak pernah dianggap sebagai lawan bicara. Kosong selama akun
/// belum siap.
final counterpartIdsProvider = Provider.autoDispose<List<String>>(
  (ref) {
    // Select ke String (bukan List) supaya initiateChat() ulang dengan
    // participant yang sama tidak memicu resubscribe presence.
    var participantIds = ref.watch(roomProvider.select(
        (v) => v.valueOrNull?.room.participants.map((p) => p.id).join('\n')));
    var accountId = ref.watch(accountIdProvider);
    var userId = ref.watch(userIdProvider);

    if (participantIds == null || participantIds.isEmpty || accountId == null) {
      return const [];
    }

    var ids = participantIds
        .split('\n')
        .where((id) => id.isNotEmpty && id != accountId && id != userId)
        .toSet()
        .toList()
      ..sort();
    return List.unmodifiable(ids);
  },
  name: 'counterpartIdsProvider',
);

/// Presence terakhir per counterpart; hanya berisi user yang event
/// presence-nya sudah diterima (belum ada event = belum diketahui).
class CounterpartPresenceNotifier
    extends AutoDisposeNotifier<Map<String, QUserPresence>> {
  @override
  Map<String, QUserPresence> build() {
    var ids = ref.watch(counterpartIdsProvider);
    var qiscus = ref.watch(qiscusProvider).valueOrNull;
    if (ids.isEmpty || qiscus == null) return const {};

    var targets = ids.toSet();
    // Listen sebelum subscribe supaya event pertama (retained) tidak lewat.
    var sub = qiscus
        .onUserOnlinePresence()
        .where((p) => targets.contains(p.userId))
        .listen((p) {
      state = {...state, p.userId: p};
    });
    for (var id in ids) {
      qiscus.subscribeUserOnlinePresence(id);
    }

    ref.onDispose(() {
      sub.cancel();
      for (var id in ids) {
        qiscus.unsubscribeUserOnlinePresence(id);
      }
    });

    return const {};
  }
}

final counterpartPresenceProvider = NotifierProvider.autoDispose<
    CounterpartPresenceNotifier, Map<String, QUserPresence>>(
  CounterpartPresenceNotifier.new,
  name: 'counterpartPresenceProvider',
);

enum QPresenceStatus { unknown, online, offline }

/// Status gabungan counterpart untuk header: `online` bila ada counterpart
/// yang online, `offline` hanya bila setiap counterpart sudah melaporkan
/// offline, selain itu `unknown` (counterpart tanpa event bisa saja online).
final counterpartPresenceStatusProvider = Provider.autoDispose<QPresenceStatus>(
  (ref) {
    var ids = ref.watch(counterpartIdsProvider);
    var presences = ref.watch(counterpartPresenceProvider);
    if (presences.values.any((p) => p.isOnline)) {
      return QPresenceStatus.online;
    }
    if (ids.isNotEmpty && ids.every(presences.containsKey)) {
      return QPresenceStatus.offline;
    }
    return QPresenceStatus.unknown;
  },
  name: 'counterpartPresenceStatusProvider',
);

/// Batas umur status typing tanpa event lanjutan, supaya indikator tidak
/// tertinggal (stale) bila event `isTyping=false` tidak pernah sampai.
const typingIndicatorTimeout = Duration(seconds: 10);

/// ID user lain yang sedang mengetik di room aktif.
///
/// Event dari room lain atau dari diri sendiri diabaikan; `isTyping=false`,
/// [typingIndicatorTimeout], maupun pergantian room menghapus status.
class CounterpartTypingNotifier extends AutoDisposeNotifier<Set<String>> {
  final _expiry = <String, Timer>{};

  @override
  Set<String> build() {
    var roomId = ref.watch(roomProvider.select((v) => v.valueOrNull?.room.id));
    var accountId = ref.watch(accountIdProvider);
    var userId = ref.watch(userIdProvider);
    ref.onDispose(_cancelTimers);

    if (roomId == null || accountId == null) return const {};

    ref.listen<AsyncValue<QUserTyping>>(userTypingProvider, (_, next) {
      // Lewati AsyncLoading (yang masih membawa event lama saat reload).
      if (next is! AsyncData<QUserTyping>) return;
      var event = next.value;
      if (event.roomId != roomId) return;
      if (event.userId == accountId || event.userId == userId) return;

      if (event.isTyping) {
        _start(event.userId);
      } else {
        _stop(event.userId);
      }
    });

    return const {};
  }

  void _start(String userId) {
    _expiry.remove(userId)?.cancel();
    _expiry[userId] = Timer(typingIndicatorTimeout, () => _stop(userId));
    if (!state.contains(userId)) state = {...state, userId};
  }

  void _stop(String userId) {
    _expiry.remove(userId)?.cancel();
    if (state.contains(userId)) {
      state = {...state}..remove(userId);
    }
  }

  void _cancelTimers() {
    for (var timer in _expiry.values) {
      timer.cancel();
    }
    _expiry.clear();
  }
}

final counterpartTypingProvider =
    NotifierProvider.autoDispose<CounterpartTypingNotifier, Set<String>>(
  CounterpartTypingNotifier.new,
  name: 'counterpartTypingProvider',
);
