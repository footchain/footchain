import 'package:dapp/localizations/localizations.dart';
import 'package:dapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:url_launcher/url_launcher.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Airdrop FTC",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(CustomLocalizations.of(context).airdropMessage1),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(CustomLocalizations.of(context).airdropMessage2),
                  const SizedBox(
                    height: 24,
                  ),
                  if (!_executingTransaction)
                    ElevatedButton(
                        onPressed: () async {
                          String token = await GRecaptchaV3.execute('submit') ??
                              'null returned';
                          try {
                            setState(() {
                              _executingTransaction = true;
                              _transactionHash = "";
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
                          } on Exception catch (e) {}
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              CustomLocalizations.of(context)
                                  .requestAirdropButton,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        )),
                  const SizedBox(
                    height: 24,
                  ),
                  if (_executingTransaction) _buildProcessingTransaction(),
                  if (_transactionHash != "")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          CustomLocalizations.of(context)
                              .airdropTransactionResult,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => launch(
                                Constants.explorerUriTx + _transactionHash),
                            child: Text(_transactionHash,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                )),
                          ),
                        ),
                      ],
                    ),
                  if (_errorMessage != "")
                    Text(
                      _errorMessage.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold),
                    )
                ],
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
