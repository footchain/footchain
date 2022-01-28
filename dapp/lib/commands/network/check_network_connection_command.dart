import 'package:flutter_web3/flutter_web3.dart';

import '../../commands/base_command.dart';
import '../../utils/constants.dart';

class CheckNetworkConnectionCommand extends BaseCommand {
  Future<bool> execute() async {
    var currentChain = await ethereum!.getChainId();
    return appModel.connected && currentChain != Constants.chainId;
  }
}
