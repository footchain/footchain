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
              var chainId = 111; // 106
              var chainName = 'Velas Testnet'; // Velas
              var nativeCurrency = CurrencyParams(
                name: 'VelasTestnet',
                symbol: 'VLX',
                decimals: 18,
              ); // CurrencyParams(name: 'velas', symbol: 'VLX', decimals: 18);
              var rpcUrls = [
                'https://evmexplorer.testnet.velas.com/rpc'
              ]; // ['https://evmexplorer.velas.com/rpc'];
              var blockExplorerUrls = [
                'https://evmexplorer.testnet.velas.com'
              ]; // ['https://evmexplorer.velas.com'];

              try {
                await ethereum!.walletAddChain(
                  chainId: chainId,
                  chainName: chainName,
                  nativeCurrency: nativeCurrency,
                  rpcUrls: rpcUrls,
                  blockExplorerUrls: blockExplorerUrls,
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
