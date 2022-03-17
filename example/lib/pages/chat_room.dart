import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class ChatRoomPage extends Page {
  ChatRoomPage({required this.qWidget, required this.room})
      : super(key: ValueKey(room));

  final QChatRoom room;
  final QMultichannelWidget qWidget;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => ChatRoomScreen(room: room, qWidget: qWidget),
    );
  }
}

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    Key? key,
    required this.room,
    required this.qWidget,
  }) : super(key: key);

  final QMultichannelWidget qWidget;
  final QChatRoom room;

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late QChatRoom room = widget.room;
  late QMultichannelWidget qWidget = widget.qWidget;
  late final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var messages = _getMessages();
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        leading: TextButton(
          onPressed: () {},
          child: Icon(
            Icons.arrow_back,
            size: 34,
            color:
                Theme.of(context).appBarTheme.iconTheme?.color ?? Colors.white,
          ),
        ),
        title: Row(
          children: [
            SizedBox.square(
              dimension: 44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/avatar.png",
                  fit: BoxFit.cover,
                  height: 44,
                  width: 44,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(room.name ?? 'Room name'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: GroupedListView<QMessage, DateTime>(
              elements: messages,
              groupBy: (message) => message.timestamp,
              itemBuilder: (context, message) {
                return _buildChatBubble(context, message);
              },
              groupSeparatorBuilder: (DateTime something) {
                return SizedBox(
                  width: 100,
                  height: 20,
                  child: Container(
                    color: Colors.lightGreen,
                    child: Text(
                      formatDate(something, ['HH', ':', 'mm']),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(BuildContext context, QMessage message) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.fromBorderSide(
              BorderSide(color: Colors.grey),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Text(
              message.text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      decoration: BoxDecoration(
        color: "#fafafa".toColor(),
        border: Border(
          top: BorderSide(width: 1, color: "#e3e3e3".toColor()),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              TextButton(
                onPressed: () {},
                child: Image.asset("assets/ic-add.png"),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Your message here...',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: '#e3e3e3'.toColor(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Image.asset("assets/ic-send.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<QMessage> _getMessages() {
    return List.generate(
      10,
      (index) => QMessage(
        id: index,
        chatRoomId: 10,
        previousMessageId: index - 1,
        uniqueId: '123',
        text: 'Some $index',
        status: QMessageStatus.read,
        type: QMessageType.text,
        extras: null,
        payload: null,
        sender: QUser(
          id: "user-1",
          name: "user-1",
        ),
        timestamp: DateTime.now(),
      ),
    );
  }
}
