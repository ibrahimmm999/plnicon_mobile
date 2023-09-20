import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/kwh_master_model.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class EditKwhPage extends StatelessWidget {
  const EditKwhPage({super.key, required this.kwh, required this.title});
  final KwhMasterModel kwh;
  final String title;
  @override
  Widget build(BuildContext context) {
    TextEditingController aresterTypeController =
        TextEditingController(text: kwh.aresterType);
    TextEditingController aresterController =
        TextEditingController(text: kwh.arester);
    TextEditingController cosController = TextEditingController(text: kwh.cos);
    TextEditingController cosTypeController =
        TextEditingController(text: kwh.cosType);
    TextEditingController jumlahPhasaController =
        TextEditingController(text: kwh.jumlahPhasa.toString());
    TextEditingController warnaKabelGController =
        TextEditingController(text: kwh.warnaKabelG);
    TextEditingController warnaKabelNController =
        TextEditingController(text: kwh.warnaKabelN);
    TextEditingController warnaKabelRController =
        TextEditingController(text: kwh.warnaKabelR);
    TextEditingController warnaKabelSController =
        TextEditingController(text: kwh.warnaKabelS);
    TextEditingController warnaKabelTController =
        TextEditingController(text: kwh.warnaKabelT);
    TextEditingController luasKabelRController =
        TextEditingController(text: kwh.luasKabelR.toString());
    TextEditingController luasKabelSController =
        TextEditingController(text: kwh.luasKabelS.toString());
    TextEditingController luasKabelTController =
        TextEditingController(text: kwh.luasKabelT.toString());
    TextEditingController luasKabelNController =
        TextEditingController(text: kwh.luasKabelN.toString());
    TextEditingController capmcbrController =
        TextEditingController(text: kwh.capmcbr.toString());
    TextEditingController capmcbsController =
        TextEditingController(text: kwh.capmcbs.toString());
    TextEditingController capmcbtController =
        TextEditingController(text: kwh.capmcbt.toString());
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: title),
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
          Text(
            "Tanggal Instalasi : -",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
              text: "Save",
              onPressed: () {},
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
