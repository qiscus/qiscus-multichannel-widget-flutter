import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../provider.dart';
import '../states/app_theme.dart';
import '../utils/generate_link_text.dart';

part 'chat_image.freezed.dart';
part 'chat_image.g.dart';

class QChatImage extends ConsumerWidget {
  const QChatImage({
    super.key,
    required this.message,
    required this.url,
  });

  final String url;
  final QMessage message;

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    final account = ref.watch(accountProvider).requireValue;
    final theme = ref.watch(appThemeConfigProvider);

    final bgColor = _getBgColor(account, theme);
    var payload = QImagePayload.fromJson(message.payload!);

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
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: GestureDetector(
                    onTap: () async {
                      await launchUrlString(url);
                    },
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          url,
                          fit: BoxFit.contain,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(80),
                            ),
                            child: const Icon(
                              Icons.image,
                              size: 34,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Positioned(
                          bottom: 10,
                          right: 10,
                          child: Icon(
                            Icons.open_in_new,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (payload.caption?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichLinkText(
                      text: payload.caption!,
                      sender: message.sender,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBgColor(QAccount account, QAppTheme theme) {
    if (account.id == message.sender.id) {
      return theme.rightBubbleColor;
    } else {
      return theme.leftBubbleColor;
    }
  }
}

@freezed
class QImagePayload with _$QImagePayload {
  const factory QImagePayload({
    required String url,
    required String? caption,
    @JsonKey(name: 'file_name') required String? fileName,
    required int? size,
    required int? pages,
    @JsonKey(name: 'encryption_key') required String? encryptionKey,
  }) = _QImagePayload;

  factory QImagePayload.fromJson(Map<String, Object?> json) =>
      _$QImagePayloadFromJson(json);
}
