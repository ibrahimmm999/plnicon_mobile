import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/ac_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/services/master/ac_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditAcPage extends StatelessWidget {
  const EditAcPage(
      {super.key,
      required this.acMaster,
      required this.title,
      required this.pm});
  final AcMasterModel acMaster;
  final PmModel pm;
  final String title;

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider acProvider =
        Provider.of<TransaksionalProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController namaAcController =
        TextEditingController(text: acMaster.nama);
    TextEditingController kondisiController =
        TextEditingController(text: acMaster.kondisi);
    TextEditingController merkController =
        TextEditingController(text: acMaster.merk);
    TextEditingController kapasitasController =
        TextEditingController(text: acMaster.kapasitas);
    TextEditingController tekananFreonController =
        TextEditingController(text: acMaster.tekananFreon);
    TextEditingController modeHidupController =
        TextEditingController(text: acMaster.modeHidup);
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: title),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Nama",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: namaAcController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Kondisi",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: kondisiController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Kapasitas",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: kapasitasController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tekanan Freon",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: tekananFreonController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Mode Hidup",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: modeHidupController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tanggal Instalasi : -",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await AcMasterService().editAcMaster(
                  popId: acMaster.popId,
                  acId: acMaster.id,
                  nama: namaAcController.text,
                  kondisi: kondisiController.text,
                  merk: merkController.text,
                  kapasitas: kapasitasController.text,
                  tekananFreon: tekananFreonController.text,
                  modeHidup: modeHidupController.text,
                );

                await popProvider.getDataPop(id: acMaster.popId);
                await acProvider.getAc(pm.id, acMaster.id);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              color: primaryGreen,
              clickColor: clickGreen),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
