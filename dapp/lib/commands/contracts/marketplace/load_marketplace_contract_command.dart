import 'package:dapp/commands/base_command.dart';
import 'package:dapp/contracts/MercadoV1Contract.dart';
import 'package:dapp/contracts/PlayerContract.dart';
import 'package:dapp/utils/constants.dart';
import 'package:flutter_web3/flutter_web3.dart';

class LoadMarketplaceContractCommand extends BaseCommand {
  Future execute(provider) async {
    appModel.marketplaceContract = Contract(Constants.marketplaceAddress,
        MercadoV1Contract.abi, provider!.getSigner());
  }
}
