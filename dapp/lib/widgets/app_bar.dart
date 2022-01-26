import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../commands/navigation/change_route_command.dart';
import '../dto/user_dto.dart';
import '../localizations/localizations.dart';
import '../models/app_model.dart';
import '../utils/constants/constants.dart';
import '../utils/utils.dart';
import 'widgets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);

  double height = 250;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(builder: (context, appModel, child) {
      height =
          appModel.gameModeActive && MediaQuery.of(context).size.width > 620
              ? 65
              : MediaQuery.of(context).size.height * 0.2;

      return AppBar(
        automaticallyImplyLeading: false,
        actions: const <Widget>[SizedBox()],
        toolbarHeight: height,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: Stack(
          children: [
            ClipPath(
              clipper: _Customshape(appModel),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                width: MediaQuery.of(context).size.width,
                height: height,
                color: Colors.black,
                child: Stack(
                  children: [
                    const BackgroundWidget(),
                    Visibility(
                      visible: appModel.gameModeActive,
                      child: Center(child: playMenu(appModel.user, context)),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width < 620 ? 10 : 20,
                    left: 20),
                child: GestureDetector(
                  onTap: () {
                    ChangeRouteCommand().execute(startRoute);
                  },
                  child: const LogoWidget(),
                ),
              ),
            ),
          ],
        ),
        leading: const SizedBox(),
      );
    });
  }

  Widget playMenu(UserDto? user, BuildContext context) {
    final itens = [
      ChangeRouteButtonWidget(
        route: startRoute,
        label: 'Home',
      ),
      ChangeRouteButtonWidget(
        route: playersRoute,
        label: CustomLocalizations.of(context).soccerPlayersButton,
      ),
      ChangeRouteButtonWidget(
        route: null,
        label: CustomLocalizations.of(context).marketplaceButton,
        onPressed: () {
          showSnackbarMessage(
              text: CustomLocalizations.of(context).comingSoonMessage);
        },
      ),
      user != null && MediaQuery.of(context).size.width > 1030
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: WalletWidget(user: user),
            )
          : const SizedBox(),
    ];

    return MediaQuery.of(context).size.width > 1030
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: itens,
          )
        : Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Wrap(
              alignment: WrapAlignment.end,
              children: itens,
            ),
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _Customshape extends CustomClipper<Path> {
  final AppModel appModel;
  _Customshape(this.appModel);

  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = appModel.gameModeActive ? size.width : size.width / 2;
    var path = Path();
    path.lineTo(0, height);
    path.lineTo(appModel.gameModeActive ? width : 0, height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
