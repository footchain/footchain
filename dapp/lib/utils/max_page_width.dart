import 'package:flutter/material.dart';

import 'calculate_size.dart';

double maxPageWidth(BuildContext context, {double maxValue = 1280}) {
  return calculateSize(
      currentValue: MediaQuery.of(context).size.width, maxValue: maxValue);
}
