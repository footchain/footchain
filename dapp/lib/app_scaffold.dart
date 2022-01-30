import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'commands/account/set_current_account_command.dart';
import 'commands/init_app_command.dart';
import 'localizations/localizations.dart';
import 'models/app_model.dart';
import 'utils/constants.dart';
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
      _checkCurrentChain();
      _watchChainChanges();
      _watchAccountChanges();
    } else {
      showSnackbarMessage(
        text: CustomLocalizations.of(context).networkErrorMessage,
      );
    }
    setState(() {
      _loadingApp = false;
    });
  }

  void _checkCurrentChain() async {
    var currentChain = await ethereum!.getChainId();
    if (currentChain == Constants.chainId) {
      InitAppCommand().execute(provider);
    }
  }

  void _watchChainChanges() async {
    ethereum!.onChainChanged((chainId) {
      if (chainId == Constants.chainId) {
        InitAppCommand().execute(provider);
      }
    });
  }

  void _watchAccountChanges() async {
    ethereum!.onAccountsChanged((accounts) {
      if (accounts != null) {
        SetCurrentAccountCommand().execute(accounts.first);
      }
    });
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
            const Positioned(
              bottom: 45,
              left: 16,
              child: SocialMediaWidget(),
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
