import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/environment_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditEnvPage extends StatelessWidget {
  const EditEnvPage(
      {super.key, required this.env, required this.title, required this.pm});
  final EnvironmentMasterModel env;
  final PmModel pm;
  final String title;

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider acProvider =
        Provider.of<TransaksionalProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController bangunanController =
        TextEditingController(text: env.bangunan);
    TextEditingController exhaustController =
        TextEditingController(text: env.exhaust);
    TextEditingController jumlahLampuController =
        TextEditingController(text: env.jumlahLampu);
    TextEditingController lampuController =
        TextEditingController(text: env.lampu);
    TextEditingController kebersihanBangunanController =
        TextEditingController(text: env.kebersihanBangunan);
    TextEditingController kebersihanExhaustController =
        TextEditingController(text: env.kebersihanExhaust);
    TextEditingController suhuRuanganController =
        TextEditingController(text: env.suhuRuangan.toString());
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: title),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Bangunan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: bangunanController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Exhaust",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: exhaustController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Jumlah Lampu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: jumlahLampuController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Lampu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: lampuController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Keberihan Bangunan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: kebersihanBangunanController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Kebersihan Exhaust",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: kebersihanExhaustController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Suhu Ruangan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: suhuRuanganController),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await popProvider.getDataPop(id: env.popId);
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
