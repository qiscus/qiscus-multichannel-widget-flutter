import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:qiscus_multichannel_widget/src/states/app_theme.dart';
import 'package:qiscus_multichannel_widget/src/states/app_config.dart';

import '../states/app_state.dart';
import '../states/user_config.dart';
import '../utils/either.dart';

class QAppBloc extends Cubit<QAppState> with QTheme, QConfig {
  final QiscusSDK qiscus;

  QAppBloc(this.qiscus) : super(QAppState.initial());

  void setUser({
    required String userId,
    required String displayName,
    String? avatarUrl,
    Map<String, dynamic>? userProperties,
  }) {
    var s = state.maybeMap(
      orElse: () => state,
      setup: (s) => QAppState.authenticated(
        appId: s.appId,
        userConfig: QUserConfig(
          userId: userId,
          displayName: displayName,
          avatarUrl: avatarUrl,
          userProperties: userProperties,
        ),
        appConfig: s.appConfig,
        theme: s.theme,
      ),
    );

    emit(s);
  }

  void setup({
    required String appId,
    required QAppConfig appConfig,
    QAppTheme theme = const QAppTheme(),
  }) {
    emit(state.maybeMap(
      orElse: () => state,
      initial: (_) => QAppState.setup(
        appId: appId,
        appConfig: appConfig,
        theme: theme,
      ),
    ));
  }

  Future<void> initiateChat() async {
    Either<String, QAppState> newState = await state.maybeMap(
      orElse: () async => Either.left("Need to call `setup` first"),
      authenticated: (v) async {
        await qiscus.setup(v.appId);
        var userId = v.userConfig.userId;
        var userKey = 'passkey';
        // var userKey = '$userId--uniqueKey';

        try {
          var account = await qiscus.setUser(
            userId: userId,
            userKey: userKey,
            username: v.userConfig.displayName,
            avatarUrl: v.userConfig.avatarUrl,
            extras: v.userConfig.userProperties,
          );
          // var roomId = 12;
          var room = await qiscus.chatUser(userId: 'guest-2002');
          var roomData = await qiscus.getChatRoomWithMessages(roomId: room.id);

          return Either.right(QAppState.ready(
            appId: v.appId,
            account: account,
            room: roomData.room,
            messages: roomData.messages,
          ));
        } catch (error) {
          print("error: $error");
          return Either.left(error.toString());
        }
      },
    );

    var res = newState.when(
      left: (error) => throw Exception(error),
      right: (state) => state,
    );
    emit(res);
  }
}

mixin QTheme on Cubit<QAppState> {
  void setNavigationColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(navigationColor: color),
      authenticated: (v) => v.copyWith.theme(navigationColor: color),
      ready: (v) => v.copyWith.theme(navigationColor: color),
    ));
  }

  void setNavigationTitleColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(navigationTitleColor: color),
      authenticated: (v) => v.copyWith.theme(navigationTitleColor: color),
      ready: (v) => v.copyWith.theme(navigationTitleColor: color),
    ));
  }

  void setBaseColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(baseColor: color),
      authenticated: (v) => v.copyWith.theme(baseColor: color),
      ready: (v) => v.copyWith.theme(baseColor: color),
    ));
  }

  void setRightBubbleColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(rightBubbleColor: color),
      authenticated: (v) => v.copyWith.theme(rightBubbleColor: color),
      ready: (v) => v.copyWith.theme(rightBubbleColor: color),
    ));
  }

  void setLeftBubbleColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(leftBubbleColor: color),
      authenticated: (v) => v.copyWith.theme(leftBubbleColor: color),
      ready: (v) => v.copyWith.theme(leftBubbleColor: color),
    ));
  }

  void setRightBubbleTextColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(rightBubbleTextColor: color),
      authenticated: (v) => v.copyWith.theme(rightBubbleTextColor: color),
      ready: (v) => v.copyWith.theme(rightBubbleTextColor: color),
    ));
  }

  void setLeftBubbleTextColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(leftBubbleTextColor: color),
      authenticated: (v) => v.copyWith.theme(leftBubbleTextColor: color),
      ready: (v) => v.copyWith.theme(leftBubbleTextColor: color),
    ));
  }

  void setSendContainerBackgroundColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(sendContainerBackgroundColor: color),
      authenticated: (v) =>
          v.copyWith.theme(sendContainerBackgroundColor: color),
      ready: (v) => v.copyWith.theme(sendContainerBackgroundColor: color),
    ));
  }

  void setSendContainerColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(sendContainerColor: color),
      authenticated: (v) => v.copyWith.theme(sendContainerColor: color),
      ready: (v) => v.copyWith.theme(sendContainerColor: color),
    ));
  }

  void setFieldChatBorderColor(Color color) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.theme(fieldChatBorderColor: color),
      authenticated: (v) => v.copyWith.theme(fieldChatBorderColor: color),
      ready: (v) => v.copyWith.theme(fieldChatBorderColor: color),
    ));
  }
}

mixin QConfig on Cubit<QAppState> {
  void setAppId(String appId) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith(appId: appId),
    ));
  }

  void setChannelId(String channelId) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.appConfig(channelId: channelId),
    ));
  }

  void setRoomTitle(String roomTitle) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.appConfig(title: roomTitle),
      authenticated: (v) => v.copyWith.appConfig(title: roomTitle),
      ready: (v) => v.copyWith.appConfig(title: roomTitle),
    ));
  }

  void setRoomSubtitle(QSubtitleConfig config) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.appConfig(subtitle: config),
      authenticated: (v) => v.copyWith.appConfig(subtitle: config),
      ready: (v) => v.copyWith.appConfig(subtitle: config),
    ));
  }

  void setAvatar(QAvatarConfig config) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.appConfig(avatar: config),
      authenticated: (v) => v.copyWith.appConfig(avatar: config),
      ready: (v) => v.copyWith.appConfig(avatar: config),
    ));
  }

  void setHideUIEvent([bool hide = true]) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.appConfig(showSystemEvent: !hide),
      authenticated: (v) => v.copyWith.appConfig(showSystemEvent: !hide),
      ready: (v) => v.copyWith.appConfig(showSystemEvent: !hide),
    ));
  }

  void setDeviceId(String deviceId) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.appConfig(deviceId: deviceId),
    ));
  }

  void setBaseUrl(String baseUrl) {
    emit(state.maybeMap(
      orElse: () => state,
      setup: (v) => v.copyWith.appConfig(baseUrl: baseUrl),
    ));
  }
}
