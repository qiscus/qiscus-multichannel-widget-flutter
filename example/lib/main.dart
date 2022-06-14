import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

const appId = 'akoop-i0xwcb7spjwzhro';

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
      theme: QAppTheme(
        // navigationTitleColor: Colors.amber,
        navigationColor: Colors.blueGrey,
        fieldChatBorderColor: Colors.blueGrey,
        fieldChatTextColor: Colors.blue,
        leftBubbleColor: Colors.blueGrey,
        rightBubbleColor: Colors.blue,
        leftBubbleTextColor: Colors.white,
      ),
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
        if (roomId == null) {
          ref.setUser(userId: 'guest-1001', displayName: 'guest-1001');
          ref.initiateChat();
        }

        return Navigator(
          pages: const [
            // LoginPage(),
            // ...room.maybeWhen(
            //   orElse: () => const [],
            //   data: (room) => [QChatRoomPage()],
            // ),
            QChatRoomPage(),
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
