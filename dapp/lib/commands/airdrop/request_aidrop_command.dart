import 'package:flutter_web3/flutter_web3.dart';

import '../base_command.dart';

class RequestAirDropCommand extends BaseCommand {
  Future<String?> execute(String token) async {
    //chamar o serviço que retorna a assinatura digital do owner do contrato de airdrop
    final result =
        await airdropService.postRequest(token, appModel.user!.address!);
    if (result != null) {
      final amount = EthUtils.parseEther("10");
      final tx = await appModel.airdropContract!.send("claimTokens",
          [appModel.user!.address, amount, result.v, result.r, result.s]);
      await tx.wait();
      return tx.hash;
    }
  }
}
