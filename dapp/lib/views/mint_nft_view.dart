import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import '../commands/contracts/marketplace/buy_nft_command.dart';
import '../commands/contracts/token/approve_command.dart';
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
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 18),
                          blurRadius: 32,
                          color: const Color(0xFFD0D2DA).withOpacity(0.15))
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Player NFT",
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
                            final resultApprove =
                                await ApproveCommand().execute();
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
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Buy",
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

  Widget _buildProcessingTransaction() => const CircularProgressIndicator();
}
