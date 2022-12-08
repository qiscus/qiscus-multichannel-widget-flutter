import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:qiscus_multichannel_widget/src/models.dart';
import 'package:qiscus_multichannel_widget/src/utils/generate_link_text.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'chat_video.freezed.dart';
part 'chat_video.g.dart';

class QChatVideo extends StatelessWidget {
  const QChatVideo({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessageVideo message;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return QMultichannelConsumer(
      builder: (context, ref) {
        final bgColor = _getBgColor(ref);

        QImagePayload? payload;
        if (message.payload != null) {
          payload = QImagePayload.fromJson(message.payload!);
        }
        var url = message.url;

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
                        child: QMultichannelConsumer(
                          builder: (context, ref) {
                            return ref.qiscus.maybeWhen(
                              orElse: () => const CircularProgressIndicator(),
                              data: (qiscus) {
                                return Stack(
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
                                );
                              },
                            );
                          },
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
