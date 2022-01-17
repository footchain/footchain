import 'package:dapp/commands/base_command.dart';

class FinishTrainingCommand extends BaseCommand {
  Future<String> execute(tokenId) async {
    final tx = await appModel.treinoContract!.send("finish", [tokenId]);
    await tx.wait();
    return tx.hash;
  }
}
