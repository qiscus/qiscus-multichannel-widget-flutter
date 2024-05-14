part of 'provider.dart';

@riverpod
QMessage lastMessage(LastMessageRef ref) {
  var messages = ref.watch(sortedMessagesProvider);
  return messages.first;
}
