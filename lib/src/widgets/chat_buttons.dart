import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

part 'chat_buttons.freezed.dart';
part 'chat_buttons.g.dart';

class QChatButton extends StatelessWidget {
  const QChatButton({Key? key, required this.message}) : super(key: key);
  final QMessageButton message;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var payload = message.typedPayload;
    print('payload: $payload');

    return QMultichannelConsumer(
      builder: (context, ref) {
        final bgColor = _getBgColor(ref);

        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: size.width * 0.6,
              decoration: BoxDecoration(
                color: bgColor,
                // color: Colors.amber,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(payload.text),
                  ),
                  _renderButtons(payload.buttons),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getBgColor(QMultichannel ref) {
    final account = ref.account.value!;
    if (account.id == message.sender.id) {
      return ref.theme.rightBubbleColor;
    } else {
      return ref.theme.leftBubbleColor;
    }
  }

  Widget _renderButton(QButtons button) {
    return ElevatedButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          color: Color(0xFF666666),
        ),
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Text(button.label),
    );
  }

  Widget _renderButtons(List<QButtons> buttons) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      buttonPadding: EdgeInsets.zero,
      children: <Widget>[
        ...buttons.map((button) => _renderButton(button)),
      ],
    );
  }
}

class QMessageButton extends QMessage {
  QMessageButton.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );

  late QMessageButtonPayload typedPayload =
      QMessageButtonPayload.fromJson(super.payload!);

  static QMessageButton? tryParse(QMessage message) {
    if (message.type == QMessageType.custom &&
        message.payload?['type'] == 'buttons') {
      return QMessageButton.fromMessage(message);
    }
    return null;
  }
}

@freezed
class QMessageButtonPayload with _$QMessageButtonPayload {
  const factory QMessageButtonPayload({
    required String text,
    required List<QButtons> buttons,
    required String type,
  }) = _QMessageButtonPayload;

  factory QMessageButtonPayload.fromJson(Map<String, Object?> json) =>
      _$QMessageButtonPayloadFromJson(json);
}

@freezed
class QButtons with _$QButtons {
  const factory QButtons({
    required String label,
    @JsonKey(name: 'postback_text') required String postbackText,
    required String type,
    required QButtonsPostbackPayload payload,
  }) = _QButtons;

  factory QButtons.fromJson(Map<String, Object?> json) =>
      _$QButtonsFromJson(json);
}

@freezed
class QButtonsPostbackPayload with _$QButtonsPostbackPayload {
  const factory QButtonsPostbackPayload({
    required String url,
    required String method,
    required Map<String, Object?>? payload,
  }) = _QButtonsPayload;

  factory QButtonsPostbackPayload.fromJson(Map<String, Object?> json) =>
      _$QButtonsPostbackPayloadFromJson(json);

  // Map<String, Object?> toJson() => _$QButtonsPostbackPayloadToJson(this);
}
