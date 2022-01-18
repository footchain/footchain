import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../localizations/custom_localizations.dart';
import '../models/app_model.dart';
import '../utils/constants/constants.dart';
import 'change_route_button_widget.dart';

class ItensMenu extends StatelessWidget {
  final bool inDrawer;
  const ItensMenu({Key? key, this.inDrawer = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ChangeRouteButtonWidget(
              route: playersRoute,
              label: CustomLocalizations.of(context).startButton,
              onPressed: () => closeDrawer(context),
            ),
            const SizedBox(height: 16),
            ChangeRouteButtonWidget(
              route: airdropRoute,
              label: 'Airdrop',
              onPressed: () => closeDrawer(context),
            ),
            const SizedBox(height: 16),
            ChangeRouteButtonWidget(
              route: mintNft,
              label: 'Mint NFT',
              onPressed: () => closeDrawer(context),
            ),
            const SizedBox(height: 16),
            ChangeRouteButtonWidget(
              route: howToPlayRoute,
              label: CustomLocalizations.of(context).howToPlayButton,
              onPressed: () => closeDrawer(context),
            ),
            const SizedBox(height: 16),
            ChangeRouteButtonWidget(
              route: roadmapRoute,
              label: CustomLocalizations.of(context).roadmapButton,
              onPressed: () => closeDrawer(context),
            ),
            const SizedBox(height: 16),
            ChangeRouteButtonWidget(
              label: CustomLocalizations.of(context).whitepaperButton,
              onPressed: () {
                launch('https://mattheus-pirovani.gitbook.io/whitepaper/');
                closeDrawer(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  closeDrawer(BuildContext context) {
    if (inDrawer) {
      Navigator.of(context).pop();
    }
  }
}
