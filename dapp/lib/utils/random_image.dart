import 'dart:math';

import 'package:flutter/material.dart';

Image randomImage(List<String> assets) {
  return Image.asset(assets[Random().nextInt(assets.length)]);
}
