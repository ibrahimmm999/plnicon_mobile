import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/mcb_master_model.dart';
import 'package:plnicon_mobile/models/master/rack_master_model.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class McbPage extends StatelessWidget {
  const McbPage({super.key, required this.title, required this.mcb});
  final McbMasterModel mcb;
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
            "Nama : ${mcb.nama}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk : ${mcb.merk}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "A Terukur : ${mcb.aTerukur}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Kapasitas : ${mcb.kapasitas}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Peruntukan : ${mcb.peruntukan}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Jumlah Phasa : ${mcb.phasa}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tipe : ${mcb.tipe}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
        ],
      ),
    );
  }
}
