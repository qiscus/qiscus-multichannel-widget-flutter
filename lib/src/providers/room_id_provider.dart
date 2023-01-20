import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'states_provider.dart';

final roomIdProvider = Provider<AsyncValue<int>>((ref) {
  var appState = ref.watch(appStateProvider);

  return appState.maybeWhen(
    orElse: () => const AsyncValue.loading(),
    ready: (roomId, _) => AsyncValue.data(roomId),
  );
}, name: 'roomIdProvider');
