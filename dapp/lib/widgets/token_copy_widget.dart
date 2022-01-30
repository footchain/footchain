import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../localizations/custom_localizations.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class TokenCopyWidget extends StatelessWidget {
  const TokenCopyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      'assets/images/metamask-fox.svg',
      semanticsLabel: 'Metamask logo',
    );

    void _copyToken() {
      Clipboard.setData(
        const ClipboardData(text: Constants.footchainAddress),
      );
      showSnackbarMessage(text: CustomLocalizations.of(context).copiedMessage);
    }

    void _addTokenToMetamask() async {
      await ethereum!.walletWatchAssets(
        address: Constants.footchainAddress,
        symbol: Constants.footchainSymbol,
        decimals: Constants.footchainDecimals,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('\$FTC Contract Address:', style: TextStyle(fontSize: 20)),
        const SizedBox(width: 16),
        const FittedBox(
          child: Text(
            Constants.footchainAddress,
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: _copyToken,
          icon: const FaIcon(
            FontAwesomeIcons.copy,
            size: 20,
          ),
        ),
        IconButton(onPressed: _addTokenToMetamask, icon: svg)
      ],
    );
  }
}
