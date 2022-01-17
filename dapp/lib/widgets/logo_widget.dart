import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          boxShadow,
          BoxShadow(color: Colors.white30, blurRadius: 50, spreadRadius: 5),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(75),
          bottomRight: Radius.circular(75),
        ),
        border: Border.all(width: 7),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red,
            Colors.black,
            Colors.red,
            Colors.black,
            Colors.red
          ],
        ),
      ),
      alignment: Alignment.topCenter,
      padding: MediaQuery.of(context).size.width > 620
          ? const EdgeInsets.only(top: 20)
          : const EdgeInsets.only(top: 5),
      margin: MediaQuery.of(context).size.width > 620
          ? const EdgeInsets.only(left: 16)
          : const EdgeInsets.only(left: 16, top: 40),
      width: MediaQuery.of(context).size.width > 620 ? 130 : 65,
      height: MediaQuery.of(context).size.width > 620 ? 150 : 75,
      child: Column(
        children: const [
          FittedBox(
            child: Text(
              'Crypto',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 15,
                      spreadRadius: 0,
                      blurStyle: BlurStyle.outer),
                  BoxShadow(
                      color: Colors.white, blurRadius: 2, spreadRadius: 5),
                ],
              ),
            ),
          ),
          FittedBox(
            child: Text(
              'Foot',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 15,
                      spreadRadius: 0,
                      blurStyle: BlurStyle.outer),
                  BoxShadow(
                      color: Colors.white, blurRadius: 2, spreadRadius: 5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
