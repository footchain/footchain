import 'package:dapp/commands/base_command.dart';

class GetTokenBalanceCommand extends BaseCommand {
  Future<BigInt> execute(String currentAccount) async {
    return await appModel.tokenContract!
        .call<BigInt>("balanceOf", [currentAccount]);
  }
}
