import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            launch('https://t.me/+C0Xf5-IYWs9hZjQx');
          },
          icon: FaIcon(
            FontAwesomeIcons.telegramPlane,
            size: 45,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        IconButton(
          onPressed: () {
            launch('https://github.com/footchain/footchain');
          },
          icon: FaIcon(
            FontAwesomeIcons.githubAlt,
            size: 45,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
