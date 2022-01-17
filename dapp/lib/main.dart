import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'app_scaffold.dart';
import 'localizations/localizations.dart';
import 'models/app_model.dart';
import 'setup_service_locator.dart';

void main() async {
  initServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await GRecaptchaV3.ready("6Lch6fkdAAAAAC3qfB1WEVgXXCdP0tBc7-c4-R3x",
      showBadge: true);
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
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              CpfLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('pt'),
              Locale('en'),
            ],
            localeResolutionCallback:
                (Locale? locale, Iterable<Locale> supportedLocales) {
              Locale currentLocale = supportedLocales.first;
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode ||
                    supportedLocale.countryCode == locale.countryCode) {
                  currentLocale = supportedLocale;
                  return currentLocale;
                } else {
                  Locale webLocale = Locale(ui.window.locale.languageCode, '');
                  currentLocale = webLocale;
                  return currentLocale;
                }
              }
              return currentLocale;
            },
            title: 'Crypto Foot',
            theme: ThemeData(
              primarySwatch: Colors.red,
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Inter'),
            ),
            home: const AppScaffold(),
          );
        },
      ),
    );
  }
}
