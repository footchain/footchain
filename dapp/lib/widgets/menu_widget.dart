import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/app_model.dart';
import '../utils/utils.dart';
import 'widgets.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppModel appModel = GetIt.I.get<AppModel>();

    return AnimatedBuilder(
      animation: appModel,
      builder: (BuildContext context, _) {
        return ClipPath(
          clipper: _CustomShape(),
          child: Container(
            width: MediaQuery.of(context).size.width > 620
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width > 620
                ? MediaQuery.of(context).size.height / 2
                : MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(color: Colors.black),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                const BackgroundWidget(),
                Positioned(
                    bottom: 80,
                    right: 16,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white38,
                            blurRadius: 150,
                            spreadRadius: 15,
                          ),
                        ],
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.only(
                    top: 90,
                    right: 16,
                    bottom: 16,
                  ),
                  width: calculateSize(
                      currentValue: MediaQuery.of(context).size.width / 3,
                      minValue: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width > 839
                                ? MediaQuery.of(context).size.width / 6
                                : 0,
                          ),
                          child: MediaQuery.of(context).size.width > 839
                              ? const FittedBox(child: ItensMenu())
                              : Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 24,
                                      right: 16,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      icon: const Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Container(
                        child: MediaQuery.of(context).size.width > 839
                            ? appModel.connected
                                ? WalletWidget(user: appModel.user!)
                                : ConnectButtonWidget()
                            : const SizedBox(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.moveTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }
}
