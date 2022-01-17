import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class SoccerFieldWidget extends StatelessWidget {
  const SoccerFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorPrimary,
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          tileMode: TileMode.repeated,
          stops: List.generate(20, (index) => index / 20),
          colors: List.generate(
              20,
              (index) => index % 2 == 0
                  ? colorPrimary.withOpacity(0.8)
                  : colorPrimary).toList(),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            area(context),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 0,
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: Colors.white, width: 2))),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height * (4 / 16),
                        height: MediaQuery.of(context).size.height * (4 / 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              MediaQuery.of(context).size.height * (4 / 16),
                            ),
                          ),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 0,
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: Colors.white, width: 2))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: area(context),
            )
          ],
        ),
      ),
    );
  }

  Widget area(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white, width: 2),
              right: BorderSide(color: Colors.white, width: 2),
              bottom: BorderSide(color: Colors.white, width: 2),
            ),
          ),
          width: MediaQuery.of(context).size.width * (3 / 20),
          height: MediaQuery.of(context).size.height * (10 / 16),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white, width: 2),
                right: BorderSide(color: Colors.white, width: 2),
                bottom: BorderSide(color: Colors.white, width: 2),
              ),
            ),
            width: MediaQuery.of(context).size.width * (1 / 20),
            height: MediaQuery.of(context).size.height * (4 / 16),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * (1 / 20),
          height: MediaQuery.of(context).size.height * (3.5 / 16),
          child: CustomPaint(
            painter: SemiCircle(),
          ),
        ),
      ],
    );
  }
}

class SemiCircle extends CustomPainter {
  final double strokeWidth;
  final StrokeCap strokeCap;

  SemiCircle({this.strokeCap = StrokeCap.square, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width, size.height / 2, 0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
