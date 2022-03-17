import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

import 'pages/login.dart';

void main() {
  const app = App();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppStateBuilder();
}

class _AppStateBuilder extends State<App> {
  static const appId = 'sdksample';
  late final QMultichannelWidget mulchan = QMultichannelWidget.builder(
    appId: appId,
  );
  QiscusSDK get qiscus => mulchan.qiscus;

  @override
  Widget build(BuildContext context) {
    return QMultichannelProvider(
      instance: mulchan,
      builder: (context, state) {
        var room = context.room();
        print('room: $room');

        return MaterialApp(
          theme: ThemeData(
            primaryColor: "#27B199".toColor(),
            colorScheme: ColorScheme.light(
              primary: "#27B199".toColor(),
            ),
          ),
          home: Navigator(
            pages: [
              LoginPage(mulchan: mulchan),
              if (room != null) QChatRoomPage(),
            ],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }

              return true;
            },
          ),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
    required this.mulchan,
  }) : super(key: key);
  final QMultichannelWidget mulchan;

  @override
  Widget build(BuildContext context) {
    return QMultichannelBuilder(
      builder: (context, state) {
        var room = context.room();
        print('room: $room');
        return Navigator(
          pages: [
            LoginPage(mulchan: mulchan),
          ],
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }

            return true;
          },
        );
      },
    );
  }
}
