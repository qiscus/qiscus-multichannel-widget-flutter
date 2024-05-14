part of 'provider.dart';

@riverpod
Stream<QMessage> messageReceived(MessageReceivedRef ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var room = await ref
      .watch(roomProvider.select((data) => data.whenData((v) => v.room)))
      .future;

  qiscus.subscribeChatRoom(room);
  ref.onDispose(() {
    qiscus.unsubscribeChatRoom(room);
  });

  yield* qiscus.onMessageReceived();
}
