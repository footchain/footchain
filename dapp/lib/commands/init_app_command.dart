import 'package:dapp/commands/account/set_current_account_command.dart';
import 'package:dapp/commands/contracts/load_contracts_command.dart';

import '../commands/base_command.dart';

class InitAppCommand extends BaseCommand {
  Future<void> execute(provider, String account) async {
    await Future.delayed(const Duration(seconds: 1));
    await LoadContractsCommand().execute(provider);
    await SetCurrentAccountCommand().execute(account);
  }
}
