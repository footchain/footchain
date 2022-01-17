import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../commands/navigation/change_route_command.dart';
import '../models/app_model.dart';

class ChangeRouteButtonWidget extends StatelessWidget {
  final Function? onPressed;
  final String? route;
  final String label;

  ChangeRouteButtonWidget({
    Key? key,
    this.onPressed,
    this.route,
    required this.label,
  }) : super(key: key);

  final _styleDefault = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );

  final _styleSelected = TextStyle(
    color: Colors.red.shade500,
    fontWeight: FontWeight.w900,
    fontSize: 28,
    shadows: const [
      BoxShadow(offset: Offset(1, 1), color: Colors.black38, blurRadius: 1)
    ],
  );

  _onTap() {
    if (route != null) {
      ChangeRouteCommand().execute(route!);
    }
    if (onPressed != null) {
      onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      child: FittedBox(
        child: Text(label),
      ),
      builder: (context, appModel, child) {
        return TextButton(
          onPressed: (route != null || onPressed != null) ? _onTap : null,
          child: AnimatedDefaultTextStyle(
            child: child!,
            style:
                appModel.currentRoute == route ? _styleSelected : _styleDefault,
            duration: const Duration(milliseconds: 200),
          ),
        );
      },
    );
  }
}
