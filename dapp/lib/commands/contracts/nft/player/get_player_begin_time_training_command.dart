import '../../../base_command.dart';

class GetPlayerBeginTimeTrainingCommand extends BaseCommand {
  Future<BigInt> execute(BigInt tokenId) async {
    try {
      return await appModel.treinoContract!
          .call("getPlayerBeginTimeTraining", [tokenId]);
    } catch (e) {
      return BigInt.zero;
    }
  }
}
