import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'account_provider.dart';
import 'states_provider.dart';

final avatarUrlProvider = Provider<String?>((ref) {
  var account = ref.watch(accountProvider);
  var avatarConfig = ref.watch(avatarConfigProvider);

  return avatarConfig.when(
    disabled: () => null,
    editable: (avatar) => avatar,
    enabled: () => account.valueOrNull?.avatarUrl,
  );
});
