import 'dart:math' as math;

double calculateSize({
  required double currentValue,
  double maxValue = double.infinity,
  double minValue = 0,
}) {
  return math.min(math.max(minValue, currentValue), maxValue);
}
