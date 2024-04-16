import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multichannel_flutter_sample/firebase_options.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppStateBuilder();
}

class _AppStateBuilder extends State<App> {
  var appId = 'wefds-c6f0p2h1cxwz3oq';
  // static const appId = 'dragongo2';
  // static const baseURL = 'https://dragongo.qiscus.io';

  @override
  Widget build(BuildContext context) {
    return QMultichannelProvider(
      // sdkBaseUrl: baseURL,
      appId: appId,
      // channelId: channelId,
      title: 'Some custom title',
      avatar: QAvatarConfig.enabled(),
      rightAvatar: QAvatarConfig.disabled(),
      hideEventUI: true,
      onURLTapped: (url) {
        var uri = Uri.tryParse(url);
        print('url tapped: $url $uri');
        if (uri != null) {
          launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      },
      builder: (context) {
        return MaterialApp(
          home: LoginScreen(),
        );
      },
    );
  }
}
