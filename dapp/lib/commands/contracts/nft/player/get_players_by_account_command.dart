import '../../../base_command.dart';

class GetPlayersByAccountCommand extends BaseCommand {
  Future<List<BigInt>> execute() async {
    final balance = await appModel.nftContract!
        .call<BigInt>("balanceOf", [appModel.user!.address]);

    try {
      List<BigInt> tokenIds = [];
      for (var i = 0; i < balance.toInt(); i++) {
        final tokenId = await appModel.nftContract!
            .call<BigInt>("tokenOfOwnerByIndex", [appModel.user!.address, i]);
        tokenIds.add(tokenId);
      }
      return tokenIds;
    } catch (e) {
      return [];
    }
  }
}
