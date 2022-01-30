import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../commands/contracts/nft/player/get_player_begin_time_training_command.dart';
import '../commands/contracts/nft/player/get_player_detail_command.dart';
import '../commands/contracts/nft/player/get_player_training_status_command.dart';
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
  final BigInt tokenId;

  const CharacterCardWidget({Key? key, required this.tokenId})
      : super(key: key);

  @override
  State<CharacterCardWidget> createState() => _CharacterCardWidgetState();
}

class _CharacterCardWidgetState extends State<CharacterCardWidget> {
  var _executingTransaction = false;
  var _executingMint = false;
  final ValueNotifier<bool> _inTraining = ValueNotifier<bool>(false);
  String? _tokenUri;
  BigInt? _tokenIdUri;
  final thirtyMinutes = 30 * 60;
  final ValueNotifier<int> _remainingTrainingDurationInSeconds =
      ValueNotifier<int>(30 * 60);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initWidget();
  }

  void initWidget() async {
    var uri = await GetPlayerUriByIdCommand().execute(widget.tokenId);
    setState(() {
      _tokenUri = uri.replaceFirst('ipfs://', '');
      _tokenIdUri = BigInt.tryParse(_tokenUri!);
    });
    if (_tokenIdUri == null) {
      _checkTraining();
    }
  }

  void _checkTraining() async {
    var inTraining =
        await GetPlayerTrainingStatusCommand().execute(widget.tokenId);

    _inTraining.value = inTraining;

    if (_inTraining.value == true) {
      var begin =
          await GetPlayerBeginTimeTrainingCommand().execute(widget.tokenId);

      var beginTime = DateTime.fromMillisecondsSinceEpoch(begin.toInt() * 1000);

      var diff = DateTime.now().difference(beginTime);
      var remainingTraining = thirtyMinutes - diff.inSeconds;

      if (remainingTraining < 0) {
        _remainingTrainingDurationInSeconds.value = 0;
        _timer?.cancel();
      } else {
        _remainingTrainingDurationInSeconds.value = remainingTraining;
        _createTimer();
      }
    }
  }

  void _createTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_remainingTrainingDurationInSeconds.value == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          _remainingTrainingDurationInSeconds.value--;
        }
      },
    );
  }

  void _generateMetadata() async {
    setState(() {
      _executingMint = true;
    });
    var txHash = await PlayerGenerateMetadataCommand().execute(_tokenIdUri!);

    if (txHash.isNotEmpty) {
      showSnackbarMessage(text: txHash);
      await provider!.waitForTransaction(txHash);
      var uri = await GetPlayerUriByIdCommand().execute(_tokenIdUri!);
      if (uri.isNotEmpty) {
        setState(() {
          _tokenUri = uri.replaceFirst('ipfs://', '');
          _tokenIdUri = null;
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
    if (_executingMint || _tokenUri == null) {
      return _loadingWidget();
    }

    if (_tokenIdUri != null) {
      return _box();
    }

    if (_tokenUri != null && _tokenUri!.isNotEmpty) {
      return FutureBuilder<CharacterDto>(
        future: GetPlayerDetailCommand().execute(_tokenUri!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loadingWidget();
          }

          if (snapshot.data == null) {
            return const Text('No content');
          }

          final CharacterDto character = snapshot.data!;

          return _card(character);
        },
      );
    }

    return const Text('No content');
  }

  Widget _loadingWidget() {
    return const SizedBox(
      width: 230,
      height: 300,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _box() {
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
              Text('#$_tokenIdUri'),
              const FaIcon(FontAwesomeIcons.futbol, size: 56),
              const SizedBox(height: 32),
              Text(
                CustomLocalizations.of(context).openBoxButton,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(CharacterDto character) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colorByRarity(character.rarity), width: 5),
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
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
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
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF202020),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
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
                Tooltip(
                  message:
                      CustomLocalizations.of(context).howToPlayMessageAttack,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/attack.svg',
                        semanticsLabel: 'attack logo',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      FittedBox(
                        child: Text(
                          '${character.attack!.value}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message:
                      CustomLocalizations.of(context).howToPlayMessageDefense,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/defense.svg',
                        semanticsLabel: 'defense icon',
                        width: 24,
                        height: 24,
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
                ),
                Tooltip(
                  message: CustomLocalizations.of(context)
                      .howToPlayMessageCreativity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                ),
                Tooltip(
                  message:
                      CustomLocalizations.of(context).howToPlayMessageTactics,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/tactics.svg',
                        semanticsLabel: 'tactics icon',
                        width: 24,
                        height: 24,
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
                ),
                Tooltip(
                  message:
                      CustomLocalizations.of(context).howToPlayMessageTechnique,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/technique.svg',
                        semanticsLabel: 'technique icon',
                        width: 24,
                        height: 24,
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
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: colorByRarity(character.rarity))),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Tooltip(
                  message:
                      CustomLocalizations.of(context).howToPlayMessageHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/height.svg',
                        semanticsLabel: 'height icon',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${character.height!.value}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message: CustomLocalizations.of(context)
                      .howToPlayMessagePreferredFoot,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/foot.svg',
                        semanticsLabel: 'foot icon',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${character.preferredFoot}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message:
                      CustomLocalizations.of(context).howToPlayMessagePosition,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/position.svg',
                        semanticsLabel: 'position icon',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${character.position}',
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          actions(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget actions() {
    void _startTraining() async {
      try {
        setState(() {
          _executingTransaction = true;
          _inTraining.value = true;
        });
        final resultApprove =
            await StartTrainingCommand().execute(widget.tokenId);
        setState(() {
          showSnackbarMessage(text: resultApprove);
          _executingTransaction = false;
          _remainingTrainingDurationInSeconds.value = thirtyMinutes;
          _createTimer();
        });
      } on EthereumException catch (e) {
        setState(() {
          _executingTransaction = false;
          showSnackbarMessage(text: e.data["message"]);
        });
      }
    }

    Widget _btnStartTraining = ElevatedButton(
      child: _executingTransaction
          ? const Center(child: CircularProgressIndicator())
          : Text(
              CustomLocalizations.of(context).startTrainingButton,
              style: const TextStyle(fontSize: 20),
            ),
      onPressed: _executingTransaction ? null : _startTraining,
    );

    void _finishTraining() async {
      try {
        setState(() {
          _executingTransaction = true;
        });
        final resultApprove =
            await FinishTrainingCommand().execute(widget.tokenId);
        setState(() {
          showSnackbarMessage(text: resultApprove);
          _executingTransaction = false;
          _inTraining.value = false;
        });
      } on EthereumException catch (e) {
        setState(() {
          _executingTransaction = false;
          showSnackbarMessage(text: e.data["message"]);
        });
      }
    }

    Widget _btnEndTraining = ValueListenableBuilder<int>(
      valueListenable: _remainingTrainingDurationInSeconds,
      builder: (context, remainingTraining, child) {
        return ElevatedButton(
          child: _executingTransaction
              ? const Center(child: CircularProgressIndicator())
              : Opacity(
                  opacity: remainingTraining > 0 ? 0.75 : 1,
                  child: Text(
                    remainingTraining > 0
                        ? '${(Duration(seconds: remainingTraining))}'
                            .split('.')[0]
                            .padLeft(8, '0')
                        : CustomLocalizations.of(context).endTrainingButton,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
          onPressed: _executingTransaction || remainingTraining > 0
              ? null
              : _finishTraining,
        );
      },
    );

    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<bool>(
              valueListenable: _inTraining,
              builder: (context, inTraining, child) {
                return SizedBox(
                    height: 45,
                    child: (inTraining ? _btnEndTraining : _btnStartTraining));
              }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
