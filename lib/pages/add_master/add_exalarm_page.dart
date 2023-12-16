// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/exalarm_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddExAlarmPage extends StatefulWidget {
  const AddExAlarmPage({super.key, required this.title, required this.pm});
  final PmModel pm;
  final String title;

  @override
  State<AddExAlarmPage> createState() => _AddExAlarmPageState();
}

String tglInstalasi = '';

class _AddExAlarmPageState extends State<AddExAlarmPage> {
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController eaController = TextEditingController();
    TextEditingController gensetRunFailController = TextEditingController();
    TextEditingController pintuController = TextEditingController();
    TextEditingController smokeNFireController = TextEditingController();
    TextEditingController suhuController = TextEditingController();
    TextEditingController plnOffController = TextEditingController();
    TextEditingController perangkatEaController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: widget.title),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Ea",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: eaController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Pintu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: pintuController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Genset Run Fail",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: gensetRunFailController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Smoke and Fire",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: smokeNFireController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Suhu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(
              controller: suhuController, keyboardType: TextInputType.number),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Perangkat Ea",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: perangkatEaController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "PLN Off",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(
              controller: plnOffController, keyboardType: TextInputType.number),
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
                    initialDate: DateTime.now(),
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
                      tglInstalasi.isEmpty
                          ? DateFormat('yyyy-MM-dd hh:mm:ss')
                              .format(DateTime.now())
                              .toString()
                          : tglInstalasi,
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
                if (plnOffController.text.isNotEmpty &&
                    suhuController.text.isNotEmpty &&
                    eaController.text.isNotEmpty &&
                    pintuController.text.isNotEmpty &&
                    gensetRunFailController.text.isNotEmpty &&
                    smokeNFireController.text.isNotEmpty &&
                    perangkatEaController.text.isNotEmpty) {
                  await ExAlarmService().postExAlarm(
                      pmId: widget.pm.id,
                      popId: widget.pm.popId,
                      plnOff: int.parse(plnOffController.text),
                      suhu: suhuController.text,
                      ea: eaController.text,
                      pintu: pintuController.text,
                      gensetRunFail: gensetRunFailController.text,
                      smokeAndFire: smokeNFireController.text,
                      perangkatEa: perangkatEaController.text,
                      tglInstalasi: tglInstalasi,
                      temuan: "",
                      rekomendasi: "");
                  popProvider.getDataPop(id: widget.pm.popId);
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
