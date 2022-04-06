import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/avatar_config.dart';
import 'config/subtitle_config.dart';
import 'provider.dart';

final multichannelWidgetProvider = Provider((ref) {
  return QMultichannelWidget(ref);
});

class QMultichannelWidget with QTheme, QConfig {
  @override
  final Ref ref;

  QMultichannelWidget(this.ref);

  Future<void> initiateChat() async {
    await ref.read(initiateChatProvider.future);
  }

  void setUser({
    required String userId,
    String? displayName,
    String? avatarUrl,
    Map<String, dynamic>? userProperties,
  }) {
    ref.read(userIdProvider.notifier).state = userId;
    ref.read(displayNameProvider.notifier).state = displayName;
    ref.read(avatarUrlProvider.notifier).state = avatarUrl;
    ref.read(userPropertiesProvider.notifier).state = userProperties;
  }
}

mixin QConfig {
  Ref get ref;

  void setChannelId(String channelId) {
    ref.read(channelIdConfigProvider.notifier).state = channelId;
  }

  void setRoomTitle(String title) {
    ref.read(titleConfigProvider.notifier).state = title;
  }

  void setRoomSubtitle(QSubtitleConfig config) {
    ref.read(subtitleConfigProvider.notifier).state = config;
  }

  void setAvatar(QAvatarConfig config) {
    ref.read(avatarConfigProvider.notifier).state = config;
  }

  void setHideUIEvent([bool hide = true]) {
    ref.read(systemEventConfigProvider.notifier).state = !hide;
  }
}
mixin QTheme {
  Ref get ref;
  get _notifier => ref.watch(appThemeConfigProvider.notifier);

  void setNavigationColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(navigationColor: color);
    });
  }

  void setNavigationTitleColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(navigationTitleColor: color);
    });
  }

  void setBaseColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(baseColor: color);
    });
  }

  void setRightBubbleColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(rightBubbleColor: color);
    });
  }

  void setLeftBubbleColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(leftBubbleColor: color);
    });
  }

  void setRightBubbleTextColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(rightBubbleTextColor: color);
    });
  }

  void setLeftBubbleTextColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(leftBubbleTextColor: color);
    });
  }

  void setSendContainerBackgroundColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(sendContainerBackgroundColor: color);
    });
  }

  void setSendContainerColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(sendContainerColor: color);
    });
  }

  void setFieldChatBorderColor(Color color) {
    _notifier.update((theme) {
      return theme.copyWith(fieldChatBorderColor: color);
    });
  }
}
