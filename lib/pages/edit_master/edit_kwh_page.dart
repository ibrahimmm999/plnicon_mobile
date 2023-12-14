import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plnicon_mobile/models/master/kwh_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/services/master/kwh_master_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EditKwhPage extends StatefulWidget {
  const EditKwhPage(
      {super.key, required this.kwh, required this.title, required this.pm});
  final KwhMasterModel kwh;
  final String title;
  final PmModel pm;

  @override
  State<EditKwhPage> createState() => _EditKwhPageState();
}

String tglInstalasi = '';

class _EditKwhPageState extends State<EditKwhPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      tglInstalasi = widget.kwh.tanggalInstalasi;
    });
  }

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider kwhProvider =
        Provider.of<TransaksionalProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    TextEditingController aresterTypeController =
        TextEditingController(text: widget.kwh.aresterType);
    TextEditingController dayaController =
        TextEditingController(text: widget.kwh.daya.toString());
    TextEditingController aresterController =
        TextEditingController(text: widget.kwh.arester);
    TextEditingController cosController =
        TextEditingController(text: widget.kwh.cos);
    TextEditingController cosTypeController =
        TextEditingController(text: widget.kwh.cosType);
    TextEditingController jumlahPhasaController =
        TextEditingController(text: widget.kwh.jumlahPhasa.toString());
    TextEditingController warnaKabelGController =
        TextEditingController(text: widget.kwh.warnaKabelG);
    TextEditingController warnaKabelNController =
        TextEditingController(text: widget.kwh.warnaKabelN);
    TextEditingController warnaKabelRController =
        TextEditingController(text: widget.kwh.warnaKabelR);
    TextEditingController warnaKabelSController =
        TextEditingController(text: widget.kwh.warnaKabelS);
    TextEditingController warnaKabelTController =
        TextEditingController(text: widget.kwh.warnaKabelT);
    TextEditingController luasKabelRController =
        TextEditingController(text: widget.kwh.luasKabelR.toString());
    TextEditingController luasKabelSController =
        TextEditingController(text: widget.kwh.luasKabelS.toString());
    TextEditingController luasKabelTController =
        TextEditingController(text: widget.kwh.luasKabelT.toString());
    TextEditingController luasKabelNController =
        TextEditingController(text: widget.kwh.luasKabelN.toString());
    TextEditingController capmcbrController =
        TextEditingController(text: widget.kwh.capmcbr.toString());
    TextEditingController capmcbsController =
        TextEditingController(text: widget.kwh.capmcbs.toString());
    TextEditingController capmcbtController =
        TextEditingController(text: widget.kwh.capmcbt.toString());
    return Scaffold(
      appBar: CustomAppBar(isMainPage: false, title: widget.title),
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
            "Daya",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          TextInput(controller: dayaController),
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
            "Tanggal Instalasi",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    cancelText: "Cancel",
                    currentDate: DateTime.now(),
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
                await KwhMasterService().editKwhMaster(
                    kwhId: widget.kwh.id,
                    popId: widget.kwh.popId,
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
                    tglInstalasi: tglInstalasi,
                    luasKabelR: double.parse(luasKabelRController.text),
                    luasKabelS: double.parse(luasKabelSController.text),
                    luasKabelT: double.parse(luasKabelTController.text),
                    luasKabelN: double.parse(luasKabelNController.text));
                await popProvider.getDataPop(id: widget.kwh.popId);
                await kwhProvider.getKwh(widget.pm.id, widget.kwh.id);
                Navigator.pop(context);
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
