import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../localizations/custom_localizations.dart';
import '../../storage/storage.dart';
import '../../utils/constants/constants.dart';
import '../../utils/show_snarkbar_message.dart';
import '../account/connect_metamask_command.dart';
import '../base_command.dart';

class ChangeRouteCommand extends BaseCommand {
  Future<bool> execute(String route) async {
    if (route == playersRoute && !appModel.connected) {
      await ConnectMetamaskCommand().execute();
      if (!appModel.connected) {
        showSnackbarMessage(
            text: CustomLocalizations.of(GetIt.I.get<BuildContext>())
                .networkErrorMessage);
        return false;
      }
    }

    appModel.currentRoute = route;
    final storage = GetIt.I.get<Storage>();
    await storage.save('currentRoute', route);

    appModel.navigatorKey.currentState!.pushReplacementNamed(route);
    return true;
  }
}
