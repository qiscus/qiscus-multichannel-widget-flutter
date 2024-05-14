part of 'provider.dart';

@riverpod
AsyncValue<QAccount> account(AccountRef ref) {
  var state = ref.watch(appStateProvider);
  return state.maybeWhen(
    orElse: () => const AsyncValue.loading(),
    ready: (_, account) => AsyncValue.data(account),
  );
}

@riverpod
String? accountId(AccountIdRef ref) {
  return ref.watch(accountProvider.select((v) => v.value?.id));
}
