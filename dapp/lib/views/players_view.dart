import 'package:dapp/localizations/custom_localizations.dart';
import 'package:flutter/material.dart';

import '../commands/contracts/nft/player/get_players_by_account_command.dart';
import '../widgets/widgets.dart';

class PlayersView extends StatefulWidget {
  const PlayersView({Key? key}) : super(key: key);

  @override
  State<PlayersView> createState() => _PlayersViewState();
}

class _PlayersViewState extends State<PlayersView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BigInt>>(
      future: GetPlayersByAccountCommand().execute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null ||
              (snapshot.data != null && snapshot.data!.length == 0)) {
            return Center(
              child: Container(
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/nft-player-empty-card.png",
                      width: 230,
                      height: 300,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      CustomLocalizations.of(context).emptyPlayerList,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            );
          }

          var players = snapshot.data!;

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
                      children: players.map<Widget>((tokenId) {
                        return CharacterCardWidget(
                          tokenId: tokenId,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox(
            width: 230,
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
