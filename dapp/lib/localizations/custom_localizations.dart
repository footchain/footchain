import 'package:flutter/material.dart';

class CustomLocalizations {
  final Locale locale;

  CustomLocalizations(this.locale);

  static CustomLocalizations of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      //generic
      'transaction': 'Transaction',
      // buttons
      'startButton': 'Play',
      'howToPlayButton': 'How to play?',
      'roadmapButton': 'Roadmap',
      'whitepaperButton': 'Whitepaper',
      'airdropButton': 'Mint',
      'connectAccountButton': 'Login with Metamask',
      'soccerPlayersButton': 'Players',
      'buildingsButton': 'Buildings',
      'matchesButton': 'Matches',
      'marketplaceButton': 'Marketplace',
      'openBoxButton': 'Open box',
      'boxButton': 'BOX',

      // How to play
      'howToPlayMessage1':
          'Welcome to the world of football! From now on you will have the chance to be a millionaire in the world of football. You will have the chance to hire professionals, some not so professionals, to bring money and success to your company. In addition, you will be able to acquire structures that can put your company in "otô patamar"',
      'howToPlayMessage2':
          'The game will initially have 5 characters, each with specific skills, allowing you to create a multitude of strategies to profit from your company. All character abilities will be scored from 0 to 100.',
      'howToPlayMessage3':
          'Main character of the game, will have a high capacity of collection, however it will require a series of cares so that it remains having a high performance. It can be combined with other characters to create a new character.',
      'howToPlayMessage4':
          'All players, regardless of rarity level, will have the following abilities:\n\n'
              '🔥 Attack\n'
              '🛡️ Defense\n'
              '🤫 Creativity\n'
              '🕴️ tactic\n'
              '🦶 Technique\n',
      'howToPlayMessage5':
          'Players will have specific characteristics that will be fundamental to the outcome of the matches. Are they:\n\n'
              '🗻 Height\n'
              '👣 Preferred foot\n'
              '🚶‍♂️ Position\n',

      // Air drop
      'airdropMessage1': 'We will issue a total of 1,000,000 FTCs via Airdrop.',
      'airdropMessage2': 'You will be entitled to 10 FTC per wallet.',
      'requestAirdropButton': "Request",

      // Roadmap
      'roadmapTitle1': '15/01/2022',
      'roadmapMessage1':
          'Whitelist opening for the sale of the first 5,000 NFTs',
      'roadmapTitle2': '30/01/2022',
      'roadmapMessage2':
          'Launch of the FTC token and start of the sale of NFTs',
      'roadmapTitle3': '15/02/2022',
      'roadmapMessage3': 'Opening the game in Alpha mode',
      'roadmapTitle4': '25/02/2022',
      'roadmapMessage4': 'Opening of token withdraw',

      //Mint NFT
      'mintTitle': 'Buy new BOX',
      'mintTitle1':
          'In the current phase, only PLAYER characters will be created and their characteristics will be generated randomly.',
      'mintTitle2': 'Each mint of a new character will cost 10 FTC.',
      'mintButton': 'Create',

