import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/extensions.dart';
import 'qiscus_sdk_provider.dart';
import 'room_provider.dart';

final userTypingProvider = StreamProvider.autoDispose((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var room = await ref
      .watch(roomProvider.select((data) => data.whenData((v) => v.room)))
      .future;

  qiscus.subscribeChatRoom(room);
  ref.onDispose(() {
    qiscus.unsubscribeChatRoom(room);
  });

  yield* qiscus.onUserTyping();
});
