import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models.dart';
import '../provider.dart';
import '../utils/generate_link_text.dart';

part 'chat_video.freezed.dart';
part 'chat_video.g.dart';

class QChatVideo extends ConsumerWidget {
  const QChatVideo({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessageVideo message;

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;

    final bgColor = _getBgColor(ref);
    QImagePayload? payload;
    if (message.payload != null) {
      payload = QImagePayload.fromJson(message.payload!);
    }
    var url = message.url;
    var qiscus = ref.watch(qiscusProvider).requireValue;

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
                          qiscus.getThumbnailURL(url),
                          fit: BoxFit.contain,
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(80),
                            ),
                            child: const Icon(
                              Icons.play_circle_outline,
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
                if (payload?.caption?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichLinkText(
                      sender: message.sender,
                      text: payload!.caption!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBgColor(WidgetRef ref) {
    final account = ref.read(accountProvider).value!;
    final theme = ref.read(appThemeConfigProvider);
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
