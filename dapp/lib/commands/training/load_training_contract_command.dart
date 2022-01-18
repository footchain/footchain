import 'package:dapp/commands/base_command.dart';
import 'package:dapp/contracts/PlayerContract.dart';
import 'package:dapp/contracts/TrainingContract.dart';
import 'package:dapp/utils/constants.dart';
import 'package:flutter_web3/flutter_web3.dart';

class LoadTrainingContractCommand extends BaseCommand {
  Future execute(provider) async {
    appModel.treinoContract = Contract(Constants.playerTrainingAddress,
        TrainingContract.abi, provider!.getSigner());
  }
}
