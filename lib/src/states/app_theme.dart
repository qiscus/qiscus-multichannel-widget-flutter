import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_theme.freezed.dart';

@freezed
class QAppTheme with _$QAppTheme {
  const factory QAppTheme({
    @Default(Color.fromARGB(1, 249, 249, 249)) Color baseColor,
    @Default(Color.fromARGB(1, 85, 178, 154)) Color navigationColor,
    @Default(Color.fromARGB(1, 255, 255, 255)) Color navigationTitleColor,
    @Default(Color.fromARGB(1, 255, 255, 255)) Color systemEventTextColor,
    @Default(Color.fromARGB(1, 85, 178, 154)) Color rightBubbleColor,
    @Default(Color.fromARGB(1, 255, 255, 255)) Color rightBubbleTextColor,
    @Default(Color.fromARGB(1, 244, 244, 244)) Color leftBubbleColor,
    @Default(Color.fromARGB(1, 102, 102, 102)) Color leftBubbleTextColor,
    @Default(Color.fromARGB(1, 123, 123, 123)) Color timeLabelTextColor,
    @Default(Color.fromARGB(0, 0, 0, 0)) Color timeBackgroundColor,
    @Default(Color.fromARGB(1, 153, 153, 153)) Color emptyTextColor,
    @Default(Color.fromARGB(1, 249, 249, 249)) Color emptyBackgroundColor,
    @Default(Color.fromARGB(1, 255, 255, 255)) Color sendContainerColor,
    @Default(Color.fromARGB(1, 250, 250, 250))
        Color sendContainerBackgroundColor,
    @Default(Color.fromARGB(1, 227, 227, 227)) Color fieldChatBorderColor,
    @Default(Color.fromARGB(1, 51, 51, 51)) Color fieldChatTextColor,
  }) = _QAppTheme;
}
