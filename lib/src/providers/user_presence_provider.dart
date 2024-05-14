part of 'provider.dart';

@riverpod
Stream<QUserPresence> userPresence(UserPresenceRef ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var userId = ref.watch(userIdProvider);

  if (userId != null) {
    qiscus.subscribeUserOnlinePresence(userId);
  }
  ref.onDispose(() {
    if (userId != null) {
      qiscus.unsubscribeUserOnlinePresence(userId);
    }
  });
  yield* qiscus.onUserOnlinePresence();
}
