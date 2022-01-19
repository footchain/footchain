import 'package:flutter/material.dart';

import '../enums/rarities.dart';
import 'constants/constants.dart';

Color colorByRarity(String? rarity) {
  if (rarity == Rarities.common.name) {
    return colorCommon;
  }
  if (rarity == Rarities.unusual.name) {
    return colorUnusual;
  }
  if (rarity == Rarities.rare.name) {
    return colorRare;
  }
  if (rarity == Rarities.phenomenon.name) {
    return colorPhenomenon;
  }
  if (rarity == Rarities.legendary.name) {
    return colorLegendary;
  }
  return colorCommon;
}
