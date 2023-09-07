import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/inverter_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/inverter_master_service.dart';
import 'package:plnicon_mobile/services/transaksional/inverter_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class InverterPage extends StatefulWidget {
  const InverterPage(
      {super.key,
      required this.title,
      required this.inverter,
      required this.pm});
  final InverterMasterModel inverter;
  final String title;
  final PmModel pm;

  @override
  State<InverterPage> createState() => _InverterPageState();
}

class _InverterPageState extends State<InverterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loadController = TextEditingController();
    TextEditingController inputACController = TextEditingController();
    TextEditingController inputDCController = TextEditingController();
    TextEditingController outputDCController = TextEditingController();
    TextEditingController mainfallController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    TextEditingController merkController =
        TextEditingController(text: widget.inverter.merk);
    TextEditingController snController =
        TextEditingController(text: widget.inverter.sn);
    TextEditingController tipeController =
        TextEditingController(text: widget.inverter.tipe);
    TextEditingController kondisiController =
        TextEditingController(text: widget.inverter.kondisi);
    TextEditingController kapasitasController =
        TextEditingController(text: widget.inverter.kapasitas.toString());
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    PopProvider popProvider = Provider.of<PopProvider>(context);
    String hasilUji = "";
    List<String> listHasilPengujian = ["OK", "Not OK"];
    Widget switchContent() {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 52,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomePageNav(
                title: 'Data Teknis',
                index: 0,
                width: MediaQuery.sizeOf(context).width * 0.5),
            HomePageNav(
                title: 'Hasil Ukur/Uji',
                index: 1,
                width: MediaQuery.sizeOf(context).width * 0.5),
          ],
        ),
      );
    }

    Widget buildContent() {
      int newPage = pageProvider.pmPage;
      switch (newPage) {
        case 0:
          {
            return Scaffold(
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
                  TextInput(controller: kapasitasController),
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
                  Text(
                    "Tanggal Instalasi : -",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Save",
                      onPressed: () async {
                        await InverterMasterService().editInverterMaster(
                            inverterId: widget.inverter.id,
                            popId: widget.inverter.popId,
                            sn: snController.text,
                            kondisi: kondisiController.text,
                            merk: merkController.text,
                            kapasitas: int.parse(kapasitasController.text),
                            tipe: tipeController.text);
                        popProvider.getDataPop(id: widget.inverter.popId);
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
        case 1:
          {
            return Scaffold(
              body: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: 20),
                children: [
                  InputDokumentasi(
                      imagesProvider: imagesProvider,
                      controller: deskripsiController,
                      pageName: "inverter"),
                  TextInput(
                    controller: loadController,
                    label: "Load",
                    placeholder: "Load",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: inputACController,
                    label: "Input AC",
                    placeholder: "Input AC",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: inputDCController,
                    label: "Input DC",
                    placeholder: "Input DC",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: outputDCController,
                    label: "Output DC",
                    placeholder: "Output DC",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: mainfallController,
                    label: "Mainfall",
                    placeholder: "Mainfall",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hasil Uji",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  DropdownButtonFormField(
                    alignment: Alignment.centerLeft,
                    style: buttonText.copyWith(color: textDarkColor),
                    borderRadius: BorderRadius.circular(defaultRadius),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(defaultRadius),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        borderSide: BorderSide(width: 2, color: primaryBlue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                        borderSide: BorderSide(width: 2, color: neutral500),
                      ),
                      hintStyle: buttonText.copyWith(color: textDarkColor),
                    ),
                    items: listHasilPengujian
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                              ),
                            ))
                        .toList(),
                    value: hasilUji.isEmpty ? null : hasilUji,
                    onChanged: (value) {
                      hasilUji = value.toString();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: temuanController,
                    label: "Temuan",
                    placeholder: "Temuan",
                    isLongText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    isLongText: true,
                    controller: rekomendasiController,
                    label: "Rekomendasi",
                    placeholder: "Rekomendasi",
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultMargin + 32, vertical: 40),
                    child: CustomButton(
                        text: "Save",
                        onPressed: () async {
                          await InverterService().postInverter(
                              inverterId: widget.inverter.id,
                              pmId: widget.pm.id,
                              load: loadController.text,
                              inputAc: inputACController.text,
                              inputDc: inputDCController.text,
                              outputDc: outputDCController.text,
                              mainfall: mainfallController.text,
                              hasilUji: hasilUji,
                              temuan: temuanController.text,
                              rekomendasi: rekomendasiController.text);
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                              (route) => false);
                        },
                        color: primaryBlue,
                        clickColor: clickBlue),
                  )
                ],
              ),
            );
          }
        default:
          {
            return Scaffold();
          }
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Center(
            child: Container(
              margin: const EdgeInsets.only(right: 60),
              child: Text(
                widget.title,
                style: header2.copyWith(color: textLightColor),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            switchContent(),
            Expanded(child: buildContent()),
          ],
        ));
  }
}

class HomePageNav extends StatelessWidget {
  const HomePageNav({
    Key? key,
    required this.title,
    required this.index,
    required this.width,
  }) : super(key: key);

  final String title;
  final int index;
  final double width;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          pageProvider.setPmPage = index;
        },
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
              ),
              Container(
                margin: const EdgeInsets.only(top: 14),
                height: 3,
                width: width,
                decoration: BoxDecoration(
                  color:
                      pageProvider.pmPage == index ? primaryBlue : neutral500,
                  borderRadius: BorderRadius.circular(18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
