// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/rect_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddRectiPage extends StatelessWidget {
  const AddRectiPage({
    super.key,
    required this.popId,
  });

  final int popId;
  @override
  Widget build(BuildContext context) {
    String jumlahPhasa = "";
    String modulControl = "";
    List<String> listJumlahPhasa = ["1", "3"];
    List<String> listModulControl = ["0", "1"];
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController merkController = TextEditingController();
    TextEditingController snController = TextEditingController();
    TextEditingController tipeController = TextEditingController();
    TextEditingController modulTerpasangController = TextEditingController();
    TextEditingController slotModulController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add Rectifier"),
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
          DropdownButtonFormField(
            alignment: Alignment.centerLeft,
            style: buttonText.copyWith(color: textDarkColor),
            borderRadius: BorderRadius.circular(defaultRadius),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(defaultRadius),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(width: 2, color: primaryBlue),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(width: 2, color: neutral500),
              ),
              hintStyle: buttonText.copyWith(color: textDarkColor),
            ),
            items: listJumlahPhasa
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: jumlahPhasa.isEmpty ? null : jumlahPhasa,
            onChanged: (value) {
              jumlahPhasa = value.toString();
              // setState(() {});
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Modul Control",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          DropdownButtonFormField(
            alignment: Alignment.centerLeft,
            style: buttonText.copyWith(color: textDarkColor),
            borderRadius: BorderRadius.circular(defaultRadius),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(defaultRadius),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(width: 2, color: primaryBlue),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
                borderSide: BorderSide(width: 2, color: neutral500),
              ),
              hintStyle: buttonText.copyWith(color: textDarkColor),
            ),
            items: listModulControl
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: modulControl.isEmpty ? null : modulControl,
            onChanged: (value) {
              modulControl = value.toString();
            },
          ),
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
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await RectMasterService().postRectMaster(
                    sn: snController.text,
                    jumlahPhasa: int.parse(jumlahPhasa),
                    slotModul: int.parse(slotModulController.text),
                    modulTerpasang: int.parse(modulTerpasangController.text),
                    modulControl: int.parse(modulControl),
                    merk: merkController.text,
                    tipe: tipeController.text,
                    popId: popId);
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
