import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import '../commands/contracts/nft/player/get_player_detail_command.dart';
import '../commands/contracts/nft/player/get_player_uri_by_id_command.dart';
import '../commands/contracts/nft/player/player_generate_metadata_command.dart';
import '../commands/training/player/finish_training_command.dart';
import '../commands/training/player/start_training_command.dart';
import '../dto/character_dto.dart';
import '../localizations/custom_localizations.dart';
import '../utils/constants/constants.dart';
import '../utils/get_character_image.dart';
import '../utils/utils.dart';

class CharacterCardWidget extends StatefulWidget {
  final String token;

  const CharacterCardWidget({Key? key, required this.token}) : super(key: key);

  @override
  State<CharacterCardWidget> createState() => _CharacterCardWidgetState();
}

class _CharacterCardWidgetState extends State<CharacterCardWidget> {
  var _executingTransaction = false;
  var _executingMint = false;
  var _inTraining = false;
  late String _tokenUri;
  BigInt? _tokenId;

  @override
  void initState() {
    super.initState();
    _tokenUri = widget.token.replaceFirst('ipfs://', '');
    _tokenId = BigInt.tryParse(_tokenUri);
  }

  void _generateMetadata() async {
    setState(() {
      _executingMint = true;
    });
    var txHash = await PlayerGenerateMetadataCommand().execute(_tokenId!);

    if (txHash.isNotEmpty) {
      showSnackbarMessage(text: txHash);
      await provider!.waitForTransaction(txHash);
      var uri = await GetPlayerUriByIdCommand().execute(_tokenId!);
      if (uri.isNotEmpty) {
        setState(() {
          _tokenUri = uri.replaceFirst('ipfs://', '');
          _tokenId = null;
        });
      }
    } else {
      showSnackbarMessage(
          text: CustomLocalizations.of(context).genericErrorMessage);
    }

    setState(() {
      _executingMint = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_executingMint) {
      return const SizedBox(
        width: 230,
        height: 300,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_tokenId != null) {
      return GestureDetector(
        onTap: _generateMetadata,
        child: Container(
          width: 230,
          height: 300,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 5),
            borderRadius: borderRadiusAll,
            boxShadow: const [boxShadow],
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('#$_tokenId'),
                const FaIcon(FontAwesomeIcons.futbol, size: 56),
                const SizedBox(height: 32),
                Text(
                  CustomLocalizations.of(context).openBoxButton,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return FutureBuilder<CharacterDto>(
      future: GetPlayerDetailCommand().execute(_tokenUri),
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
          width: 260,
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
                  '#$_tokenUri',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                child: Text(
                  '${character.name}',
                  style: TextStyle(
                    fontSize: 24,
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
                      fontSize: 26,
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
                        style: TextStyle(fontSize: 16),
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
                        SvgPicture.asset(
                          'assets/images/icons/attack.svg',
                          semanticsLabel: 'Metamask logo',
                          width: 24,
                          height: 24,
                        ),
                        /*const Text(
                          '🔥',
                          style: TextStyle(fontSize: 14),
                        ),*/
                        const SizedBox(width: 8),
                        FittedBox(
                          child: Text(
                            '${character.attack!.value}',
                            style: const TextStyle(fontSize: 16),
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
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /*const Text(
                          '🤫',
                          style: TextStyle(fontSize: 14),
                        ),*/
                        SvgPicture.asset(
                          'assets/images/icons/creativity.svg',
                          semanticsLabel: 'creativity icon',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        FittedBox(
                          child: Text(
                            '${character.creativity!.value}',
                            style: const TextStyle(fontSize: 16),
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
                            style: const TextStyle(fontSize: 16),
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
                            style: const TextStyle(fontSize: 16),
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
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 5),
                        Text('${character.height!.value}',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '👣 ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${character.preferredFoot}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '🚶‍♂️ ',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 5),
                        Text('${character.position}',
                            style: TextStyle(fontSize: 16))
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
              style: const TextStyle(fontSize: 20),
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
