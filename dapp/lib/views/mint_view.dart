import 'package:dapp/commands/contracts/token/mint_token_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MintView extends StatefulWidget {
  const MintView({Key? key}) : super(key: key);

  @override
  _MintViewState createState() => _MintViewState();
}

class _MintViewState extends State<MintView> {
  bool _loadingTransaction = false;
  TransactionResponse? _tx;
  void _processTransaction(TransactionResponse tx) {
    setState(() {
      _loadingTransaction = true;
      _tx = tx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Mint Token",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final tx = await MintTokenCommand().execute();
                      _processTransaction(tx);
                    },
                    child: const Text("Go!")),
                if (_loadingTransaction) ..._buildTransactionArea()
              ],
            ),
          ),
        ));
  }

  List<Widget> _buildTransactionArea() {
    final List<Widget> widgets = [];
    widgets.add(SizedBox(height: 24));
    widgets.add(FutureBuilder<TransactionReceipt>(
      future: _tx!.wait(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        } else {
          return Text("Transaction Finished ${snapshot.data!.transactionHash}");
        }
      },
    ));
    return widgets;
  }
}
