import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/ac_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddAcPage extends StatelessWidget {
  const AddAcPage({super.key, required this.popId});
  final int popId;
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController namaAcController = TextEditingController();
    TextEditingController kondisiController = TextEditingController();
    TextEditingController merkController = TextEditingController();
    TextEditingController kapasitasController = TextEditingController();
    TextEditingController tekananFreonController = TextEditingController();
    TextEditingController modeHidupController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add AC"),
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
                await AcMasterService().postAcMaster(
                  nama: namaAcController.text,
                  kondisi: kondisiController.text,
                  merk: merkController.text,
                  kapasitas: kapasitasController.text,
                  tekananFreon: tekananFreonController.text,
                  modeHidup: modeHidupController.text,
                  popId: popId,
                );
                popProvider.getDataPop(id: popId);
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
