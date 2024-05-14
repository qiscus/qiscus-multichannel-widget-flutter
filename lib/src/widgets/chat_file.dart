import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models.dart';
import '../provider.dart';
import '../utils/generate_link_text.dart';

part 'chat_file.freezed.dart';
part 'chat_file.g.dart';

class QChatFile extends ConsumerWidget {
  const QChatFile({
    Key? key,
    required this.message,
  }) : super(key: key);

  final QMessageFile message;

  @override
  Widget build(BuildContext context, ref) {
    var size = MediaQuery.of(context).size;
    final bgColor = ref.watch(chatBubbleBgColorProvider(message.sender));
    var url = Uri.tryParse(message.url)!;
    var name = url.pathSegments.last;

    QImagePayload? payload;
    if (message.payload != null) {
      payload = QImagePayload.fromJson(message.payload!);
    }

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
                      await launchUrl(url);
                    },
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.attach_file, size: 24),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Text(name),
                            ),
                          ],
                        ),
                      ),
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
