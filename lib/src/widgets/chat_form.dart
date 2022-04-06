import 'package:flutter/material.dart';

import '../../qiscus_multichannel_widget.dart';

class QChatForm extends ConsumerWidget {
  QChatForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: "#fafafa".toColor(),
        border: Border(
          top: BorderSide(width: 1, color: "#e3e3e3".toColor()),
        ),
      ),
      child: QMultichannelConsumer(
        builder: (context, ref) {
          var account = ref.account;
          final fgColor = ref.theme.fieldChatTextColor;
          final borderColor = ref.theme.fieldChatBorderColor;

          final border = OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor),
          );

          return Padding(
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
                        enabled: account.hasValue,
                        controller: _messageController,
                        onSubmitted: (_) => _onSubmit(ref),
                        decoration: InputDecoration(
                          hintText: 'Your message here...',
                          disabledBorder: border,
                          enabledBorder: border,
                          focusedBorder: border,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _onSubmit(ref);
                    },
                    child: Image.asset("assets/ic-send.png"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSubmit(QMultichannel ref) async {
    var text = _messageController.text;
    var message = await ref.generateMessage(text: text);
    await ref.sendMessage(message);
    _messageController.text = '';
  }
}
