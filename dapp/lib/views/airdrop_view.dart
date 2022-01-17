import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import '../commands/airdrop/request_aidrop_command.dart';
import '../widgets/widgets.dart';

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
    return BaseTemplate(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
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
                    const Text(
                      "AirDrop FTC",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
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
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Request",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        )),
                    const SizedBox(
                      height: 24,
                    ),
                    if (_executingTransaction) _buildProcessingTransaction(),
                    if (_transactionHash != "")
                      SelectableText("TRANSACTION: $_transactionHash"),
                    if (_errorMessage != "")
                      Text(
                        _errorMessage.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.red[400],
                            fontWeight: FontWeight.bold),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingTransaction() {
    return const CircularProgressIndicator();
  }
}
