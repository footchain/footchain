import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'commands/init_app_command.dart';
import 'localizations/localizations.dart';
import 'models/app_model.dart';
import 'utils/utils.dart';
import 'views/splash_view.dart';
import 'widgets/widgets.dart';

class AppScaffold extends StatefulWidget {
  final Widget? child;
  const AppScaffold({Key? key, this.child}) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  bool _loadingApp = true;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  void _initApp() async {
    GetIt.I.registerSingleton<BuildContext>(context);
    await Future.delayed(const Duration(seconds: 2), () => true);
    if (Ethereum.isSupported) {
      requestUserConnectAccount();
    } else {
      showSnackbarMessage(
        text: CustomLocalizations.of(context).networkErrorMessage,
      );
    }
    setState(() {
      _loadingApp = false;
    });
  }

  Future requestUserConnectAccount() async {
    try {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        await InitAppCommand().execute(provider, accs.first);
      }
    } on Exception catch (e) {
      // TODO
      print("USUARIO CANCELOU");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingApp) {
      return const SplashView();
    } else {
      return Scaffold(
        drawerEnableOpenDragGesture: false,
        drawer: _drawer(context),
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            const SoccerFieldWidget(),
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center, // near the top right
                  radius: 0.7,
                  colors: <Color>[
                    Colors.transparent,
                    Colors.transparent, // yellow sun
                    Colors.black54, // blue sky
                  ],
                ),
              ),
            ),
            Consumer<AppModel>(builder: (context, appModel, child) {
              return Column(
                children: [
                  Expanded(child: widget.child ?? const SizedBox()),
                ],
              );
            }),
            Consumer<AppModel>(
              child: const MenuWidget(),
              builder: (context, appModel, child) {
                return AnimatedPositioned(
                  bottom: appModel.gameModeActive
                      ? (MediaQuery.of(context).size.width > 620
                          ? MediaQuery.of(context).size.width / 2 * -1
                          : MediaQuery.of(context).size.width / 4 * -1)
                      : 0,
                  right: appModel.gameModeActive
                      ? (MediaQuery.of(context).size.width > 620
                          ? MediaQuery.of(context).size.height / 2 * -1
                          : MediaQuery.of(context).size.height / 4 * -1)
                      : 0,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: child!,
                );
              },
            ),
          ],
        ),
      );
    }
  }

  Widget _drawer(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 20),
        child: ItensMenu(
          inDrawer: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
