import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../commands/navigation/change_route_command.dart';
import '../localizations/localizations.dart';
import '../utils/constants/constants.dart';
import '../utils/utils.dart';

class PlayButtonWidget extends StatelessWidget {
  const PlayButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          ChangeRouteCommand().execute(playersRoute);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 48),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.height * (4 / 17),
              height: MediaQuery.of(context).size.height * (4 / 17),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: -10,
                    left: -1,
                    child: FaIcon(
                      FontAwesomeIcons.solidFutbol,
                      size: calculateSize(
                          currentValue:
                              MediaQuery.of(context).size.height * (4 / 17)),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [boxShadow],
                  borderRadius: borderRadiusAll,
                ),
                child: Text(
                  CustomLocalizations.of(context).startButton,
                  style: TextStyle(
                    color: colorPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: calculateSize(
                        currentValue: MediaQuery.of(context).size.width * 0.04,
                        maxValue: 60,
                        minValue: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
