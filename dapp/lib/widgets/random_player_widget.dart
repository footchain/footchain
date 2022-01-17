import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import '../utils/random_image.dart';

class RandomPlayerWidget extends StatelessWidget {
  final Size size;

  const RandomPlayerWidget({
    Key? key,
    this.size = const Size(50, 100),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 5,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                width: 20,
                height: 1,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 100)),
                  boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 2)],
                ),
              ),
            ),
          ),
          randomImage(playerBodyImages),
          randomImage(playerJerseyImages),
          randomImage(shortsImages),
          randomImage(socksCleatsImages),
        ],
      ),
    );
  }
}
