import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/genset_master_model.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class GensetPage extends StatelessWidget {
  const GensetPage(
      {super.key, required this.gensetMasterModel, required this.title});
  final GensetMasterModel gensetMasterModel;
  final String title;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController fuelController = TextEditingController();
    TextEditingController hourMeterController = TextEditingController();
    TextEditingController teganganAccuController = TextEditingController();
    TextEditingController teganganChargerController = TextEditingController();
    TextEditingController arusChargerController = TextEditingController();
    TextEditingController tempOnController = TextEditingController();
    TextEditingController ujiBebanVoltController = TextEditingController();
    TextEditingController ujiBebanArusController = TextEditingController();
    TextEditingController ujiTanpaBebanArusController = TextEditingController();
    TextEditingController ujiTanpaBebanVoltController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
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
                    "Merk : ${gensetMasterModel.merk}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SN : ${gensetMasterModel.sn}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Accu : ${gensetMasterModel.accu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Bahan Bakar : ${gensetMasterModel.bahanBakar}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kapasitas : ${gensetMasterModel.kapasitas}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Max Fuel : ${gensetMasterModel.maxFuel}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Accu : ${gensetMasterModel.merkAccu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Engine : ${gensetMasterModel.merkEngine}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Genset : ${gensetMasterModel.merkGen}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Switch : ${gensetMasterModel.switchGenset}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tipe Batt Charger : ${gensetMasterModel.tipeBattCharger}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
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
                      controller: deskripsiController, pageName: "genset"),
                  TextInput(
                    controller: fuelController,
                    label: "Fuel",
                    placeholder: "Fuel",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: hourMeterController,
                    label: "Hour Meter",
                    placeholder: "Hour Meter",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: teganganAccuController,
                    label: "Tegangan Accu",
                    placeholder: "Tegangan Accu",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: teganganChargerController,
                    label: "Tegangan Charger",
                    placeholder: "Tegangan Charger",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: arusChargerController,
                    label: "Arus Charger",
                    placeholder: "Arus Charger",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: tempOnController,
                    label: "Temp On",
                    placeholder: "Temp On",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: ujiBebanVoltController,
                    label: "Uji Beban Volt",
                    placeholder: "Uji Beban Volt",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: ujiBebanArusController,
                    label: "Uji Beban Arus",
                    placeholder: "Uji Beban Arus",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: ujiTanpaBebanVoltController,
                    label: "Uji Tanpa Beban Volt",
                    placeholder: "Uji Tanpa Beban Volt",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: ujiTanpaBebanArusController,
                    label: "Uji Tanpa Beban Arus",
                    placeholder: "Uji Tanpa Beban Arus",
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
                        onPressed: () {
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
            return const Scaffold();
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
                title,
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
