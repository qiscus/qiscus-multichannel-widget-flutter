import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class LoginPage extends Page {
  const LoginPage() : super(key: const ValueKey("LoginPageKey"));

  @override
  String? get name => 'LoginPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final usernameController = TextEditingController(text: 'guest-1001');
  late final displayNameController = TextEditingController(text: 'guest-1001');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                  controller: usernameController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Display name',
                  ),
                  controller: displayNameController,
                ),
                SizedBox(
                  width: double.infinity,
                  child: QMultichannelConsumer(
                    builder: (context, ref) {
                      return ElevatedButton(
                        onPressed: () => _onDoLogin(ref),
                        child: const Text('Login'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDoLogin(QMultichannel mulchan) async {
    var username = usernameController.text;
    var displayName = displayNameController.text;

    try {
      print('set user! $username');
      mulchan.setUser(
        userId: username,
        displayName: displayName,
        userProperties: {
          'name': 'something',
        },
      );
    } catch (e) {
      print('got error');
      print(e);
    }
    // var deviceId = await FirebaseMessaging.instance.getToken();
    // mulchan.setDeviceId(deviceId!);

    print('initiate chat!');
    try {
      mulchan.initiateChat().then(
        (room) {
          print('sukses initiate chat: ${room.id}');
        },
        onError: (err) {
          print('fail initiatae chat: ${err.runtimeType}');
        },
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => QChatRoomScreen(onBack: (ctx) {
            print('on do back!');
            mulchan.clearUser();
            Navigator.of(context)
                .maybePop()
                .then((r) => debugPrint('maybePop: $r'));
          }),
        ),
      );
    } catch (e) {
      print('type: ${e.runtimeType}');
    }
  }
}
