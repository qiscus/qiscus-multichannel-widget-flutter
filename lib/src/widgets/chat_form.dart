import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/src/utils/colors.dart';

class QChatForm extends StatelessWidget {
  QChatForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(String) onSubmit;
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    onSubmitted: (_) => _onSubmit(),
                    decoration: InputDecoration(
                      hintText: 'Your message here...',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: '#e3e3e3'.toColor(),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
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
                onPressed: () => _onSubmit(),
                child: Image.asset("assets/ic-send.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    onSubmit(_messageController.text);
    _messageController.text = '';
  }
}
