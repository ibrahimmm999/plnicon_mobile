import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/modul_master_model.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class ModulPage extends StatelessWidget {
  const ModulPage({super.key, required this.title, required this.modul});
  final ModulMasterModel modul;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Center(
          child: Container(
            margin: const EdgeInsets.only(right: 60),
            child: Text(
              title,
              style: header2.copyWith(color: textLightColor),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Sn : ${modul.sn}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Kapasitas : ${modul.kapasitas}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
        ],
      ),
    );
  }
}
