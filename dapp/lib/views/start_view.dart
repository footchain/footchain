import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class StartView extends StatefulWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: PlayButtonWidget(),
    );
  }
}
