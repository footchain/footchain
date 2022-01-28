import 'package:flutter_web3/flutter_web3.dart';
import '../base_command.dart';

class AddNetworkCommand extends BaseCommand {
  Future execute() async {
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

    await ethereum!.walletAddChain(
      chainId: chainId,
      chainName: chainName,
      nativeCurrency: nativeCurrency,
      rpcUrls: rpcUrls,
      blockExplorerUrls: blockExplorerUrls,
    );
  }
}
