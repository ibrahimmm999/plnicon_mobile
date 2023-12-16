// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/ats_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddAtsPage extends StatelessWidget {
  const AddAtsPage({super.key, required this.popId});
  final int popId;
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController snController = TextEditingController();
    TextEditingController tipeController = TextEditingController();
    TextEditingController merkController = TextEditingController();
    TextEditingController statusController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add ATS"),
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
                  await AtsMasterService().postAtsMaster(
                      status: statusController.text,
                      sn: snController.text,
                      merk: merkController.text,
                      tipe: tipeController.text,
                      popId: popId);
                  popProvider.getDataPop(id: popId);
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
