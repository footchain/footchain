import 'package:dapp/commands/connect_metamask_command.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await ConnectMetamaskCommand().execute(context);
            },
            child: Text("Conectar METAMASK")),
      ),
    );
  }
}
