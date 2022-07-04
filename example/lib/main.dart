import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

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

class _AppStateBuilder extends State<App> {
  @override
  Widget build(BuildContext context) {
    return QMultichannelProvider(
      appId: appId,
      builder: (context) {
        return MaterialApp(
          home: _buildNavigator(),
        );
      },
    );
  }

  Widget _buildNavigator() {
    return QMultichannelConsumer(
      builder: (context, ref) {
        var roomId = ref.roomId;

        return Navigator(
          pages: [
            LoginPage(),
            if (roomId != null) QChatRoomPage(),
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
