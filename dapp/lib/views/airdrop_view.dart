import 'dart:html';

import 'package:dapp/commands/airdrop/deposit_airdrop_command.dart';
import 'package:dapp/commands/airdrop/request_aidrop_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class AirdropView extends StatefulWidget {
  const AirdropView({Key? key}) : super(key: key);

  @override
  _AirdropViewState createState() => _AirdropViewState();
}

class _AirdropViewState extends State<AirdropView> {
  String _transactionHash = "";
  String _errorMessage = "";
  bool _executingTransaction = false;

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
          Positioned(
              top: 24,
              left: 24,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ))),
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
                  Text(
                    "AirDrop FTC",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        String token = await GRecaptchaV3.execute('submit') ??
                            'null returned';
                        try {
                          setState(() {
                            _executingTransaction = true;
                          });
                          final result =
                              await RequestAirDropCommand().execute(token);
                          setState(() {
                            _executingTransaction = false;
                            if (result != null) {
                              _transactionHash = result;
                            }
                          });
                        } on EthereumException catch (e) {
                          setState(() {
                            _executingTransaction = false;
                            _errorMessage = e.data["message"];
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Request",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      )),
                  SizedBox(
                    height: 24,
                  ),
                  if (_executingTransaction) _buildProcessingTransaction(),
                  if (_transactionHash != "")
                    SelectableText("TRANSACTION: $_transactionHash"),
                  if (_errorMessage != "")
                    Text(
                      "${_errorMessage.toUpperCase()}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingTransaction() {
    return CircularProgressIndicator();
  }
}
