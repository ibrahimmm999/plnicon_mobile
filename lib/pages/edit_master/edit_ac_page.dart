// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class EditAcPage extends StatefulWidget {
  const EditAcPage(
      {super.key,
      required this.acMaster,
      required this.title,
      required this.pm});
  final AcMasterModel acMaster;
  final PmModel pm;
  final String title;

  @override
  State<EditAcPage> createState() => _EditAcPageState();
}

String tglInstalasi = "";

class _EditAcPageState extends State<EditAcPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = widget.acMaster.tanggalInstalasi;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider acProvider =
        Provider.of<TransaksionalProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController namaAcController =
        TextEditingController(text: widget.acMaster.nama);
    TextEditingController kondisiController =
        TextEditingController(text: widget.acMaster.kondisi);
    TextEditingController merkController =
        TextEditingController(text: widget.acMaster.merk);
    TextEditingController kapasitasController =
        TextEditingController(text: widget.acMaster.kapasitas);
    TextEditingController tekananFreonController =
        TextEditingController(text: widget.acMaster.tekananFreon);
    TextEditingController modeHidupController =
        TextEditingController(text: widget.acMaster.modeHidup);
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: widget.title),
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
                        DateTime.parse(widget.acMaster.tanggalInstalasi),
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
                await AcMasterService().editAcMaster(
                    popId: widget.acMaster.popId,
                    acId: widget.acMaster.id,
                    nama: namaAcController.text,
                    kondisi: kondisiController.text,
                    merk: merkController.text,
                    kapasitas: kapasitasController.text,
                    tekananFreon: tekananFreonController.text,
                    modeHidup: modeHidupController.text,
                    tglInstalasi: tglInstalasi);

                await popProvider.getDataPop(id: widget.acMaster.popId);
                await acProvider.getAc(widget.pm.id, widget.acMaster.id);

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
