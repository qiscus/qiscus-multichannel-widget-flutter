part of 'provider.dart';

@riverpod
Stream<QUserTyping> userTyping(UserTypingRef ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  // Topic room di-subscribe bersama (lihat roomTopicSubscriptionProvider);
  // jangan unsubscribe per-provider di sini.
  await ref.watch(roomTopicSubscriptionProvider.future);

  yield* qiscus.onUserTyping();
}
