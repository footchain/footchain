import 'package:dapp/commands/base_command.dart';

class StartTrainingCommand extends BaseCommand {
  Future<String> execute(tokenId) async {
    final tx = await appModel.treinoContract!.send("start", [tokenId]);
    await tx.wait();
    return tx.hash;
  }
}
