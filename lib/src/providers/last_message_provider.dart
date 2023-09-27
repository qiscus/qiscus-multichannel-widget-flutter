part of 'provider.dart';

final lastMessageProvider = Provider.autoDispose((ref) {
  var messages = ref.watch(sortedMessagesProvider);
  return messages.first;
});
