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

class QChatRoomScreen extends ConsumerWidget {
  const QChatRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: buildAppBar(context: context, ref: ref),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: QMultichannelConsumer(
              builder: (context, ref) {
                var messages = ref.messages;
                var theme = ref.theme;

                if (messages.isEmpty) {
                  print('No messages');
                  return Container(
                    color: theme.emptyBackgroundColor,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No message here yet...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: theme.emptyTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Great discussion start from greeting each others first',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.emptyTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

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
