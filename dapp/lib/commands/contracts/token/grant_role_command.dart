import 'package:dapp/commands/base_command.dart';
import 'package:flutter_web3/ethers.dart';

class GrantRoleCommand extends BaseCommand {
  Future<String?> execute() async {
    final minterRole = EthUtils.solidityKeccak256(["string"], ["MINTER_ROLE"]);
    print(minterRole);
    final tx = await appModel.tokenContract!
        .send("grantRole", [minterRole, appModel.treinoContract!.address]);
    await tx.wait();
    return tx.hash;
  }
}
