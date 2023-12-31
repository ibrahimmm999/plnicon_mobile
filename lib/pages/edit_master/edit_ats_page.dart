// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/ats_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/services/master/ats_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class EditAtsPage extends StatefulWidget {
  const EditAtsPage(
      {super.key,
      required this.popId,
      required this.atsMaster,
      required this.pm});
  final int popId;
  final AtsMasterModel atsMaster;
  final PmModel pm;

  @override
  State<EditAtsPage> createState() => _EditAtsPageState();
}

String tglInstalasi = "";

class _EditAtsPageState extends State<EditAtsPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = widget.atsMaster.tanggalInstalasi;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController snController = TextEditingController();
    TextEditingController tipeController = TextEditingController();
    TextEditingController merkController = TextEditingController();
    TextEditingController statusController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Edit ATS"),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Sn",
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
            "Merk",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Status",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: statusController),
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
                        DateTime.parse(widget.atsMaster.tanggalInstalasi),
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
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                if (statusController.text.isNotEmpty &&
                    snController.text.isNotEmpty &&
                    merkController.text.isNotEmpty &&
                    tipeController.text.isNotEmpty) {
                  await AtsMasterService().editAtsMaster(
                      atsId: widget.atsMaster.id,
                      tglInstalasi: tglInstalasi,
                      status: statusController.text,
                      sn: snController.text,
                      merk: merkController.text,
                      tipe: tipeController.text,
                      popId: widget.popId);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PmDetailPage(pm: widget.pm)),
                      (route) => false);
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
