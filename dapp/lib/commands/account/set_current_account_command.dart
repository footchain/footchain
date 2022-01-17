import '../../dto/user_dto.dart';
import '../base_command.dart';

class SetCurrentAccountCommand extends BaseCommand {
  Future execute(String currentAccount) async {
    if (appModel.user == null) {
      var user = UserDto();
      user.address = currentAccount;
      appModel.user = user;
    } else {
      appModel.user!.address = currentAccount;
    }
  }
}
