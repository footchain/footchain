import 'package:dapp/commands/base_command.dart';
import 'package:dapp/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class ConnectMetamaskCommand extends BaseCommand {
  Future<void> execute(BuildContext context) async {
    if (Ethereum.isSupported) {
      try {
        final accs = await ethereum!.requestAccount();
        print(accs);
        if (accs.isNotEmpty) {
          final chainId = await ethereum!.getChainId();
          appModel.currentAccount = accs.first;
        }
      } on Exception catch (e) {
        // TODO
        print("USUARIO CANCELOU");
      }
    }
  }
}
