import 'package:dapp/commands/base_command.dart';

class BuyNftCommand extends BaseCommand {
  Future<String?> execute() async {
    final tx = await appModel.marketplaceContract!.send("buyNFT", []);
    await tx.wait();
    return tx.hash;
  }
}
