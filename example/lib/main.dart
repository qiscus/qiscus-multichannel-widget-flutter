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
  @override
  Widget build(BuildContext context) {
    return QMultichannelProvider(
      appId: 'YOUR APP ID HERE',
      baseUrl: 'your base url here',
      avatar: QAvatarConfig.enabled(),
      channelId: 'your channel id from multichannel dashboard',
      hideEventUI: false,
      subtitle: QSubtitleConfig.editable('custom subtitle here'),
      title: 'custom title here',
      theme: QAppTheme(
        baseColor: Color.fromARGB(255, 249, 249, 249),
        navigationColor: Color.fromARGB(255, 85, 178, 154),
        navigationTitleColor: Color.fromARGB(255, 255, 255, 255),
        systemEventTextColor: Color.fromARGB(255, 255, 255, 255),
        rightBubbleColor: Color.fromARGB(255, 85, 178, 154),
        rightBubbleTextColor: Color.fromARGB(255, 255, 255, 255),
        leftBubbleColor: Color.fromARGB(255, 244, 244, 244),
        leftBubbleTextColor: Color.fromARGB(255, 102, 102, 102),
        timeLabelTextColor: Color.fromARGB(255, 123, 123, 123),
        timeBackgroundColor: Color.fromARGB(0, 0, 0, 0),
        emptyTextColor: Color.fromARGB(255, 153, 153, 153),
        emptyBackgroundColor: Color.fromARGB(255, 249, 249, 249),
        sendContainerColor: Color.fromARGB(255, 255, 255, 255),
        sendContainerBackgroundColor: Color.fromARGB(255, 250, 250, 250),
        fieldChatBorderColor: Color.fromARGB(255, 227, 227, 227),
        fieldChatTextColor: Color.fromARGB(255, 51, 51, 51),
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
