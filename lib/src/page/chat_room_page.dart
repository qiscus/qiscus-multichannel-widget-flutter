import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:qiscus_multichannel_widget/src/models.dart';

import '../../qiscus_multichannel_widget.dart';
import '../widgets/chat_form.dart';
import '../widgets/chat_system.dart';
import '../widgets/widgets.dart';

class QChatRoomPage extends Page {
  const QChatRoomPage() : super(key: const ValueKey("RoomPage"));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const QChatRoomScreen(),
    );
  }
}

class QChatRoomScreen extends StatelessWidget {
  const QChatRoomScreen({Key? key}) : super(key: key);

  // final message = QMessageSystem.fromMessage(QMessage(
  //   chatRoomId: -1,
  //   extras: null,
  //   id: 1,
  //   payload: null,
  //   previousMessageId: 1,
  //   sender: const QUser(
  //     id: 'user-1',
  //     name: 'System',
  //     avatarUrl: 'https://via.placeholder.com/150x150',
  //   ),
  //   status: QMessageStatus.read,
  //   text: 'Ini contoh system message',
  //   timestamp: DateTime.now(),
  //   type: QMessageType.custom,
  //   uniqueId: '',
  // ));
  // late final messages = <QMessage>[
  //   message,
  //   message,
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: QMultichannelConsumer(
              builder: (context, ref) {
                var messages = ref.messages;

                return GroupedListView<QMessage, DateTime>(
                  elements: messages,
                  groupBy: (message) => message.timestamp,
                  itemBuilder: (context, message) {
                    return _buildChatBubble(context, ref, message);
                  },
                  groupSeparatorBuilder: (DateTime date) {
                    return _buildSeparator(date);
                  },
                );
              },
            ),
          ),
          QChatForm(),
        ],
      ),
    );
  }

  Widget _buildSeparator(_) {
    return Container();
  }

  Widget _buildChatBubble(
    BuildContext context,
    QMultichannel ref,
    QMessage message,
  ) {
    var accountId = ref.account.whenData((v) => v.id);

    // print('type: ${message.type} ${message.runtimeType}');

    // if (message.type == QMessageType.custom) {
    //   var type = message.payload;
    // }

    if (message is QMessageSystem) {
      return QChatSystem(message: message);
    }

    return accountId.when(
      data: (accountId) {
        if (message.sender.id == accountId) {
          return QChatBubbleRight(message: message);
        } else {
          return QChatBubbleLeft(message: message);
        }
      },
      loading: () {
        return const CircularProgressIndicator();
      },
      error: (e, _) {
        return Text(e.toString());
      },
    );
  }
}
