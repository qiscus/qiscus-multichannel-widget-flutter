import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'pages/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppStateBuilder();
}

class NavObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    print('[NavObserver] didPop(name: {${route.settings.name}})');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print('[NavObserver] didPush(name: {${route.settings.name}})!');
    super.didPush(route, previousRoute);
  }
}

class _AppStateBuilder extends State<App> {
  final navKey = GlobalKey<NavigatorState>(debugLabel: 'NavKey');

  @override
  Widget build(BuildContext context) {
    return QMultichannelProvider(
      appId: appId,
      channelId: channelId,
      onURLTapped: (url) {
        var uri = Uri.tryParse(url);
        print('url tapped: $url $uri');
        if (uri != null) {
          launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      },
      builder: (context) {
        return MaterialApp(
          home: WillPopScope(
            onWillPop: () async {
              print('will pop!!');
              return !(await navKey.currentState!.maybePop());
            },
            child: QMultichannelConsumer(
              builder: (context, ref) {
                var roomId = ref.roomId;
                ref.enableDebugMode(false);

                return Navigator(
                  key: navKey,
                  onGenerateRoute: (_) => null,
                  pages: [
                    LoginPage(),
                    if (roomId != null) //
                      QChatRoomPage((e) {
                        print('[main.dart] onBack called');
                        ref.clearUser();
                      }),
                  ],
                  observers: [
                    NavObserver(),
                  ],
                  onPopPage: (route, result) => route.didPop(result),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