      // Erro messages
      'networkErrorMessage': 'Check if the network is available.',
      'genericErrorMessage': 'Operation failed.',
      // Character card
      'startTrainingButton': 'Start training',
    },
    'pt': {
      //generic
      'transaction': 'Transação',
      // buttons
      'startButton': 'Jogar',
      'howToPlayButton': 'Como jogar?',
      'roadmapButton': 'Roadmap',
      'whitepaperButton': 'Whitepaper',
      'airdropButton': 'Mintar',
      'connectAccountButton': 'Login com Metamask',
      'soccerPlayersButton': 'Jogadores',
      'buildingsButton': 'Edifícios',
      'matchesButton': 'Partidas',
      'marketplaceButton': 'Mercado',
      'openBoxButton': 'Abrir caixa',
      'boxButton': 'BOX',

      // How to play
      'howToPlayMessage1':
          'Bem-Vindo ao mundo do futebol! A partir de agora você terá a chance de ser empresário do milionário mundo do futebol. Você terá a chance de contratar profissionais, alguns não tão profissionais assim, para trazerem dinheiro e sucesso para sua empresa. Além disso, você poderá adquirir estruturas que poderão colocar a sua empresa em “otô patamar”.',
      'howToPlayMessage2':
          'O jogo contará inicialmente com 5 personagens, cada uma possuindo habilidades específicas, permitindo assim, que você crie uma infinidade de estratégias para lucrar com sua empresa. Todas as habilidades das personagens serão pontuadas de 0 a 100.',
      'howToPlayMessage3':
          'Principal personagem do jogo, terá uma alta capacidade de arrecadação, contudo exigirá uma série de cuidados para que permaneça tendo um alto desempenho. Poderá ser combinada com outras personagens para a criação de uma nova personagem.',
      'howToPlayMessage4':
          'Todos os jogadores, independente do nível de raridade terão as seguintes habilidades:\n\n'
              '🔥 Ataque\n\n'
              '🛡️ Defesa\n\n'
              '🤫 Criatividade\n\n'
              '🕴️ Tática\n\n'
              '🦶 Técnica\n\n',
      'howToPlayMessage5':
          'Os jogadores terão características específicas que serão fundamentais para o resultado das partidas. São elas:\n\n'
              '🗻 Altura\n\n'
              '👣 Pé preferido\n\n'
              '🚶‍♂️ Posição\n\n',

      // Air drop
      'airdropMessage1':
          'Emitiremos um total de 1.000.000 de FTCs via Airdrop.',
      'airdropMessage2': 'Você terá direito a 10 FTC por carteira.',
      'requestAirdropButton': "Requisitar",
      // Roadmap
      'roadmapTitle1': '15/01/2022',
      'roadmapMessage1':
          'Abertura para Whitelist da venda dos primeiros 5 mil NFTs ',
      'roadmapTitle2': '30/01/2022',
      'roadmapMessage2': 'Lançamento do token FTC e início da venda dos NFTs',
      'roadmapTitle3': '15/02/2022',
      'roadmapMessage3': 'Abertura do jogo em modo Alpha',
      'roadmapTitle4': '25/02/2022',
      'roadmapMessage4': 'Abertura dos saques do token',

      //Mint NFT
      'mintTitle': 'Comprar BOX',
      'mintTitle1':
          'Na fase atual apenas personagens do tipo JOGADOR serão criados e suas características serão geradas de forma aleatória.',
      'mintTitle2': 'Cada emissão de um novo personagem custará 10 FTC.',
      'mintButton': 'Comprar',
      // Erro messages
      'networkErrorMessage': 'Verifique se a rede está disponível.',
      'genericErrorMessage': 'Não foi possível realizar a operação',
      // Character card
      'startTrainingButton': 'Iniciar treino',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  //generic
  String get transaction =>
      _localizedValues[locale.languageCode]!['transaction']!;
  // buttons
  String get startButton =>
      _localizedValues[locale.languageCode]!['startButton']!;
  String get howToPlayButton =>
      _localizedValues[locale.languageCode]!['howToPlayButton']!;
  String get whitepaperButton =>
      _localizedValues[locale.languageCode]!['whitepaperButton']!;
  String get roadmapButton =>
      _localizedValues[locale.languageCode]!['roadmapButton']!;
  String get airdropButton =>
      _localizedValues[locale.languageCode]!['airdropButton']!;
  String get connectAccountButton =>
      _localizedValues[locale.languageCode]!['connectAccountButton']!;
  String get soccerPlayersButton =>
      _localizedValues[locale.languageCode]!['soccerPlayersButton']!;
  String get buildingsButton =>
      _localizedValues[locale.languageCode]!['buildingsButton']!;
  String get matchesButton =>
      _localizedValues[locale.languageCode]!['matchesButton']!;
  String get marketplaceButton =>
      _localizedValues[locale.languageCode]!['marketplaceButton']!;
  String get openBoxButton =>
      _localizedValues[locale.languageCode]!['openBoxButton']!;
  String get boxButton => _localizedValues[locale.languageCode]!['boxButton']!;

  // How to play
  String get howToPlayMessage1 =>
      _localizedValues[locale.languageCode]!['howToPlayMessage1']!;
  String get howToPlayMessage2 =>
      _localizedValues[locale.languageCode]!['howToPlayMessage2']!;
  String get howToPlayMessage3 =>
      _localizedValues[locale.languageCode]!['howToPlayMessage3']!;
  String get howToPlayMessage4 =>
      _localizedValues[locale.languageCode]!['howToPlayMessage4']!;
  String get howToPlayMessage5 =>
      _localizedValues[locale.languageCode]!['howToPlayMessage5']!;

  // Airdrop
  String get airdropMessage1 =>
      _localizedValues[locale.languageCode]!['airdropMessage1']!;
  String get airdropMessage2 =>
      _localizedValues[locale.languageCode]!['airdropMessage2']!;
  String get requestAirdropButton =>
      _localizedValues[locale.languageCode]!['requestAirdropButton']!;

  // Roadmap
  String get roadmapTitle1 =>
      _localizedValues[locale.languageCode]!['roadmapTitle1']!;
  String get roadmapMessage1 =>
      _localizedValues[locale.languageCode]!['roadmapMessage1']!;
  String get roadmapTitle2 =>
      _localizedValues[locale.languageCode]!['roadmapTitle2']!;
  String get roadmapMessage2 =>
      _localizedValues[locale.languageCode]!['roadmapMessage2']!;
  String get roadmapTitle3 =>
      _localizedValues[locale.languageCode]!['roadmapTitle3']!;
  String get roadmapMessage3 =>
      _localizedValues[locale.languageCode]!['roadmapMessage3']!;
  String get roadmapTitle4 =>
      _localizedValues[locale.languageCode]!['roadmapTitle4']!;
  String get roadmapMessage4 =>
      _localizedValues[locale.languageCode]!['roadmapMessage4']!;

  //Mint NFT
  String get mintTitle => _localizedValues[locale.languageCode]!['mintTitle']!;
  String get mintTitle1 =>
      _localizedValues[locale.languageCode]!['mintTitle1']!;
  String get mintTitle2 =>
      _localizedValues[locale.languageCode]!['mintTitle2']!;
  String get mintButton =>
      _localizedValues[locale.languageCode]!['mintButton']!;

  // Erro Messages
  String get networkErrorMessage =>
      _localizedValues[locale.languageCode]!['networkErrorMessage']!;
  String get genericErrorMessage =>
      _localizedValues[locale.languageCode]!['genericErrorMessage']!;
  // Character card
  String get startTrainingButton =>
      _localizedValues[locale.languageCode]!['startTrainingButton']!;
}
