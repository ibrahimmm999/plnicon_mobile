// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/genset_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/services/master/genset_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditGensetPage extends StatefulWidget {
  const EditGensetPage(
      {super.key,
      required this.gensetMasterModel,
      required this.pm,
      required this.title});
  final GensetMasterModel gensetMasterModel;
  final String title;
  final PmModel pm;

  @override
  State<EditGensetPage> createState() => _EditGensetPageState();
}

String tglInstalasi = "";

class _EditGensetPageState extends State<EditGensetPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = widget.gensetMasterModel.tanggalInstalasi;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider gensetProvider =
        Provider.of<TransaksionalProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController merkController =
        TextEditingController(text: widget.gensetMasterModel.merk);
    TextEditingController snController =
        TextEditingController(text: widget.gensetMasterModel.sn);
    TextEditingController accuController =
        TextEditingController(text: widget.gensetMasterModel.accu.toString());
    TextEditingController bahanBakarController = TextEditingController(
        text: widget.gensetMasterModel.bahanBakar.toString());
    TextEditingController kapasitasController = TextEditingController(
        text: widget.gensetMasterModel.kapasitas.toString());
    TextEditingController maxFuelController = TextEditingController(
        text: widget.gensetMasterModel.maxFuel.toString());
    TextEditingController merkAccuController = TextEditingController(
        text: widget.gensetMasterModel.merkAccu.toString());
    TextEditingController merkEngineController = TextEditingController(
        text: widget.gensetMasterModel.merkEngine.toString());
    TextEditingController merkGensetController = TextEditingController(
        text: widget.gensetMasterModel.merkGen.toString());
    TextEditingController switchGensetController = TextEditingController(
        text: widget.gensetMasterModel.switchGenset.toString());
    TextEditingController tipeBattChargerController = TextEditingController(
        text: widget.gensetMasterModel.tipeBattCharger.toString());
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: widget.title),
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
            "Tanggal Instalasi",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    cancelText: "Cancel",
                    confirmText: "Set",
                    initialDate: DateTime.parse(
                        widget.gensetMasterModel.tanggalInstalasi),
                    firstDate: DateTime(1945),
                    lastDate: DateTime.now());
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                  setState(() {
                    tglInstalasi = formattedDate;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(defaultMargin),
                decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(defaultRadius)),
                child: Row(
                  children: [
                    Text(
                      tglInstalasi,
                      style: buttonText,
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 52,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await GensetMasterService().editGensetMaster(
                    popId: widget.gensetMasterModel.popId,
                    gensetId: widget.gensetMasterModel.id,
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
                    tglInstalasi: tglInstalasi,
                    switchGenset: switchGensetController.text);
                await popProvider.getDataPop(
                    id: widget.gensetMasterModel.popId);
                await gensetProvider.getGenset(
                    widget.pm.id, widget.gensetMasterModel.id);
                Navigator.pop(context);
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
