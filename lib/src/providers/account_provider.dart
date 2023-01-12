import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../account.dart';
import 'states_provider.dart';

final accountProvider = Provider<AsyncValue<QAccount>>((ref) {
  var state = ref.watch(appStateProvider);
  return state.maybeWhen(
    orElse: () => const AsyncValue.loading(),
    ready: (_, account) => AsyncValue.data(account),
  );
});

final accountIdProvider = Provider((ref) {
  return ref.watch(accountProvider.select((v) => v.value?.id));
});
