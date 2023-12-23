// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/baterai_master_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/baterai_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditBateraiPage extends StatefulWidget {
  const EditBateraiPage(
      {super.key, required this.baterai, required this.popId});
  final int popId;
  final BateraiMasterModel baterai;

  @override
  State<EditBateraiPage> createState() => _EditBateraiPageState();
}

String tglInstalasi = '';
String tglUji = '';
String rectId = '';
String tipe = '';

class _EditBateraiPageState extends State<EditBateraiPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
      tglUji = widget.baterai.tanggalUji;
      rectId = widget.baterai.rectId.toString();
      tipe = widget.baterai.tipe.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> listTipe = ['LITHIUM', 'VRLA'];
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController namaController =
        TextEditingController(text: widget.baterai.nama);
    TextEditingController merkController =
        TextEditingController(text: widget.baterai.merk);
    TextEditingController snController =
        TextEditingController(text: widget.baterai.sn);
    TextEditingController kapasitasController =
        TextEditingController(text: widget.baterai.kapasitas.toString());
    TextEditingController persentaseController =
        TextEditingController(text: widget.baterai.persentase.toString());
    TextEditingController vbattController =
        TextEditingController(text: widget.baterai.vBatt.toString());
    TextEditingController bankIdController =
        TextEditingController(text: widget.baterai.bankId.toString());
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Edit Baterai"),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Rectifier",
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
            items: popProvider.listPop.first.listRect
                .map((e) => DropdownMenuItem(
                      value: e.id.toString(),
                      child: Text(
                        'id rectifier: ${e.id}',
                      ),
                    ))
                .toList(),
            value: rectId.isEmpty ? null : rectId,
            onChanged: (value) {
              rectId = value.toString();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Nama",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: namaController),
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
            "Tipe",
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
            items: listTipe
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ))
                .toList(),
            value: tipe.isEmpty ? null : tipe,
            onChanged: (value) {
              tipe = value.toString();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Bank ID",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: bankIdController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Persentase",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: persentaseController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "V Batt",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: vbattController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tanggal Uji",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    cancelText: "Cancel",
                    currentDate: DateTime.now(),
                    confirmText: "Set",
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1945),
                    lastDate: DateTime.now());
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
                  setState(() {
                    tglUji = formattedDate;
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
                      tglUji,
                      style: buttonText,
                    )
                  ],
                ),
              )),
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
                    initialDate:
                        DateTime.parse(widget.baterai.tanggalInstalasi),
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
                if (namaController.text.isNotEmpty &&
                    snController.text.isNotEmpty &&
                    merkController.text.isNotEmpty &&
                    kapasitasController.text.isNotEmpty &&
                    vbattController.text.isNotEmpty &&
                    bankIdController.text.isNotEmpty &&
                    persentaseController.text.isNotEmpty &&
                    tglUji.isNotEmpty &&
                    tipe.isNotEmpty &&
                    rectId.isNotEmpty) {
                  await BateraiMasterService().editBateraiMaster(
                    bateraiId: widget.baterai.id,
                    bankId: int.parse(bankIdController.text),
                    kapasitas: kapasitasController.text,
                    persentase: persentaseController.text,
                    popId: widget.popId,
                    sn: snController.text,
                    tglUji: tglUji,
                    vbatt: vbattController.text,
                    tipe: kapasitasController.text,
                    rectId: int.parse(rectId),
                    nama: namaController.text,
                    tglInstalasi: tglInstalasi,
                    merk: merkController.text,
                  );
                  popProvider.getDataPop(id: widget.popId);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primaryRed,
                      content: const Text(
                        'Isi data dengan lengkap',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
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
