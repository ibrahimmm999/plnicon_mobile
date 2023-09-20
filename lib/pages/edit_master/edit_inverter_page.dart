import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/inverter_master_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/inverter_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditInverterPage extends StatelessWidget {
  const EditInverterPage(
      {super.key, required this.inverter, required this.title});
  final InverterMasterModel inverter;
  final String title;

  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController merkController =
        TextEditingController(text: inverter.merk);
    TextEditingController snController =
        TextEditingController(text: inverter.sn);
    TextEditingController tipeController =
        TextEditingController(text: inverter.tipe);
    TextEditingController kondisiController =
        TextEditingController(text: inverter.kondisi);
    TextEditingController kapasitasController =
        TextEditingController(text: inverter.kapasitas.toString());
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: title),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Merk",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkController),
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
            "Tipe",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: tipeController),
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
            "SN",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: snController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tanggal Instalasi : -",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await InverterMasterService().editInverterMaster(
                    inverterId: inverter.id,
                    popId: inverter.popId,
                    sn: snController.text,
                    kondisi: kondisiController.text,
                    merk: merkController.text,
                    kapasitas: int.parse(kapasitasController.text),
                    tipe: tipeController.text);
                popProvider.getDataPop(id: inverter.popId);
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
