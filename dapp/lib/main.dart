import 'package:dapp/models/app_model.dart';
import 'package:dapp/setup_service_locator.dart';
import 'package:dapp/views/airdrop_view.dart';
import 'package:dapp/views/mint_nft_view.dart';
import 'package:dapp/views/training_view.dart';
import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'app_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GRecaptchaV3.ready("6Lch6fkdAAAAAC3qfB1WEVgXXCdP0tBc7-c4-R3x",
      showBadge: true);
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appModel = GetIt.I.get<AppModel>();

    return ChangeNotifierProvider.value(
      value: appModel,
      child: Builder(builder: (context) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => const AppScaffold(),
              '/airdrop': (context) => const AirdropView(),
              '/mint/nft': (context) => const MintNftView(),
              '/training': (context) => const TrainingView(),
            });
      }),
    );
  }
}
