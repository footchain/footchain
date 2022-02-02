import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import '../commands/contracts/marketplace/buy_nft_command.dart';
import '../commands/contracts/token/approve_command.dart';
import '../commands/account/connect_metamask_command.dart';
import '../commands/network/check_network_connection_command.dart';
import '../localizations/localizations.dart';
import '../widgets/widgets.dart';

class MintNftView extends StatefulWidget {
  const MintNftView({Key? key}) : super(key: key);

  @override
  _MintNftViewState createState() => _MintNftViewState();
}

class _MintNftViewState extends State<MintNftView> {
  bool _loadingTransaction = false;
  TransactionResponse? _tx;
  void _processTransaction(TransactionResponse tx) {
    setState(() {
      _loadingTransaction = true;
      _tx = tx;
    });
  }

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
                  Text(
                    CustomLocalizations.of(context).mintTitle,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    CustomLocalizations.of(context).mintTitle1,
                    style: _subTitleStyle(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(CustomLocalizations.of(context).mintTitle2,
                      style: _subTitleStyle()),
                  const SizedBox(
                    height: 24,
                  ),
                  if (!_executingTransaction) _buildMintButton(context),
                  const SizedBox(
                    height: 24,
                  ),
                  if (_executingTransaction) _buildProcessingTransaction(),
                  TransactionResultWidget(
                    txHash: _transactionHash,
                    errorMessage: _errorMessage,
                  ),
                  _buildHowToOpenBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildMintButton(BuildContext context) {
    return ElevatedButton(
        onPressed: _mintNft,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(CustomLocalizations.of(context).mintButton,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ));
  }

  void _mintNft() async {
    final connected = await CheckNetworkConnectionCommand().execute();
    if (connected) {
      String token = await GRecaptchaV3.execute('submit') ?? 'null returned';
      try {
        setState(() {
          _executingTransaction = true;
          _errorMessage = '';
        });
        final resultApprove = await ApproveCommand().execute();
        if (resultApprove != null) {
          final result = await BuyNftCommand().execute();
          setState(() {
            _executingTransaction = false;
            if (result != null) {
              _transactionHash = result;
            }
          });
        } else {
          setState(() {
            _executingTransaction = false;
          });
        }
      } on EthereumException catch (e) {
        setState(() {
          _executingTransaction = false;
          _errorMessage = e.data["message"];
        });
      } on Exception catch (e) {
        setState(() {
          _executingTransaction = false;
          _errorMessage = CustomLocalizations.of(context).genericErrorMessage;
        });
      }
    } else {
      await ConnectMetamaskCommand().execute();
    }
  }

  TextStyle _subTitleStyle() => TextStyle(fontSize: 24);

  Widget _buildHowToOpenBox() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.yellow[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.yellow, width: 3)),
        child: Text(
          CustomLocalizations.of(context).howtoOpenBox,
          style: TextStyle(fontSize: 20),
        ),
      );

  Widget _buildProcessingTransaction() => const CircularProgressIndicator();
}
