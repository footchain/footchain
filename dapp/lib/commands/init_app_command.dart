import 'package:get_it/get_it.dart';

import '../commands/base_command.dart';
import '../storage/storage.dart';
import 'account/connect_metamask_command.dart';
import 'account/set_current_account_command.dart';
import 'contracts/load_contracts_command.dart';

class InitAppCommand extends BaseCommand {
  Future<void> execute(provider, String account) async {
    await Future.delayed(const Duration(seconds: 1));
    await LoadContractsCommand().execute(provider);
    await SetCurrentAccountCommand().execute(account);

    final storage = GetIt.I.get<Storage>();
    final user = await storage.read('user');
    if (user != null) {
      ConnectMetamaskCommand().execute();
    }
  }
}
