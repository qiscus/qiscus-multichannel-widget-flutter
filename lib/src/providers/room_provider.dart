import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

final roomStateProvider = StateProvider<QChatRoomWithMessages?>((_) => null);
final roomProvider = Provider<AsyncValue<QChatRoomWithMessages>>((ref) {
  var roomData = ref.watch(roomStateProvider);

  if (roomData == null) return const AsyncValue.loading();
  return AsyncValue.data(roomData);
});
