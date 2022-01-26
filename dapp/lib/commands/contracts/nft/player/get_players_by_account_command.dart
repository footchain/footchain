import '../../../base_command.dart';

class GetPlayersByAccountCommand extends BaseCommand {
  Future<List<String>> execute() async {
    final balance = await appModel.nftContract!
        .call<BigInt>("balanceOf", [appModel.user!.address]);

    try {
      List<String> tokenIds = [];
      for (var i = 0; i < balance.toInt(); i++) {
        final tokenId = await appModel.nftContract!
            .call<BigInt>("tokenOfOwnerByIndex", [appModel.user!.address, i]);

        final uri = await appModel.nftContract!.call("tokenURI", [tokenId]);
        tokenIds.add(uri);
      }
      return tokenIds;
    } catch (e) {
      return [];
    }
  }
}
