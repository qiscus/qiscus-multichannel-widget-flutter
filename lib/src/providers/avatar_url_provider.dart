part of 'provider.dart';

@riverpod
String? avatarUrl(AvatarUrlRef ref) {
  var account = ref.watch(accountProvider);
  var avatarConfig = ref.watch(avatarConfigProvider);

  return avatarConfig.when(
    disabled: () => null,
    editable: (avatar) => avatar,
    enabled: () => account.valueOrNull?.avatarUrl,
  );
}
