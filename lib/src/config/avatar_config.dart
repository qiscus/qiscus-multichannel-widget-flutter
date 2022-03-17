import 'package:freezed_annotation/freezed_annotation.dart';

part 'avatar_config.freezed.dart';

@freezed
class QAvatarConfig with _$QAvatarConfig {
  const factory QAvatarConfig.disabled() = _QAvatarDisabled;
  const factory QAvatarConfig.enabled() = _QAvatarEnabled;
  const factory QAvatarConfig.editable(String avatarUrl) = _QAvatarEditable;
}
