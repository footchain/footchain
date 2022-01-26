import 'package:flutter_web3/flutter_web3.dart';

import '../../../base_command.dart';

class PlayerGenerateMetadataCommand extends BaseCommand {
  Future<String> execute(BigInt tokenId) async {
    try {
      var signature =
          await provider!.getSigner().signMessage("generateMetadata$tokenId");
      return await nftService.postCharacterGenerateMetadata(tokenId, signature);
    } catch (e) {
      return '';
    }
  }
}
