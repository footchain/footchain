import 'package:dapp/commands/base_command.dart';
import 'package:dapp/contracts/FootchainContract.dart';
import 'package:dapp/utils/constants.dart';
import 'package:flutter_web3/flutter_web3.dart';

class LoadTokenCommand extends BaseCommand {
  Future execute(provider) async {
    appModel.tokenContract = Contract(
        Constants.footchainAddress, Footchain.abi, provider.getSigner());
  }
}
