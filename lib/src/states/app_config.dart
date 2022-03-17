import 'package:freezed_annotation/freezed_annotation.dart';

import '../config/avatar_config.dart';
import '../config/subtitle_config.dart';

part 'app_config.freezed.dart';

@freezed
class QAppConfig with _$QAppConfig {
  const factory QAppConfig({
    @Default('https://multichannel.qiscus.com') String baseUrl,
    String? title,
    QSubtitleConfig? subtitle,
    QAvatarConfig? avatar,
    String? channelId,
    String? deviceId,
    @Default(true) bool showSystemEvent,
    @Default(true) bool showSenderAvatar,
  }) = _QAppConfig;
}
