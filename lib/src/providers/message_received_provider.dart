import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'qiscus_sdk_provider.dart';
import 'room_provider.dart';

final messageReceivedProvider = StreamProvider.autoDispose((ref) async* {
  var qiscus = await ref.watch(qiscusProvider.future);
  var room = await ref.watch(roomProvider.selectAsync((data) => data.room));

  qiscus.subscribeChatRoom(room);
  ref.onDispose(() {
    qiscus.unsubscribeChatRoom(room);
  });

  yield* qiscus.onMessageReceived();
}, name: 'messageReceivedProvider');
