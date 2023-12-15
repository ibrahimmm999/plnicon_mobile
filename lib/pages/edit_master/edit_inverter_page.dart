// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/inverter_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/services/master/inverter_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditInverterPage extends StatefulWidget {
  const EditInverterPage(
      {super.key,
      required this.inverter,
      required this.title,
      required this.pm});
  final InverterMasterModel inverter;
  final String title;
  final PmModel pm;

  @override
  State<EditInverterPage> createState() => _EditInverterPageState();
}

String tglInstalasi = "";

class _EditInverterPageState extends State<EditInverterPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = widget.inverter.tanggalInstalasi;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider inverterProvider =
        Provider.of<TransaksionalProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController merkController =
        TextEditingController(text: widget.inverter.merk);
    TextEditingController snController =
        TextEditingController(text: widget.inverter.sn);
    TextEditingController tipeController =
        TextEditingController(text: widget.inverter.tipe);
    TextEditingController kondisiController =
        TextEditingController(text: widget.inverter.kondisi);
    TextEditingController kapasitasController =
        TextEditingController(text: widget.inverter.kapasitas.toString());
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
          TextInput(
            controller: kapasitasController,
            keyboardType: TextInputType.number,
          ),
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
                        DateTime.parse(widget.inverter.tanggalInstalasi),
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
                if (merkController.text.isNotEmpty &&
                    kondisiController.text.isNotEmpty &&
                    tipeController.text.isNotEmpty &&
                    kapasitasController.text.isNotEmpty &&
                    snController.text.isNotEmpty) {
                  await InverterMasterService().editInverterMaster(
                      inverterId: widget.inverter.id,
                      popId: widget.inverter.popId,
                      sn: snController.text,
                      kondisi: kondisiController.text,
                      merk: merkController.text,
                      tglInstalasi: tglInstalasi,
                      kapasitas: int.parse(kapasitasController.text),
                      tipe: tipeController.text);
                  await inverterProvider.getInverter(
                      widget.pm.id, widget.inverter.id);
                  await popProvider.getDataPop(id: widget.inverter.popId);
                  Navigator.pop(context);
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
