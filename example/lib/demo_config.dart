import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

enum DemoThemePreset {
  qiscus('Qiscus Teal'),
  ocean('Ocean Blue'),
  berry('Berry Purple'),
  forest('Forest Green');

  final String label;
  const DemoThemePreset(this.label);

  QAppTheme get theme {
    switch (this) {
      case DemoThemePreset.ocean:
        return const QAppTheme(
          navigationColor: Color(0xFF0077B6),
          rightBubbleColor: Color(0xFF00B4D8),
          sendContainerColor: Color(0xFF0077B6),
        );
      case DemoThemePreset.berry:
        return const QAppTheme(
          navigationColor: Color(0xFF8E44AD),
          rightBubbleColor: Color(0xFF9B59B6),
          sendContainerColor: Color(0xFF8E44AD),
        );
      case DemoThemePreset.forest:
        return const QAppTheme(
          navigationColor: Color(0xFF1B5E20),
          rightBubbleColor: Color(0xFF4CAF50),
          sendContainerColor: Color(0xFF1B5E20),
        );
      case DemoThemePreset.qiscus:
        return const QAppTheme();
    }
  }
}

class DemoUiConfig {
  final String appId;
  final String channelId;
  final String userId;
  final String displayName;
  final String roomTitle;
  final String avatarUrl;
  final bool showSystemEvents;
  final bool showLeftAvatar;
  final bool showRightAvatar;
  final DemoThemePreset themePreset;

  const DemoUiConfig({
    required this.appId,
    required this.channelId,
    required this.userId,
    required this.displayName,
    this.roomTitle = 'Customer Service',
    this.avatarUrl = 'https://placehold.co/200',
    this.showSystemEvents = true,
    this.showLeftAvatar = true,
    this.showRightAvatar = false,
    this.themePreset = DemoThemePreset.qiscus,
  });

  DemoUiConfig copyWith({
    String? appId,
    String? channelId,
    String? userId,
    String? displayName,
    String? roomTitle,
    String? avatarUrl,
    bool? showSystemEvents,
    bool? showLeftAvatar,
    bool? showRightAvatar,
    DemoThemePreset? themePreset,
  }) {
    return DemoUiConfig(
      appId: appId ?? this.appId,
      channelId: channelId ?? this.channelId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      roomTitle: roomTitle ?? this.roomTitle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      showSystemEvents: showSystemEvents ?? this.showSystemEvents,
      showLeftAvatar: showLeftAvatar ?? this.showLeftAvatar,
      showRightAvatar: showRightAvatar ?? this.showRightAvatar,
      themePreset: themePreset ?? this.themePreset,
    );
  }
}
