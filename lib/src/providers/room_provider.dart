import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/extensions.dart';
import 'messages_provider.dart';
import 'qiscus_sdk_provider.dart';
import 'room_id_provider.dart';

final roomProvider = FutureProvider((ref) async {
  var qiscus = await ref.watch(qiscusProvider.future);
  var roomId = await ref.watch(roomIdProvider).future;
  var room = await qiscus.getChatRoomWithMessages(roomId: roomId);

  for (var m in room.messages) {
    ref.read(messagesProvider.notifier).receive(m);
  }

  return room;
});
