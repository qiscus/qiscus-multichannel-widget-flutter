import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle_config.freezed.dart';

@freezed
class QSubtitleConfig with _$QSubtitleConfig {
  const factory QSubtitleConfig.disabled() = _QSubtitleDisabled;
  const factory QSubtitleConfig.enabled() = _QSubtitleEnabled;
  const factory QSubtitleConfig.editable(String subtitle) = _QSubtitleEditable;
}
