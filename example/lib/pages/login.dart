import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class LoginPage extends Page {
  const LoginPage({
    required this.onChangeAppId,
  }) : super(key: const ValueKey('LoginPageKey'));

  final void Function(String appId) onChangeAppId;

  @override
  String? get name => 'LoginPage';

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => LoginScreen(
        onChangeAppId: onChangeAppId,
      ),
    );
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    super.key,
    this.onChangeAppId,
  });

  final void Function(String appId)? onChangeAppId;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final appIdController =
      TextEditingController(text: 'wefds-c6f0p2h1cxwz3oq');
  late final usernameController = TextEditingController(text: 'guest-1001');
  late final displayNameController = TextEditingController(text: 'guest-1001');

  // Non Secure Channel
  late final channelIdController = TextEditingController(text: '126962');

  // Secure Channel
  // late final channelIdController = TextEditingController(text: '126965');

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
                  decoration: const InputDecoration(hintText: 'App ID'),
                  controller: appIdController,
                  onSubmitted: (val) {
                    widget.onChangeAppId?.call(val);
                  },
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Channel ID'),
                  controller: channelIdController,
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
                  child: ElevatedButton(
                    onPressed: () => _onDoLogin(),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDoLogin() async {
    var channelId = channelIdController.text;
    var username = usernameController.text;
    var displayName = displayNameController.text;

    try {
      ref.read(QMultichannel.provider).setChannelId(channelId);
      ref.read(QMultichannel.provider).setUser(
        userId: username,
        displayName: displayName,
        userProperties: {'name': 'something', 'username': username},
        extras: {'extras_value1': 'value1'},
      );
    } catch (e) {
      print('got error');
      print(e);
    }

    var deviceId = await FirebaseMessaging.instance.getToken();
    ref.read(QMultichannel.provider).setDeviceId(deviceId!);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );

    try {
      ref.read(QMultichannel.provider).initiateChat();

      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => QChatRoomScreen(onBack: (ctx) {
              ref.read(QMultichannel.provider).clearUser();
              Navigator.of(context).maybePop();
            }),
          ),
        );
      }
    } catch (e) {
      print('type: ${e.runtimeType}');
    }
  }
}
