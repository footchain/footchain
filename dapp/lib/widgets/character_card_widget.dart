import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import '../commands/contracts/nft/player/get_player_detail_command.dart';
import '../commands/training/player/finish_training_command.dart';
import '../commands/training/player/start_training_command.dart';
import '../dto/character_dto.dart';
import '../localizations/custom_localizations.dart';
import '../utils/constants/constants.dart';
import '../utils/get_character_image.dart';
import '../utils/utils.dart';

class CharacterCardWidget extends StatefulWidget {
  final BigInt token;

  const CharacterCardWidget({Key? key, required this.token}) : super(key: key);

  @override
  State<CharacterCardWidget> createState() => _CharacterCardWidgetState();
}

class _CharacterCardWidgetState extends State<CharacterCardWidget> {
  var _executingTransaction = false;
  var _inTraining = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CharacterDto>(
      future: GetPlayerDetailCommand()
          .execute('QmYAeoiEAD1qNyJ8A9hpAN13xuj3XaJXG7q2bVjVoeGMdB'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
              width: 100, height: 100, child: CircularProgressIndicator());
        }

        if (snapshot.data == null) {
          return const Text('No content');
        }

        final CharacterDto character = snapshot.data!;

        return Container(
          width: 230,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.all(color: colorByRarity(character.rarity), width: 5),
            borderRadius: borderRadiusAll,
            boxShadow: const [boxShadow],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                child: Text(
                  '${widget.token}',
                  style: const TextStyle(fontSize: 8),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                child: Text(
                  '${character.name}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: colorByRarity(character.rarity),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 162,
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 130,
                    child: Center(
                      child: Image.network(
                        getCharacterImage(character),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
                child: Center(
                  child: Text(
                    character.rarity?.toUpperCase() ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: colorByRarity(character.rarity),
                    ),
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
                      top: BorderSide(color: colorByRarity(character.rarity))),
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '🔥',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        FittedBox(
                          child: Text(
                            '${character.attack!.value}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '🛡️',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        FittedBox(
                          child: Text(
                            '${character.defense!.value}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '🤫',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        FittedBox(
                          child: Text(
                            '${character.creativity!.value}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '🕴️',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        FittedBox(
                          child: Text(
                            '${character.tactic!.value}',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '🦶',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 8),
                        FittedBox(
                          child: Text(
                            '${character.technique!.value}',
                            style: const TextStyle(fontSize: 12),
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
                      top: BorderSide(color: colorByRarity(character.rarity))),
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '🗻',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 5),
                        Text('${character.height!.value}'),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '👣 ',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 5),
                        Text('${character.preferredFoot}'),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '🚶‍♂️ ',
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 5),
                        Text('${character.position}')
                      ],
                    ),
                  ],
                ),
              ),
              actions(),
            ],
          ),
        );
      },
    );
  }

  Widget actions() {
    var _btnStartTraining = ElevatedButton(
      child: _executingTransaction
          ? const Center(child: CircularProgressIndicator())
          : Text(
              CustomLocalizations.of(context).startTrainingButton,
              style: const TextStyle(fontSize: 14),
            ),
      onPressed: _executingTransaction
          ? null
          : () async {
              String token =
                  await GRecaptchaV3.execute('submit') ?? 'null returned';
              try {
                setState(() {
                  _executingTransaction = true;
                  _inTraining = true;
                });
                final resultApprove =
                    await StartTrainingCommand().execute(widget.token);
                setState(() {
                  showSnackbarMessage(text: resultApprove);
                  _executingTransaction = false;
                });
              } on EthereumException catch (e) {
                setState(() {
                  _executingTransaction = false;
                  showSnackbarMessage(text: e.data["message"]);
                });
              }
            },
    );

    var _btnEndTraining = ElevatedButton(
      child: _executingTransaction
          ? const Center(child: CircularProgressIndicator())
          : const Text(
              'Finish',
              style: TextStyle(fontSize: 14),
            ),
      onPressed: _executingTransaction
          ? null
          : () async {
              String token =
                  await GRecaptchaV3.execute('submit') ?? 'null returned';
              try {
                setState(() {
                  _executingTransaction = true;
                });
                final resultApprove =
                    await FinishTrainingCommand().execute(widget.token);
                setState(() {
                  showSnackbarMessage(text: resultApprove);
                  _executingTransaction = false;
                  _inTraining = false;
                });
              } on EthereumException catch (e) {
                setState(() {
                  _executingTransaction = false;
                  showSnackbarMessage(text: e.data["message"]);
                });
              }
            },
    );

    return Row(
      children: [
        Expanded(
          child: (_inTraining ? _btnEndTraining : _btnStartTraining),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.list),
        ),
      ],
    );
  }
}
