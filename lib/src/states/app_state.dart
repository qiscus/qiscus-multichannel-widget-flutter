import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import 'app_config.dart';
import 'app_theme.dart';
import 'user_config.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _AppStateInitial;

  const factory AppState.ready({
    required int roomId,
    required QAccount account,
  }) = _AppStateReady;
}

@freezed
class QAppState with _$QAppState {
  factory QAppState.initial({
    @Default(QAppConfig()) QAppConfig appConfig,
    @Default(QAppTheme()) QAppTheme theme,
  }) = _QAppStateInitial;

  factory QAppState.setup({
    required String appId,
    @Default(QAppConfig()) QAppConfig appConfig,
    @Default(QAppTheme()) QAppTheme theme,
  }) = _QAppStateSetup;

  factory QAppState.authenticated({
    required String appId,
    required QUserConfig userConfig,
    @Default(QAppConfig()) QAppConfig appConfig,
    @Default(QAppTheme()) QAppTheme theme,
  }) = _QAppStateAuthenticated;

  factory QAppState.ready({
    required String appId,
    required QAccount account,
    required QChatRoom room,
    @Default([]) List<QMessage> messages,
    @Default(QAppConfig()) QAppConfig appConfig,
    @Default(QAppTheme()) QAppTheme theme,
  }) = _QAppStateReady;
}
