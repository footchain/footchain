import 'package:flutter/material.dart';

import '../localizations/custom_localizations.dart';
import '../utils/utils.dart';

class RoadmapPoint {
  final String title;
  final List<String> items;

  RoadmapPoint({required this.title, required this.items});
}

class RoadmapView extends StatefulWidget {
  const RoadmapView({Key? key}) : super(key: key);

  @override
  State<RoadmapView> createState() => _RoadmapViewState();
}

class _RoadmapViewState extends State<RoadmapView>
    with SingleTickerProviderStateMixin {
  late AnimationController roadmapAnimation;

  late List<RoadmapPoint> roadmapPoints;

  @override
  void initState() {
    super.initState();
    roadmapAnimation = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    roadmapAnimation.forward();
  }

  Widget roadmapItem(RoadmapPoint roadmapPoint, int length) {
    final double pointWidth = calculateSize(
        currentValue: maxPageWidth(context) / length - 16, minValue: 150);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.tight(Size(pointWidth, pointWidth)),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topRight: Radius.circular(10),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              border:
                  Border(left: BorderSide(width: 10, color: Colors.black45)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roadmapPoint.title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 620 ? 24 : 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 150, child: Divider()),
                ...roadmapPoint.items
                    .map(
                      (i) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              i,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width > 620
                                        ? 16
                                        : 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    roadmapPoints = [
      RoadmapPoint(
        title: CustomLocalizations.of(context).roadmapTitle1,
        items: [
          CustomLocalizations.of(context).roadmapMessage1,
        ],
      ),
      RoadmapPoint(
        title: CustomLocalizations.of(context).roadmapTitle2,
        items: [
          CustomLocalizations.of(context).roadmapMessage2,
        ],
      ),
      RoadmapPoint(
        title: CustomLocalizations.of(context).roadmapTitle3,
        items: [
          CustomLocalizations.of(context).roadmapMessage3,
        ],
      ),
      RoadmapPoint(
        title: CustomLocalizations.of(context).roadmapTitle4,
        items: [
          CustomLocalizations.of(context).roadmapMessage4,
        ],
      ),
    ];

    return Container(
        alignment: Alignment.center,
        width: maxPageWidth(context),
        child: Wrap(
          runAlignment: WrapAlignment.center,
          children: roadmapPoints
              .map<Widget>(
                (RoadmapPoint roadmapPoint) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    roadmapItem(roadmapPoint, roadmapPoints.length),
                  ],
                ),
              )
              .toList(),
        ));
  }
}
