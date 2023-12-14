// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/genset_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddGensetPage extends StatefulWidget {
  const AddGensetPage({super.key, required this.popId});
  final int popId;

  @override
  State<AddGensetPage> createState() => _AddGensetPageState();
}

String tglInstalasi = '';

class _AddGensetPageState extends State<AddGensetPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController snController = TextEditingController();
    TextEditingController maxFuelController = TextEditingController();
    TextEditingController merkController = TextEditingController();
    TextEditingController kapasitasController = TextEditingController();
    TextEditingController merkEngineController = TextEditingController();
    TextEditingController switchGensetController = TextEditingController();
    TextEditingController merkGenController = TextEditingController();
    TextEditingController accuController = TextEditingController();
    TextEditingController bahanBakarController = TextEditingController();
    TextEditingController merkAccuController = TextEditingController();
    TextEditingController tipeBattChargerController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add Genset"),
      body: ListView(
        padding: EdgeInsets.only(
            top: defaultMargin,
            left: defaultMargin,
            right: defaultMargin,
            bottom: 80),
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
            "Max Fuel",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: maxFuelController),
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
            "Merk Engine",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkEngineController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk Gen",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkGenController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Accu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: accuController),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Merk Accu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: merkAccuController),
          const SizedBox(
            height: 20,
          ),

          Text(
            "Tipe Batt Charger",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: tipeBattChargerController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Switch",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: switchGensetController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Bahan Bakar",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: bahanBakarController),
          const SizedBox(
            height: 20,
          ),
          // Text(
          //   "Tanggal Instalasi",
          //   style: buttonText.copyWith(color: textDarkColor),
          // ),
          // GestureDetector(
          //     onTap: () async {
          //       DateTime? pickedDate = await showDatePicker(
          //           context: context,
          //           cancelText: "Cancel",
          //           currentDate: DateTime.now(),
          //           confirmText: "Set",
          //           initialDate: DateTime.now(),
          //           firstDate: DateTime(1945),
          //           lastDate: DateTime.now());
          //       if (pickedDate != null) {
          //         String formattedDate =
          //             DateFormat('yyyy-MM-dd hh:mm:ss').format(pickedDate);
          //         setState(() {
          //           tglInstalasi = formattedDate;
          //         });
          //       }
          //     },
          //     child: Container(
          //       padding: EdgeInsets.all(defaultMargin),
          //       decoration: BoxDecoration(
          //           color: primaryBlue,
          //           borderRadius: BorderRadius.circular(defaultRadius)),
          //       child: Row(
          //         children: [
          //           Text(
          //             tglInstalasi,
          //             style: buttonText,
          //           )
          //         ],
          //       ),
          //     )),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await GensetMasterService().postGensetMaster(
                  bahanBakar: bahanBakarController.text,
                  merkAccu: merkAccuController.text,
                  switchGenset: switchGensetController.text,
                  tipeBattCharger: tipeBattChargerController.text,
                  accu: double.parse(accuController.text),
                  sn: snController.text,
                  tglInstalasi: tglInstalasi,
                  maxFuel: int.parse(maxFuelController.text),
                  merk: merkController.text,
                  kapasitas: int.parse(kapasitasController.text),
                  merkEngine: merkEngineController.text,
                  merkGen: merkGenController.text,
                  popId: widget.popId,
                );
                popProvider.getDataPop(id: widget.popId);
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
