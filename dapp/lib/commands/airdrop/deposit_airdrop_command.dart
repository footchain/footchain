import 'package:dapp/commands/base_command.dart';
import 'package:flutter_web3/flutter_web3.dart';

class DepositAirdropCommand extends BaseCommand {
  Future execute() async {
    final amount = EthUtils.parseEther("100000");
    final tx = await appModel.tokenContract!
        .send("mint", [appModel.airdropContract!.address, amount]);
    await tx.wait();
    print("------- DEPOSIT AIRDROP FINISHED -------");
  }
}
