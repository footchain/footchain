import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import '../commands/contracts/marketplace/buy_nft_command.dart';
import '../commands/contracts/token/approve_command.dart';
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(CustomLocalizations.of(context).mintTitle1),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(CustomLocalizations.of(context).mintTitle2),
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
    String token = await GRecaptchaV3.execute('submit') ?? 'null returned';
    try {
      setState(() {
        _executingTransaction = true;
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
    }
  }

  List<Widget> _buildTransactionArea() {
    final List<Widget> widgets = [];
    widgets.add(const SizedBox(height: 24));
    widgets.add(FutureBuilder<TransactionReceipt>(
      future: _tx!.wait(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        } else {
          return Text("Transaction Finished ${snapshot.data!.transactionHash}");
        }
      },
    ));
    return widgets;
  }

  Widget _buildHowToOpenBox() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.yellow[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.yellow, width: 3)),
        child: Text(
            "A box poderá ser aberta na tela de Personagens. Menu: Jogar => Personagens"),
      );

  Widget _buildProcessingTransaction() => const CircularProgressIndicator();
}
