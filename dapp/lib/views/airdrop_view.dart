import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import '../commands/account/connect_metamask_command.dart';
import '../commands/airdrop/request_aidrop_command.dart';
import '../commands/network/check_network_connection_command.dart';
import '../localizations/localizations.dart';
import '../widgets/token_copy_widget.dart';
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
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    CustomLocalizations.of(context).airdropMessage1,
                    style: _subTitleStyle(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(CustomLocalizations.of(context).airdropMessage2,
                      style: _subTitleStyle()),
                  const SizedBox(
                    height: 24,
                  ),
                  if (!_executingTransaction) _requestAirdropButton(context),
                  const SizedBox(
                    height: 24,
                  ),
                  if (_executingTransaction) _buildProcessingTransaction(),
                  TransactionResultWidget(
                    txHash: _transactionHash,
                    errorMessage: _errorMessage,
                  ),
                  const TokenCopyWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _requestAirdropButton(BuildContext context) => ElevatedButton(
      onPressed: () async {
        final connected = await CheckNetworkConnectionCommand().execute();
        if (connected) {
          String token =
              await GRecaptchaV3.execute('submit') ?? 'null returned';
          try {
            setState(() {
              _executingTransaction = true;
              _transactionHash = "";
            });
            final result = await RequestAirDropCommand().execute(token);
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
          } on Exception catch (_) {}
        } else {
          await ConnectMetamaskCommand().execute();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(CustomLocalizations.of(context).requestAirdropButton,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ));

  TextStyle _subTitleStyle() => const TextStyle(fontSize: 24);

  Widget _buildProcessingTransaction() {
    return const CircularProgressIndicator();
  }
}
