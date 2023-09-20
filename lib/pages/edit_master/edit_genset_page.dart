import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/genset_master_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/genset_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditGensetPage extends StatelessWidget {
  const EditGensetPage(
      {super.key, required this.gensetMasterModel, required this.title});
  final GensetMasterModel gensetMasterModel;
  final String title;
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController merkController =
        TextEditingController(text: gensetMasterModel.merk);
    TextEditingController snController =
        TextEditingController(text: gensetMasterModel.sn);
    TextEditingController accuController =
        TextEditingController(text: gensetMasterModel.accu.toString());
    TextEditingController bahanBakarController =
        TextEditingController(text: gensetMasterModel.bahanBakar.toString());
    TextEditingController kapasitasController =
        TextEditingController(text: gensetMasterModel.kapasitas.toString());
    TextEditingController maxFuelController =
        TextEditingController(text: gensetMasterModel.maxFuel.toString());
    TextEditingController merkAccuController =
        TextEditingController(text: gensetMasterModel.merkAccu.toString());
    TextEditingController merkEngineController =
        TextEditingController(text: gensetMasterModel.merkEngine.toString());
    TextEditingController merkGensetController =
        TextEditingController(text: gensetMasterModel.merkGen.toString());
    TextEditingController switchGensetController =
        TextEditingController(text: gensetMasterModel.switchGenset.toString());
    TextEditingController tipeBattChargerController = TextEditingController(
        text: gensetMasterModel.tipeBattCharger.toString());
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
            "SN",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: snController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Accu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: accuController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Bahan Bakar",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: bahanBakarController),
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
            "Max Fuel",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: maxFuelController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk Accu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkAccuController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk Engine",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkEngineController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk Genset",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkGensetController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Switch",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: switchGensetController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tipe Batt Charger",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: tipeBattChargerController),
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
                await GensetMasterService().editGensetMaster(
                    popId: gensetMasterModel.popId,
                    gensetId: gensetMasterModel.id,
                    sn: snController.text,
                    merkEngine: merkEngineController.text,
                    merk: merkController.text,
                    kapasitas: int.parse(kapasitasController.text),
                    merkGen: merkGensetController.text,
                    maxFuel: int.parse(maxFuelController.text),
                    bahanBakar: bahanBakarController.text,
                    accu: double.parse(accuController.text),
                    merkAccu: merkAccuController.text,
                    tipeBattCharger: tipeBattChargerController.text,
                    switchGenset: switchGensetController.text);
                popProvider.getDataPop(id: gensetMasterModel.popId);
                Navigator.pop(context);
              },
              color: primaryGreen,
              clickColor: clickGreen),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
