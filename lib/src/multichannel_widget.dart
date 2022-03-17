import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:qiscus_multichannel_widget/src/states/app_state.dart';

import 'bloc/app_bloc.dart';
import 'states/app_config.dart';
import 'states/app_theme.dart';
import 'config/avatar_config.dart';
import 'config/subtitle_config.dart';

class QMultichannelWidget with QTheme, QConfig {
  late final qiscus = QiscusSDK();
  late final _appBloc = QAppBloc(qiscus);
  @override
  QAppBloc get appBloc => _appBloc;

  factory QMultichannelWidget(String appId) {
    return QMultichannelWidget.builder(appId: appId);
  }

  QMultichannelWidget.builder({
    required String appId,
    QAvatarConfig avatar = const QAvatarConfig.enabled(),
    QSubtitleConfig subtitle = const QSubtitleConfig.enabled(),
    String? title,
    String? channelId,
    bool hideEventUI = false,
    String baseUrl = 'https://multichannel.qiscus.com',
    //
    Color baseColor = const Color.fromARGB(1, 249, 249, 249),
    Color navigationColor = const Color.fromARGB(1, 85, 178, 154),
    Color navigationTitleColor = const Color.fromARGB(1, 255, 255, 255),
    Color systemEventTextColor = const Color.fromARGB(1, 255, 255, 255),
    Color rightBubbleColor = const Color.fromARGB(1, 85, 178, 154),
    Color rightBubbleTextColor = const Color.fromARGB(1, 255, 255, 255),
    Color leftBubbleColor = const Color.fromARGB(1, 244, 244, 244),
    Color leftBubbleTextColor = const Color.fromARGB(1, 102, 102, 102),
    Color timeLabelTextColor = const Color.fromARGB(1, 123, 123, 123),
    Color timeBackgroundColor = const Color.fromARGB(0, 0, 0, 0),
    Color emptyTextColor = const Color.fromARGB(1, 153, 153, 153),
    Color emptyBackgroundColor = const Color.fromARGB(1, 249, 249, 249),
    Color sendContainerColor = const Color.fromARGB(1, 255, 255, 255),
    Color sendContainerBackgroundColor = const Color.fromARGB(1, 250, 250, 250),
    Color fieldChatBorderColor = const Color.fromARGB(1, 227, 227, 227),
    Color fieldChatTextColor = const Color.fromARGB(1, 51, 51, 51),
  }) {
    appBloc.setup(
      appId: appId,
      appConfig: QAppConfig(
        avatar: avatar,
        subtitle: subtitle,
        channelId: channelId,
        baseUrl: baseUrl,
      ),
      theme: QAppTheme(
        baseColor: baseColor,
        navigationColor: navigationColor,
        navigationTitleColor: navigationTitleColor,
        systemEventTextColor: systemEventTextColor,
        rightBubbleColor: rightBubbleColor,
        rightBubbleTextColor: rightBubbleTextColor,
        leftBubbleColor: leftBubbleColor,
        leftBubbleTextColor: leftBubbleTextColor,
        timeLabelTextColor: timeLabelTextColor,
        timeBackgroundColor: timeBackgroundColor,
        emptyTextColor: emptyTextColor,
        emptyBackgroundColor: emptyBackgroundColor,
        sendContainerColor: sendContainerColor,
        sendContainerBackgroundColor: sendContainerBackgroundColor,
        fieldChatBorderColor: fieldChatBorderColor,
        fieldChatTextColor: fieldChatTextColor,
      ),
    );
  }

  Future<void> initiateChat() => appBloc.initiateChat();

  void setUser({
    required String userId,
    String? displayName,
    String? avatarUrl,
    Map<String, dynamic>? userProperties,
  }) {
    appBloc.setUser(
      userId: userId,
      displayName: displayName ?? userId,
      avatarUrl: avatarUrl,
      userProperties: userProperties,
    );
  }
}

mixin QConfig {
  QAppBloc get appBloc;

  void setChannelId(String channelId) => appBloc.setChannelId(channelId);
  void setRoomTitle(String title) => appBloc.setRoomTitle(title);
  void setRoomSubtitle(QSubtitleConfig config) =>
      appBloc.setRoomSubtitle(config);
  void setAvatar(QAvatarConfig config) => appBloc.setAvatar(config);
  void setHideUIEvent([bool hide = true]) => appBloc.setHideUIEvent(hide);
}
mixin QTheme {
  QAppBloc get appBloc;

  void get setNavigationColor => appBloc.setNavigationColor;
  void get setNavigationTitleColor => appBloc.setNavigationTitleColor;
  void get setBaseColor => appBloc.setBaseColor;
  void get setRightBubbleColor => appBloc.setRightBubbleColor;
  void get setLeftBubbleColor => appBloc.setLeftBubbleColor;
  void get setRightBubbleTextColor => appBloc.setRightBubbleTextColor;
  void get setLeftBubbleTextColor => appBloc.setLeftBubbleTextColor;
  void get setSendContainerBackgroundColor =>
      appBloc.setSendContainerBackgroundColor;
  void get setSendContainerColor => appBloc.setSendContainerColor;
  void get setFieldChatBorderColor => appBloc.setFieldChatBorderColor;
}
