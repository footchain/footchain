import 'package:dapp/localizations/localizations.dart';
import 'package:flutter/material.dart';

class MarketplaceView extends StatefulWidget {
  const MarketplaceView({Key? key}) : super(key: key);

  @override
  _MarketplaceViewState createState() => _MarketplaceViewState();
}

class _MarketplaceViewState extends State<MarketplaceView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Text(
          CustomLocalizations.of(context).comingSoonMessage,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }
}
