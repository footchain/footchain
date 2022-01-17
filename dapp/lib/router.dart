import 'package:flutter/material.dart';

import 'utils/constants/routes.dart';
import 'views/airdrop_view.dart';
import 'views/how_to_play_view.dart';
import 'views/mint_nft_view.dart';
import 'views/players_view.dart';
import 'views/roadmap_view.dart';
import 'views/start_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case playersRoute:
      return _getPageRoute(const PlayersView(), settings);
    case airdropRoute:
      return _getPageRoute(const AirdropView(), settings);
    case startRoute:
      return _getPageRoute(const StartView(), settings);
    case howToPlayRoute:
      return _getPageRoute(const HowToPlayView(), settings);
    case roadmapRoute:
      return _getPageRoute(const RoadmapView(), settings);
    case mintNft:
      return _getPageRoute(const MintNftView(), settings);
    default:
      return _getPageRoute(const StartView(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(
    child: child,
    routeName: settings.name ?? 'no_name',
  );
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute({required this.child, required String routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
