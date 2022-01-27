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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 230,
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.data == null) {
          return const Text('No content');
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
      },
    );
  }
}
