import 'package:flutter/material.dart';

import '../enuns/rarities.dart';
import 'constants/constants.dart';

Color colorByRarity(Rarities? rarity) {
  switch (rarity) {
    case Rarities.common:
      return colorCommon;
    case Rarities.unusual:
      return colorUnusual;
    case Rarities.rare:
      return colorRare;
    case Rarities.phenomenon:
      return colorPhenomenon;
    case Rarities.legendary:
      return colorLegendary;
    default:
      return colorCommon;
  }
}
