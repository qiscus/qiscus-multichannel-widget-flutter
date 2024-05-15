import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../provider.dart';
import '../utils/extensions.dart';

part 'chat_buttons.freezed.dart';
part 'chat_buttons.g.dart';

class QChatButton extends ConsumerWidget {
  const QChatButton({super.key, required this.message});
  final QMessageButton message;

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    var payload = message.typedPayload;
    final bgColor = ref.watch(chatBubbleBgColorProvider(message.sender));
    final fgColor = ref.watch(chatBubbleFgColorProvider(message.sender));

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
                child: Text(
                  payload.text,
                  style: TextStyle(
                    color: fgColor,
                  ),
                ),
              ),
              QButtonListFragment(
                buttons: payload.buttons,
                message: message,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QButtonListFragment extends ConsumerWidget {
  const QButtonListFragment({
    super.key,
    required this.buttons,
    required this.message,
  });
  final List<QButtons> buttons;
  final QMessage message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ...buttons.mapIndexed(
              (index, button) => SizedBox(
                width: double.infinity,
                child: QButtonFragment(
                  button: button,
                  message: message,
                  first: index == 0,
                  last: (buttons.length - 1) == index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QButtonFragment extends ConsumerWidget {
  const QButtonFragment({
    super.key,
    required this.button,
    required this.message,
    required this.first,
    required this.last,
  });
  final QButtons button;
  final QMessage message;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fgColor =
        ref.watch(appThemeConfigProvider.select((v) => v.buttonChatTextColor));
    var bgColor = ref.watch(
        appThemeConfigProvider.select((v) => v.buttonChatBackgroundColor));
    var borderColor = ref
        .watch(appThemeConfigProvider.select((v) => v.buttonChatBorderColor));

    BorderRadius borderRadius = BorderRadius.zero;
    if (first) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      );
    }
    if (last) {
      borderRadius = const BorderRadius.only(
        bottomLeft: Radius.circular(4),
        bottomRight: Radius.circular(4),
      );
    }

    return ElevatedButton(
      onPressed: () {
        ref
            .read(onButtonTappedProvider)
            .call(QMultichannel(ref), message, button);
      },
      style: TextButton.styleFrom(
        backgroundColor: bgColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        foregroundColor: fgColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          color: borderColor,
          width: 0.8,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
      ),
      child: Text(
        button.label,
        style: TextStyle(
          color: fgColor,
        ),
      ),
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
class QMessagePostbackResponse with _$QMessagePostbackResponse {
  const factory QMessagePostbackResponse({
    required int roomId,
    required QButtons button,
  }) = _QMessagePostbackResponse;
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
    @JsonKey(name: 'postback_text') String? postbackText,
    required String type,
    required QButtonsPostbackPayload payload,
  }) = _QButtons;

  factory QButtons.fromJson(Map<String, Object?> json) =>
      _$QButtonsFromJson(json);
}

extension QButtonsX on QButtons {
  /// Send the next action for this button
  /// if this button [type] are `postback` it will send a message with type
  /// `button_postback_response` and if this button [type] are `link` it will
  /// trigger `onURLTapped` handler
  Future<void> next(QMultichannel ref) async {
    if (type == 'link') {
      ref.ref.read(onURLTappedProvider)?.call(payload.url);
    }
    if (type == 'postback') {
      var qiscus = await ref.ref.read(qiscusProvider).future;
      var headers = <String, String>{
        'qiscus-sdk-app-id': qiscus.storage.appId!,
        // 'qiscus-sdk-version': qiscus.storage.version!,
        'qiscus-sdk-token': qiscus.storage.token!,
        'qiscus-sdk-user-id': qiscus.storage.currentUser!.id,
        'content-type': 'application/json',
      };

      var roomId = ref.roomId!;
      var text = postbackText?.isNotEmpty == true ? postbackText : label;

      var baseUrl = qiscus.storage.baseUrl;
      var url = Uri.parse('$baseUrl/api/v2/mobile/post_comment');
      var body = {
        'topic_id': '$roomId',
        'comment': text,
        'type': 'button_postback_response',
        'unique_temp_id': 'flutter-${DateTime.now().millisecondsSinceEpoch}',
        'payload': payload,
        'extras': null,
      };

      http.post(url, headers: headers, body: jsonEncode(body)).ignore();
    }
  }
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
