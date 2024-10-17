import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multichannel_flutter_sample/constants.dart';
import 'package:multichannel_flutter_sample/firebase_options.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ignore: missing_provider_scope
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppStateBuilder();
}

class _AppStateBuilder extends State<App> {
  final container = ProviderContainer();

  @override
  Widget build(BuildContext context) {
    return buildWithoutProviderScope(context);
  }

  Widget buildWithoutProviderScope(BuildContext context) {
    return _multichannelProvider();
  }

  Widget buildWithProviderScope(BuildContext context) {
    return ProviderScope(
      parent: container,
      child: _multichannelProvider(container),
    );
  }

  QMultichannelProvider _multichannelProvider([ProviderContainer? container]) {
    return QMultichannelProvider(
      parentProviderContainer: container,
      appId: appId,
      title: 'Some custom title',
      avatar: QAvatarConfig.enabled(),
      rightAvatar: QAvatarConfig.enabled(),
      hideEventUI: true,
      onURLTapped: (url) {
        var uri = Uri.tryParse(url);
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
