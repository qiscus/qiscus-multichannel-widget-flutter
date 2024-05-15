// ignore: library_prefixes
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' as Q;

class QAccount extends Q.QAccount {
  QAccount({
    required super.id,
    required super.name,
    super.avatarUrl,
    Map<String, dynamic>? super.extras,
    super.lastEventId,
    super.lastMessageId,
    this.properties,
  });

  factory QAccount.merge(
    Q.QAccount account, [
    Map<String, Object?>? properties,
  ]) {
    return QAccount(
      id: account.id,
      name: account.name,
      avatarUrl: account.avatarUrl,
      extras: account.extras,
      lastEventId: account.lastEventId,
      lastMessageId: account.lastMessageId,
      properties: properties,
    );
  }

  Map<String, Object?>? properties;
}
