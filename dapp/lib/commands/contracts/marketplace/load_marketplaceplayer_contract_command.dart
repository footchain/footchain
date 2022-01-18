import 'package:dapp/commands/base_command.dart';
import 'package:dapp/contracts/MarketplacePlayerV1Contract.dart';
import 'package:dapp/contracts/PlayerContract.dart';
import 'package:dapp/utils/constants.dart';
import 'package:flutter_web3/flutter_web3.dart';

class LoadMarketplacePlayerV1ContractCommand extends BaseCommand {
  Future execute(provider) async {
    appModel.marketplacePlayerV1Contract = Contract(
        Constants.marketplacePlayerV1Address,
        MarketplacePlayerV1Contract.abi,
        provider!.getSigner());
  }
}
