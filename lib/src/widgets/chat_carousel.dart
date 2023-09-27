import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:qiscus_multichannel_widget/src/widgets/chat_buttons.dart';

import '../provider.dart';

part 'chat_carousel.freezed.dart';
part 'chat_carousel.g.dart';

class QChatCarousel extends ConsumerWidget {
  const QChatCarousel({
    Key? key,
    required this.message,
  }) : super(key: key);
  final QMessageCarousel message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var payload = message.typedPayload;
    var pageController = PageController(
      viewportFraction: 0.8,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: SizedBox(
        width: size.width * 0.7,
        height: 370,
        child: PageView.builder(
          itemCount: payload.cards.length,
          scrollDirection: Axis.horizontal,
          controller: pageController,
          // shrinkWrap: true,
          itemBuilder: (context, index) {
            var card = payload.cards[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: QCarouselCardFragment(message: message, card: card),
            );
          },
        ),
      ),
    );
  }
}

class QCarouselCardFragment extends ConsumerWidget {
  const QCarouselCardFragment({
    Key? key,
    required this.message,
    required this.card,
  }) : super(key: key);
  final QMessage message;
  final QCarouselCard card;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var bgColor = ref.watch(chatBubbleBgColorProvider(message.sender));
    var fgColor = ref.watch(chatBubbleFgColorProvider(message.sender));

    return ClipRRect(
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
            SizedBox(
              width: double.maxFinite,
              height: 150,
              child: Container(
                color: fgColor.withAlpha(90),
                child: Image.network(card.image),
              ),
            ),
            // title
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                card.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: fgColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            // description
            if (card.description != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    card.description!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            QButtonListFragment(
              buttons: card.buttons,
              message: message,
            ),
          ],
        ),
      ),
    );
  }
}

class QMessageCarousel extends QMessage {
  QMessageCarousel.fromMessage(QMessage message)
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

  late QMessageCarouselPayload typedPayload =
      QMessageCarouselPayload.fromJson(payload!);

  static QMessageCarousel? tryParse(QMessage message) {
    if (message.type == QMessageType.custom &&
        message.payload?['type'] == 'carousel') {
      return QMessageCarousel.fromMessage(message);
    }
    return null;
  }
}

@freezed
class QMessageCarouselPayload with _$QMessageCarouselPayload {
  const factory QMessageCarouselPayload({
    required List<QCarouselCard> cards,
  }) = _QMessageCarouselPayload;

  factory QMessageCarouselPayload.fromJson(Map<String, Object?> json) =>
      _$QMessageCarouselPayloadFromJson(json);
}

@freezed
class QCarouselCard with _$QCarouselCard {
  const factory QCarouselCard({
    required String image,
    required String title,
    String? description,
    @JsonKey(name: 'default_action') required QCarouselAction defaultAction,
    required List<QButtons> buttons,
  }) = _QCarouselCard;

  factory QCarouselCard.fromJson(Map<String, Object?> json) =>
      _$QCarouselCardFromJson(json);
}

@freezed
class QCarouselAction with _$QCarouselAction {
  const factory QCarouselAction({
    required String type,
    @JsonKey(name: 'postback_text') required String postbackText,
    required QCarouselActionPayload payload,
  }) = _QCarouselAction;

  factory QCarouselAction.fromJson(Map<String, Object?> json) =>
      _$QCarouselActionFromJson(json);
}

@freezed
class QCarouselActionPayload with _$QCarouselActionPayload {
  const factory QCarouselActionPayload({
    required String method,
    required String url,
    Map<String, Object?>? payload,
  }) = _QCarouselActionPayload;

  factory QCarouselActionPayload.fromJson(Map<String, Object?> json) =>
      _$QCarouselActionPayloadFromJson(json);
}
