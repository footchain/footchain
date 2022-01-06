import '../base_command.dart';

class SetCurrentAccountCommand extends BaseCommand {
  Future execute(String currentAccount) async {
    appModel.currentAccount = currentAccount;
  }
}
