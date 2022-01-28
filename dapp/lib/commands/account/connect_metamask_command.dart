import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get_it/get_it.dart';

import '../../localizations/localizations.dart';
import '../../storage/storage.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../base_command.dart';
import 'set_current_account_command.dart';

class ConnectMetamaskCommand extends BaseCommand {
  Future<void> execute() async {
    try {
      if (appModel.networkEnabled) {
        var currentChain = await ethereum!.getChainId();

        if (currentChain != Constants.chainId) {
          try {
            await ethereum!.walletSwitchChain(Constants.chainId);
          } catch (e) {
            if (e.toString().contains('4902')) {
              try {
                await ethereum!.walletAddChain(
                  chainId: Constants.chainId,
                  chainName: Constants.chainName,
                  nativeCurrency: Constants.nativeCurrency,
                  rpcUrls: Constants.rpcUrls,
                  blockExplorerUrls: Constants.blockExplorerUrls,
                );
              } catch (e) {
                showSnackbarMessage(
                    text: CustomLocalizations.of(GetIt.I.get<BuildContext>())
                        .networkErrorMessage);
              }
            }
          }
        }

        await Future.delayed(const Duration(seconds: 3));

        currentChain = await ethereum!.getChainId();
        if (currentChain != Constants.chainId) {
          showSnackbarMessage(
              text: CustomLocalizations.of(GetIt.I.get<BuildContext>())
                  .networkErrorMessage);
          return;
        }

        final accs = await ethereum!.requestAccount();
        if (accs.isNotEmpty) {
          final storage = GetIt.I.get<Storage>();
          storage.save('user', accs.first);
          SetCurrentAccountCommand().execute(accs.first);
        }
      } else {
        showSnackbarMessage(
            text: CustomLocalizations.of(GetIt.I.get<BuildContext>())
                .networkErrorMessage);
      }
    } on Exception catch (_) {}
  }
}
