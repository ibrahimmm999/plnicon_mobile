import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/rect_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/rect_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditRectiPage extends StatelessWidget {
  const EditRectiPage({super.key, required this.pm, required this.rect});

  final PmModel pm;
  final RectMasterModel rect;
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController merkController =
        TextEditingController(text: rect.merk);
    TextEditingController snController = TextEditingController(text: rect.sn);
    TextEditingController tipeController =
        TextEditingController(text: rect.tipe);
    TextEditingController jumlahPhasaController =
        TextEditingController(text: rect.jumlahPhasa.toString());
    TextEditingController modulControlController =
        TextEditingController(text: rect.modulControl.toString());
    TextEditingController modulTerpasangController =
        TextEditingController(text: rect.modulTerpasang.toString());
    TextEditingController slotModulController =
        TextEditingController(text: rect.slotModul.toString());
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Edit Rectifier"),
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
            "Tipe",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: tipeController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Jumlah Phasa",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: jumlahPhasaController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Modul Control",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: modulControlController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Modul Terpasang",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: modulTerpasangController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Slot Modul",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: slotModulController),
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
                await RectMasterService().editRectMaster(
                    rectId: rect.id,
                    sn: snController.text,
                    jumlahPhasa: int.parse(jumlahPhasaController.text),
                    slotModul: int.parse(slotModulController.text),
                    modulTerpasang: int.parse(modulTerpasangController.text),
                    modulControl: int.parse(modulControlController.text),
                    merk: merkController.text,
                    tipe: tipeController.text,
                    popId: rect.popId);
                popProvider.getDataPop(id: rect.popId);
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
