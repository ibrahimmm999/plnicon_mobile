// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/rect_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/services/master/rect_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditRectiPage extends StatefulWidget {
  const EditRectiPage({super.key, required this.pm, required this.rect});

  final PmModel pm;
  final RectMasterModel rect;

  @override
  State<EditRectiPage> createState() => _EditRectiPageState();
}

String tglInstalasi = "";
String jumlahPhasa = "";
String modulControl = "";

class _EditRectiPageState extends State<EditRectiPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = widget.rect.tanggalInstalasi;
      jumlahPhasa = widget.rect.jumlahPhasa.toString();
      modulControl = widget.rect.modulControl.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> listJumlahPhasa = ["1", "3"];
    List<String> listModulControl = ["0", "1"];
    TransaksionalProvider rectProvider =
        Provider.of<TransaksionalProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController merkController =
        TextEditingController(text: widget.rect.merk);
    TextEditingController snController =
        TextEditingController(text: widget.rect.sn);
    TextEditingController tipeController =
        TextEditingController(text: widget.rect.tipe);
    TextEditingController modulTerpasangController =
        TextEditingController(text: widget.rect.modulTerpasang.toString());
    TextEditingController slotModulController =
        TextEditingController(text: widget.rect.slotModul.toString());
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
                    initialDate: DateTime.parse(widget.rect.tanggalInstalasi),
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
                await RectMasterService().editRectMaster(
                    rectId: widget.rect.id,
                    sn: snController.text,
                    jumlahPhasa: int.parse(jumlahPhasa),
                    slotModul: int.parse(slotModulController.text),
                    modulTerpasang: int.parse(modulTerpasangController.text),
                    modulControl: int.parse(modulControl),
                    merk: merkController.text,
                    tipe: tipeController.text,
                    tglInstalasi: tglInstalasi,
                    popId: widget.rect.popId);
                popProvider.getDataPop(id: widget.rect.popId);

                await rectProvider.getAc(widget.pm.id, widget.rect.id);
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
