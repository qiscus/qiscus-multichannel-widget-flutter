part of 'provider.dart';

final roomStateProvider = StateProvider<QChatRoomWithMessages?>((_) => null);

@riverpod
AsyncValue<QChatRoomWithMessages> room(RoomRef ref) {
  var roomData = ref.watch(roomStateProvider);

  if (roomData == null) return const AsyncValue.loading();
  return AsyncValue.data(roomData);
}
