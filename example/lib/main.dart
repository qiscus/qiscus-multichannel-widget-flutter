import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:multichannel_flutter_sample/constant.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'firebase_options.dart';
import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Show notifications while the app is open too (hidden by default on iOS).
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return QMultichannelProvider(
      appId: appId,
      title: 'Some custom title',
      // avatar: QAvatarConfig.editable('https://via.placeholder.com/200'),
      // rightAvatar: QAvatarConfig.enabled(),
      avatar: const QAvatarConfig.disabled(),
      rightAvatar: const QAvatarConfig.disabled(),
      hideEventUI: true,
      onURLTapped: (url) {
        var uri = Uri.tryParse(url);
        if (uri != null) {
          launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      },
      builder: (context) {
        return const MaterialApp(
          home: LoginScreen(),
        );
      },
    );
  }
}
