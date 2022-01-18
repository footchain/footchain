import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get_it/get_it.dart';

import '../../dto/user_dto.dart';
import '../../localizations/localizations.dart';
import '../../storage/storage.dart';
import '../../utils/utils.dart';
import '../base_command.dart';

class ConnectMetamaskCommand extends BaseCommand {
  Future<void> execute() async {
    try {
      if (appModel.networkEnabled) {
        final accs = await ethereum!.requestAccount();
        if (accs.isNotEmpty) {
          UserDto userDto = UserDto();
          userDto.address = accs.first;
          appModel.user = userDto;
          final storage = GetIt.I.get<Storage>();
          storage.save('user', userDto.address);
        }
      } else {
        showSnackbarMessage(
            text: CustomLocalizations.of(GetIt.I.get<BuildContext>())
                .networkErrorMessage);
      }
    } on Exception catch (_) {}
  }
}
