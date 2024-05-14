part of 'provider.dart';

@riverpod
Future<int> roomId(RoomIdRef ref) async {
  var appState = ref.watch(appStateProvider);

  var res = await appState
      .maybeWhen<AsyncValue<int>>(
        orElse: () => const AsyncValue.loading(),
        ready: (roomId, _) => AsyncValue.data(roomId),
      )
      .future;

  return res;
}
