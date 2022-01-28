import 'package:get_it/get_it.dart';

import '../commands/base_command.dart';
import '../storage/storage.dart';
import 'account/connect_metamask_command.dart';
import 'contracts/load_contracts_command.dart';

class InitAppCommand extends BaseCommand {
  Future<void> execute(provider) async {
    await Future.delayed(const Duration(seconds: 1));
    await LoadContractsCommand().execute(provider);

    final storage = GetIt.I.get<Storage>();
    final user = await storage.read('user');
    await ConnectMetamaskCommand().execute();
  }
}
