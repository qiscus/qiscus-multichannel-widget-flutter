import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'messages_provider.dart';

final lastMessageProvider = Provider.autoDispose((ref) {
  var messages = ref.watch(sortedMessagesProvider);
  return messages.first;
});
