import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initial() = _AppStateInitial;
  const factory AppState.loading({
    required String appId,
  }) = _AppStateLoading;
  const factory AppState.ready({
    required int roomId,
    required QAccount account,
  }) = _AppStateReady;
}
