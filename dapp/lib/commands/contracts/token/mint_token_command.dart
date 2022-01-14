import 'package:dapp/commands/base_command.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MintTokenCommand extends BaseCommand {
  Future<TransactionResponse> execute() async {
    final amount = EthUtils.parseEther("1");
    final tx = await appModel.tokenContract!.send("mint", [amount]);
    return tx;
  }
}
