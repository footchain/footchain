import '../commands/account/connect_metamask_command.dart';
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
        body: Stack(
      children: [
        Image.asset(
          "assets/images/stadium_bg.jpg",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        Center(
            child: Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 18),
                    blurRadius: 32,
                    color: Color(0xFFD0D2DA).withOpacity(0.15))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await ConnectMetamaskCommand().execute(context);
                  },
                  child: const Text("Conectar METAMASK")),
            ],
          ),
        )),
      ],
    ));
  }
}
