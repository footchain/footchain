import 'package:dapp/commands/base_command.dart';
import 'package:dapp/commands/contracts/airdrop/load_airdrop_command.dart';
import 'package:dapp/commands/contracts/marketplace/load_marketplace_contract_command.dart';
import 'package:dapp/commands/contracts/nft/player/load_player_contract_command.dart';
import 'package:dapp/commands/contracts/token/load_token_command.dart';
import 'package:dapp/commands/training/load_training_contract_command.dart';

class LoadContractsCommand extends BaseCommand {
  Future execute(provider) async {
    await LoadTokenCommand().execute(provider);
    await LoadPlayerContractCommand().execute(provider);
    await LoadAirdropCommand().execute(provider);
    await LoadMarketplaceContractCommand().execute(provider);
    await LoadTrainingContractCommand().execute(provider);
  }
}
