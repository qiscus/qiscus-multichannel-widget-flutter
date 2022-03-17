import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class LoginPage extends Page {
  const LoginPage({required this.mulchan})
      : super(key: const ValueKey("LoginPageKey"));

  final QMultichannelWidget mulchan;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => LoginScreen(
        mulchan: mulchan,
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.mulchan}) : super(key: key);

  final QMultichannelWidget mulchan;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final mulchan = widget.mulchan;
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
                  child: ElevatedButton(
                    onPressed: _onDoLogin,
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

  void _onDoLogin() {
    var username = usernameController.text;
    var displayName = displayNameController.text;

    print('username($username) displayName($displayName)');
    mulchan.setUser(userId: username, displayName: displayName);
    mulchan.initiateChat().catchError((error) {
      print("got error: $error");
    });
  }
}
