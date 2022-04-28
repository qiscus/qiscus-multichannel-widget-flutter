import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppStateBuilder();
}

class _AppStateBuilder extends State<App> {
  static const appId = 'YOUR_APP_ID';

  @override
  Widget build(BuildContext context) {
    return QMultichannelProvider(
      appId: appId,
      // theme: QAppTheme(
      //   rightBubbleColor: Colors.amberAccent.withAlpha(150),
      //   leftBubbleColor: Colors.blueAccent.withAlpha(150),
      //   rightBubbleTextColor: Colors.black87,
      //   leftBubbleTextColor: Colors.black87,
      //   fieldChatBorderColor: Colors.amberAccent,
      //   fieldChatTextColor: Colors.teal,
      //   navigationColor: Colors.teal,
      //   navigationTitleColor: Colors.tealAccent,
      // ),
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
