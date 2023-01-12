import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'qiscus_sdk_provider.dart';
import 'states_provider.dart';

final userPresenceProvider = StreamProvider.autoDispose((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var userId = ref.watch(userIdProvider);

  if (userId != null) {
    qiscus.subscribeUserOnlinePresence(userId);
  }
  ref.onDispose(() {
    if (userId != null) {
      qiscus.unsubscribeUserOnlinePresence(userId);
    }
  });
  yield* qiscus.onUserOnlinePresence();
});
