import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../commands/account/connect_metamask_command.dart';
import '../localizations/localizations.dart';
import '../utils/constants/constants.dart';

class ConnectButtonWidget extends StatelessWidget {
  ConnectButtonWidget({Key? key}) : super(key: key);

  final Widget svg = SvgPicture.asset(
    'assets/images/metamask-fox.svg',
    semanticsLabel: 'Metamask logo',
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ConnectMetamaskCommand().execute();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        constraints: const BoxConstraints(minWidth: 240, maxWidth: 240),
        decoration: const BoxDecoration(
          color: Color(0xFFFFAA24),
          borderRadius: borderRadiusAll,
          boxShadow: [
            boxShadow,
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svg,
            Text(
              CustomLocalizations.of(context).connectAccountButton,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
