import 'package:dapp/commands/base_command.dart';
import 'package:dapp/contracts/AirdropContract.dart';
import 'package:dapp/utils/constants.dart';
import 'package:flutter_web3/flutter_web3.dart';

class LoadAirdropCommand extends BaseCommand {
  Future execute(provider) async {
    appModel.airdropContract = Contract(
        Constants.airdropAddress, AirdropContract.abi, provider.getSigner());
  }
}
