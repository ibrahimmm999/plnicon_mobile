import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/kwh_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class AddKwhPage extends StatelessWidget {
  const AddKwhPage({super.key, required this.popId});
  final int popId;
  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController aresterTypeController = TextEditingController();
    TextEditingController aresterController = TextEditingController();
    TextEditingController dayaController = TextEditingController();
    TextEditingController cosController = TextEditingController();
    TextEditingController cosTypeController = TextEditingController();
    TextEditingController jumlahPhasaController = TextEditingController();
    TextEditingController warnaKabelGController = TextEditingController();
    TextEditingController warnaKabelNController = TextEditingController();
    TextEditingController warnaKabelRController = TextEditingController();
    TextEditingController warnaKabelSController = TextEditingController();
    TextEditingController warnaKabelTController = TextEditingController();
    TextEditingController luasKabelRController = TextEditingController();
    TextEditingController luasKabelSController = TextEditingController();
    TextEditingController luasKabelTController = TextEditingController();
    TextEditingController luasKabelNController = TextEditingController();
    TextEditingController capmcbrController = TextEditingController();
    TextEditingController capmcbsController = TextEditingController();
    TextEditingController capmcbtController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Add KWH"),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          Text(
            "Arester Type",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: aresterTypeController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Arester",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: aresterController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Daya",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: dayaController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Cos",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: cosController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Cos Type",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: cosTypeController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Jumlah Phasa",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: jumlahPhasaController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "capmcbr",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: capmcbrController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "capmcbs",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: capmcbsController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "capmcbt",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: capmcbtController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Warna Kabel G",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: warnaKabelGController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Warna Kabel N",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: warnaKabelNController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Warna Kabel S",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: warnaKabelSController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Warna Kabel R",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: warnaKabelRController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Warna Kabel T",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: warnaKabelTController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Luas Kabel R",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: luasKabelRController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Luas Kabel S",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: luasKabelSController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Luas Kabel T",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: luasKabelTController),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Luas Kabel N",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: luasKabelNController),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                await KwhMasterService().postKwhMaster(
                    popId: popId,
                    daya: double.parse(dayaController.text),
                    arester: aresterController.text,
                    aresterType: aresterTypeController.text,
                    capmcbr: double.parse(capmcbrController.text),
                    capmcbs: double.parse(capmcbsController.text),
                    capmcbt: double.parse(capmcbtController.text),
                    cos: cosController.text,
                    cosType: cosTypeController.text,
                    jumlahPhasa: int.parse(jumlahPhasaController.text),
                    warnaKabelR: warnaKabelRController.text,
                    warnaKabelS: warnaKabelSController.text,
                    warnaKabelT: warnaKabelTController.text,
                    warnaKabelN: warnaKabelNController.text,
                    warnaKabelG: warnaKabelGController.text,
                    luasKabelR: double.parse(luasKabelRController.text),
                    luasKabelS: double.parse(luasKabelSController.text),
                    luasKabelT: double.parse(luasKabelTController.text),
                    luasKabelN: double.parse(luasKabelNController.text));
                popProvider.getDataPop(id: popId);
                Navigator.pop(context);
              },
              color: primaryGreen,
              clickColor: clickGreen),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
