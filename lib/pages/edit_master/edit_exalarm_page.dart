import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/exalarm_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditExAlarmPage extends StatelessWidget {
  const EditExAlarmPage(
      {super.key,
      required this.exalarm,
      required this.title,
      required this.pm});
  final ExAlarmMasterModel exalarm;
  final PmModel pm;
  final String title;

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider acProvider =
        Provider.of<TransaksionalProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController eaController =
        TextEditingController(text: exalarm.ea);
    TextEditingController gensetRunFailController =
        TextEditingController(text: exalarm.gensetRunFail);
    TextEditingController pintuController =
        TextEditingController(text: exalarm.pintu);
    TextEditingController smokeNFireController =
        TextEditingController(text: exalarm.smokeAndFire);
    TextEditingController suhuController =
        TextEditingController(text: exalarm.suhu);
    TextEditingController plnOffController =
        TextEditingController(text: exalarm.plnOff.toString());
    TextEditingController perangkatEaController =
        TextEditingController(text: exalarm.perangkatEa.toString());
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: title),
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
          TextInput(controller: suhuController),
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
          TextInput(controller: plnOffController),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await popProvider.getDataPop(id: exalarm.popId);
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
