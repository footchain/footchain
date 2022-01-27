import '../../../base_command.dart';

class GetPlayerTrainingStatusCommand extends BaseCommand {
  Future<bool> execute(BigInt tokenId) async {
    try {
      return await appModel.treinoContract!.call("getPlayerStatus", [tokenId]);
    } catch (e) {
      return false;
    }
  }
}
