import 'package:dapp/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localizations/localizations.dart';
import 'package:flutter/material.dart';

class TransactionResultWidget extends StatelessWidget {
  final String? txHash;
  final String? errorMessage;
  const TransactionResultWidget({Key? key, this.txHash, this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (txHash != null && txHash != "")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(
                CustomLocalizations.of(context).transaction,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => launch(Constants.explorerUriTx + txHash!),
                  child: Text(txHash!,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                ),
              ),
            ],
          ),
        if (errorMessage != null)
          Text(
            errorMessage!.toUpperCase(),
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold),
          ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}
