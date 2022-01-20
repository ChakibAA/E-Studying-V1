// ignore_for_file: file_names, deprecated_member_use

import 'package:estudyingv1/Service/theme.dart';
import 'package:estudyingv1/Widget/AppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:url_launcher/url_launcher.dart';

import '../Widget/Tile.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool dark = ThemeService().dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(value: 'Réglage', context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: const Text(
                'Mode sombre',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: CupertinoSwitch(
                value: dark,
                onChanged: (value) {
                  setState(() {
                    dark = value;
                  });
                  ThemeService().switchTheme();
                },
              ),
            ),
            Tile(
              value: "À propos d'e-studying dz",
              ontap: () {
                launchURL('https://e-studying-dz.com/');
              },
            ),
            Tile(
              value: "Notez l'application",
              ontap: () async {},
            ),
            Tile(
              value: "Partager l'application",
              ontap: () {
                FlutterShare.share(
                    title: "Partager l'application",
                    text: "E-studying-dz",
                    linkUrl: 'https://e-studying-dz.com/',
                    chooserTitle: "Partager l'application");
              },
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
