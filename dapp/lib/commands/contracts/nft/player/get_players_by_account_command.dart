import 'package:dapp/commands/base_command.dart';

class GetPlayersByAccountCommand extends BaseCommand {
  Future<List<BigInt>> execute() async {
    final balance = await appModel.nftContract!
        .call<BigInt>("balanceOf", [appModel.currentAccount!]);

    List<BigInt> tokenIds = [];
    final listSize = balance.toInt() - 1;
    print(listSize);
    for (var i = 0; i < balance.toInt(); i++) {
      final tokenId = await appModel.nftContract!
          .call<BigInt>("tokenOfOwnerByIndex", [appModel.currentAccount, i]);
      tokenIds.add(tokenId);
    }

    return tokenIds;
  }
}
