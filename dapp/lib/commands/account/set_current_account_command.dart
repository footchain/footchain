import 'package:dapp/commands/account/get_token_balance_command.dart';
import 'package:flutter_web3/flutter_web3.dart';

import '../../dto/user_dto.dart';
import '../base_command.dart';

class SetCurrentAccountCommand extends BaseCommand {
  Future execute(String currentAccount) async {
    try {
      final balance = await GetTokenBalanceCommand().execute(currentAccount);
      appModel.user = UserDto()
        ..address = currentAccount
        ..balance = EthUtils.formatEther(balance.toString());
    } catch (e) {}
  }
}
