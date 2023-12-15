// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/modul_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_modul_page.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/services/master/modul_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';

class ModulPage extends StatelessWidget {
  const ModulPage(
      {super.key, required this.title, required this.pm, required this.modul});
  final ModulMasterModel modul;
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
          const SizedBox(
            height: 20,
          ),
          Text(
            "Rectifier Id: ${modul.rectId}",
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
                        builder: (context) => EditModulPage(
                              modul: modul,
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
                await ModulMasterService().deleteMaster(id: modul.id);
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
