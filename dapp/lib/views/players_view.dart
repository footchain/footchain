import 'package:flutter/material.dart';

import '../dto/character_dto.dart';
import '../enuns/rarities.dart';
import '../widgets/widgets.dart';

class PlayersView extends StatelessWidget {
  const PlayersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseTemplate(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Wrap(
                spacing: 32,
                runSpacing: 32,
                children: [
                  CharacterCardWidget(
                    character: Character()..rarity = Rarities.common,
                  ),
                  CharacterCardWidget(
                    character: Character()..rarity = Rarities.unusual,
                  ),
                  CharacterCardWidget(
                    character: Character()..rarity = Rarities.rare,
                  ),
                  CharacterCardWidget(
                    character: Character()..rarity = Rarities.phenomenon,
                  ),
                  CharacterCardWidget(
                    character: Character()..rarity = Rarities.legendary,
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
