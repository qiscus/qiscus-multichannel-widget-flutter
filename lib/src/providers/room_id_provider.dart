import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'states_provider.dart';
import '../utils/extensions.dart';

final roomIdProvider = FutureProvider<int>((ref) async {
  var appState = ref.watch(appStateProvider);

  var res = await appState
      .maybeWhen<AsyncValue<int>>(
        orElse: () => const AsyncValue.loading(),
        ready: (roomId, _) => AsyncValue.data(roomId),
      )
      .future;

  return res;
}, name: 'roomIdProvider');
