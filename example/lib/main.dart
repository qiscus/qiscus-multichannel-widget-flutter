import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multichannel_flutter_sample/constant.dart' as constant;
import 'package:multichannel_flutter_sample/demo_config.dart';
import 'package:multichannel_flutter_sample/login_screen.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

// ignore: missing_provider_scope
final demoConfigProvider = StateProvider<DemoUiConfig>((ref) => const DemoUiConfig(
      appId: constant.appId,
      channelId: constant.channelId,
      userId: 'guest-1001',
      displayName: 'Guest 1001',
    ));

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(demoConfigProvider);

    void updateConfig(DemoUiConfig newConfig) {
      ref.read(demoConfigProvider.notifier).state = newConfig;
    }

    return QMultichannelProvider(
      appId: config.appId,
      title: config.roomTitle,
      avatar: config.showLeftAvatar
          ? QAvatarConfig.editable(config.avatarUrl)
          : const QAvatarConfig.disabled(),
      rightAvatar: config.showRightAvatar
          ? const QAvatarConfig.enabled()
          : const QAvatarConfig.disabled(),
      hideEventUI: !config.showSystemEvents,
      theme: config.themePreset.theme,
      onURLTapped: (url) {
        var uri = Uri.tryParse(url);
        if (uri != null) {
          launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      },
      builder: (context) {
        return MaterialApp(
          title: 'Qiscus Multichannel Demo',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: const Color(0xFF55B29A),
            brightness: Brightness.light,
          ),
          home: LoginScreen(
            config: config,
            onConfigChanged: updateConfig,
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
