import 'package:dapp/commands/base_command.dart';
import 'package:flutter_web3/ethers.dart';

class ApproveCommand extends BaseCommand {
  Future<String?> execute() async {
    final amount = EthUtils.parseEther("1");
    final tx = await appModel.tokenContract!
        .send("approve", [appModel.marketplaceContract!.address, amount]);
    await tx.wait();
    return tx.hash;
  }
}
