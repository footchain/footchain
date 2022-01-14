import 'dart:convert';

import 'package:dapp/commands/base_command.dart';
import 'package:flutter_web3/flutter_web3.dart';

class RequestAirDropCommand extends BaseCommand {
  Future<String?> execute(String token) async {
    //chamar o serviço que retorna a assinatura digital do owner do contrato de airdrop
    final result =
        await airdropService.postRequest(token, appModel.currentAccount!);
    if (result != null) {
      final amount = EthUtils.parseEther("1");
      final tx = await appModel.airdropContract!.send("claimTokens",
          [appModel.currentAccount!, amount, result.v, result.r, result.s]);
      await tx.wait();
      return tx.hash;
    }
  }
}
