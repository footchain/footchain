import '../../../base_command.dart';

class GetPlayerUriByIdCommand extends BaseCommand {
  Future<String> execute(BigInt tokenId) async {
    try {
      return await appModel.nftContract!.call("tokenURI", [tokenId]);
    } catch (e) {
      return '';
    }
  }
}
