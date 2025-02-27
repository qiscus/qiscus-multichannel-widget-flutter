import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multichannel_flutter_sample/constant.dart' as constant;
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class LoginPage extends Page {
  final void Function(String appId) onChangeAppId;

  const LoginPage({required this.onChangeAppId})
      : super(key: const ValueKey('LoginPageKey'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (BuildContext context) {
          return LoginScreen(onChangeAppId: onChangeAppId);
        });
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.onChangeAppId});
  final void Function(String appId)? onChangeAppId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final appIdController = TextEditingController(text: constant.appId);
  late final usernameController = TextEditingController(text: 'guest-1001');
  late final displayNameController = TextEditingController(text: 'guest-1001');
  late final channelIdController =
      TextEditingController(text: constant.channelId);

  bool initiating = false;

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
                  child: IgnorePointer(
                    ignoring: initiating,
                    child: QMultichannelConsumer(
                      builder: (context, multichannel) => ElevatedButton(
                        onPressed: () => _onDoLogin(),
                        child: initiating
                            ? const Text('Logging In...')
                            : const Text('Login'),
                      ),
                    ),
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

    setState(() {
      initiating = true;
    });

    ref.read(QMultichannel.provider).setChannelId(channelId);
    ref.read(QMultichannel.provider).setUser(
          userId: username,
          displayName: displayName,
          userProperties: {'name': 'something', 'username': username},
          extras: {'extras_value1': 'value1'},
          avatarUrl: 'https://via.placeholder.com/200',
        );

    await FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) ref.read(QMultichannel.provider).setDeviceId(token);
    }).catchError((error) {
      print('got error when setting device token: $error');
    });

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );

    try {
      await ref.read(QMultichannel.provider).initiateChat().then((_) {
        setState(() {
          initiating = false;
        });
      });

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
