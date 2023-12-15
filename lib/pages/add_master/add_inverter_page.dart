// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/inverter_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddInverterPage extends StatelessWidget {
  const AddInverterPage({super.key, required this.popId});
  final int popId;
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController merkController = TextEditingController();
    TextEditingController snController = TextEditingController();
    TextEditingController tipeController = TextEditingController();
    TextEditingController kondisiController = TextEditingController();
    TextEditingController kapasitasController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add Inverter"),
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
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                if (merkController.text.isNotEmpty &&
                    kondisiController.text.isNotEmpty &&
                    tipeController.text.isNotEmpty &&
                    kapasitasController.text.isNotEmpty &&
                    snController.text.isNotEmpty) {
                  await InverterMasterService().postInverterMaster(
                    sn: snController.text,
                    tipe: tipeController.text,
                    kondisi: kondisiController.text,
                    merk: merkController.text,
                    kapasitas: int.parse(kapasitasController.text),
                    popId: popId,
                  );
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
