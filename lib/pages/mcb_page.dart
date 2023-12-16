// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/mcb_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_mcb_page.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/services/master/mcb_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';

class McbPage extends StatelessWidget {
  const McbPage(
      {super.key, required this.title, required this.mcb, required this.pm});
  final McbMasterModel mcb;
  final String title;
  final PmModel pm;

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
            "PDB Id : ${mcb.pdbId}",
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
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tanggal Instalasi : ${mcb.tanggalInstalasi}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 52,
          ),
          CustomButton(
              text: "Edit Data",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditMcbPage(
                              mcb: mcb,
                              pm: pm,
                            )));
              },
              color: primaryGreen,
              clickColor: clickGreen),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Delete",
              onPressed: () async {
                await McbMasterService().deleteMaster(id: mcb.id);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => PmDetailPage(pm: pm))),
                    (route) => false);
              },
              color: primaryRed,
              clickColor: clickRed),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
