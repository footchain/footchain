// ignore_for_file: non_constant_identifier_names

import 'package:dapp/localizations/localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/widgets.dart';

class HowToPlayView extends StatelessWidget {
  const HowToPlayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            RightArea(
              context,
              descricao: CustomLocalizations.of(context).howToPlayMessage1,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    RandomPlayerWidget(),
                    JumpAnimationWidget(child: RandomPlayerWidget()),
                    RandomPlayerWidget(),
                  ],
                ),
              ],
            ),
            SizedBox(width: double.infinity, child: CustomDivider()),
            LeftArea(
              context,
              descricao: CustomLocalizations.of(context).howToPlayMessage2,
              children: const [
                JumpAnimationWidget(
                  child: RandomPlayerWidget(
                    size: Size(100, 200),
                  ),
                ),
              ],
            ),
            CenterArea(
              descricao: CustomLocalizations.of(context).howToPlayMessage3,
            ),
            SizedBox(width: double.infinity, child: CustomDivider()),
            CenterArea(
              descricao: CustomLocalizations.of(context).howToPlayMessage4,
            ),
            CenterArea(
              descricao: CustomLocalizations.of(context).howToPlayMessage5,
            ),
          ],
        ),
      ),
    );
  }

  Widget CenterArea({
    required String descricao,
  }) {
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              descricao,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget RightArea(BuildContext context,
      {required String descricao, required List<Widget> children}) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              descricao,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        MediaQuery.of(context).size.width > 620
            ? const SizedBox(
                width: 32,
              )
            : const SizedBox(),
        MediaQuery.of(context).size.width > 620
            ? Expanded(child: Column(children: children))
            : const SizedBox(),
      ],
    );
  }

  Widget LeftArea(BuildContext context,
      {required String descricao, required List<Widget> children}) {
    return Row(
      children: [
        MediaQuery.of(context).size.width > 620
            ? Expanded(child: Column(children: children))
            : const SizedBox(),
        MediaQuery.of(context).size.width > 620
            ? const SizedBox(
                width: 32,
              )
            : const SizedBox(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              descricao,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget CustomDivider() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const FaIcon(
                FontAwesomeIcons.futbol,
                size: 32,
              ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}
