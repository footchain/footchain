import 'package:dapp/commands/contracts/marketplace/buy_nft_command.dart';
import 'package:dapp/commands/contracts/nft/player/get_players_by_account_command.dart';
import 'package:dapp/commands/contracts/token/approve_command.dart';
import 'package:dapp/commands/training/player/start_training_command.dart';
import 'package:dapp/commands/training/player/finish_training_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({Key? key}) : super(key: key);

  @override
  _TrainingViewState createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> {
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
  List players = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadNfts();
  }

  void _loadNfts() async {
    final tokenList = await GetPlayersByAccountCommand().execute();
    setState(() {
      players = tokenList;
    });
  }

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
                    "Player NFT",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  String token =
                                      await GRecaptchaV3.execute('submit') ??
                                          'null returned';
                                  try {
                                    setState(() {
                                      _executingTransaction = true;
                                    });
                                    final resultApprove =
                                        await StartTrainingCommand()
                                            .execute(players[index]);
                                    setState(() {
                                      _transactionHash = resultApprove;
                                      _executingTransaction = false;
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
                                  child: Text(
                                      "Treinar ${players[index].toString()}",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                )),
                            ElevatedButton(
                                onPressed: () async {
                                  String token =
                                      await GRecaptchaV3.execute('submit') ??
                                          'null returned';
                                  try {
                                    setState(() {
                                      _executingTransaction = true;
                                    });
                                    final resultApprove =
                                        await FinishTrainingCommand()
                                            .execute(players[index]);
                                    setState(() {
                                      _transactionHash = resultApprove;
                                      _executingTransaction = false;
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
                                  child: Text("Finalizar Treino",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                )),
                          ],
                        );
                      },
                    ),
                  ),
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

  Widget _buildProcessingTransaction() => CircularProgressIndicator();
}
