import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_config.freezed.dart';

@freezed
class QUserConfig with _$QUserConfig {
  const factory QUserConfig({
    required String userId,
    required String displayName,
    String? avatarUrl,
    Map<String, dynamic>? userProperties,
  }) = _QUserConfig;
}
