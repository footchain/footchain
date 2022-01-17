import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import '../utils/max_page_width.dart';

class BaseTemplate extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const BaseTemplate({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: maxPageWidth(context),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: backgroundColor != Colors.transparent ? [boxShadow] : [],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        width: maxPageWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2,
                      bottom: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: child,
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
