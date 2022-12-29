import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' as Q;

class QAccount extends Q.QAccount {
  QAccount({
    required String id,
    required String name,
    String? avatarUrl,
    Map<String, dynamic>? extras,
    int? lastEventId,
    int? lastMessageId,
    this.properties,
  }) : super(
          id: id,
          name: name,
          avatarUrl: avatarUrl,
          extras: extras,
          lastEventId: lastEventId,
          lastMessageId: lastMessageId,
        );

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
