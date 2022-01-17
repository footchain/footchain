import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../dto/character_dto.dart';
import '../localizations/cpf_localizations.dart';
import '../utils/color_by_rarity.dart';
import '../utils/constants/constants.dart';
import 'widgets.dart';

class CharacterCardWidget extends StatelessWidget {
  final Character? character;
  const CharacterCardWidget({Key? key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colorByRarity(character?.rarity), width: 5),
        borderRadius: borderRadiusAll,
        boxShadow: const [boxShadow],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            child: Text(
              '#numero',
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            child: Text(
              'Nome',
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 162,
            child: Center(
              child: Container(
                  alignment: Alignment.center,
                  height: 130,
                  child: const RandomPlayerWidget()),
            ),
          ),
          SizedBox(
            height: 25,
            child: Center(
              child: Text(
                character != null ? character!.rarity.name.toUpperCase() : '',
                style: TextStyle(
                    fontSize: 13, color: colorByRarity(character?.rarity)),
              ),
            ),
          ),
          SizedBox(
            height: 25,
            child: Center(
              child: Row(
                children: [
                  const Text(
                    'Nivel: 1',
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: borderRadiusAll,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 25,
                            child: Container(
                              width: 10,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: colorPrimary,
                                borderRadius: borderRadiusAll,
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 75,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: colorByRarity(character?.rarity))),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '🔥',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    FittedBox(
                      child: Text(
                        '100',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '🛡️',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    FittedBox(
                      child: Text(
                        '100',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '🤫',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    FittedBox(
                      child: Text(
                        '100',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '🕴️',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    FittedBox(
                      child: Text(
                        '100',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      '🦶',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
                    FittedBox(
                      child: Text(
                        '100',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: colorByRarity(character?.rarity))),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      '🗻',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 5),
                    Text('100'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      '👣 ',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 5),
                    Text('100'),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      '🚶‍♂️ ',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(width: 5),
                    Text('100')
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    CpfLocalizations.of(context).startTrainingButton,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.list)),
            ],
          ),
        ],
      ),
    );
  }
}
