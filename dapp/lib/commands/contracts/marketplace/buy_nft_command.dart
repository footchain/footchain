import 'package:dapp/commands/base_command.dart';

class BuyNftCommand extends BaseCommand {
  Future<String?> execute() async {
    final tx = await appModel.marketplacePlayerV1Contract!.send("buyNFT", []);
    await tx.wait();
    return tx.hash;
  }
}
