import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:qiscus_multichannel_widget/src/widgets/chat_form.dart';

import '../bloc/app_bloc.dart';
import '../states/app_state.dart';
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

class QChatRoomScreen extends StatefulWidget {
  const QChatRoomScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<QChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    var qiscus = context.qiscus();
    var room = context.room()!;
    var account = context.account()!;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: buildAppBar(context: context, room: room),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: BlocSelector<QAppBloc, QAppState, List<QMessage>>(
              selector: (state) => state.maybeMap(
                orElse: () => [],
                ready: (v) => v.messages,
              ),
              builder: (context, messages) {
                return GroupedListView<QMessage, DateTime>(
                  elements: messages,
                  groupBy: (message) => message.timestamp,
                  itemBuilder: (context, message) {
                    return _buildChatBubble(context, account, message);
                  },
                  groupSeparatorBuilder: (DateTime date) {
                    return _buildSeparator(date);
                  },
                );
              },
            ),
          ),
          QChatForm(
            onSubmit: (String text) {
              var message = qiscus.generateMessage(
                chatRoomId: room.id,
                text: text,
              );
              qiscus.sendMessage(message: message).then((message) {
                print('sukses kirim pesan: ${message.id}');
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator(_) {
    return Container();
  }

  Widget _buildChatBubble(
      BuildContext context, QAccount account, QMessage message) {
    if (message.sender.id == account.id) {
      return QChatBubbleRight(message: message);
    } else {
      return QChatBubbleLeft(message: message);
    }
  }
}
