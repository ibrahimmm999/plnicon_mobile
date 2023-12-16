// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/ats_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_ats_page.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/services/master/ats_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';

class AtsPage extends StatelessWidget {
  const AtsPage(
      {super.key, required this.title, required this.ats, required this.pm});
  final AtsMasterModel ats;
  final PmModel pm;
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
            "Sn : ${ats.sn}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk : ${ats.merk}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Status : ${ats.status}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tipe : ${ats.tipe}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tanggal instalasi : ${ats.tanggalInstalasi}",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Edit Data",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditAtsPage(
                              atsMaster: ats,
                              popId: pm.popId,
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
                await AtsMasterService().deleteAts(id: ats.id);
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
