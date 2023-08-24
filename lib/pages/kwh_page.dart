import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/kwh_master_model.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class KWHPage extends StatelessWidget {
  const KWHPage({
    super.key,
    required this.kwh,
    required this.title,
  });
  final KwhMasterModel kwh;
  final String title;
  @override
  Widget build(BuildContext context) {
    TextEditingController deskripsiController = TextEditingController();

    TextEditingController rAmpereController = TextEditingController();

    TextEditingController sAmpereController = TextEditingController();

    TextEditingController tAmpereController = TextEditingController();

    TextEditingController rnVoltageController = TextEditingController();

    TextEditingController snVoltageController = TextEditingController();

    TextEditingController tnVoltageController = TextEditingController();
    TextEditingController bebanAcRController = TextEditingController();
    TextEditingController bebanAcSController = TextEditingController();
    TextEditingController bebanAcTController = TextEditingController();

    TextEditingController temuanController = TextEditingController();

    TextEditingController rekomendasiController = TextEditingController();
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    Widget input() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: rAmpereController,
                  label: "R (ampere)",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: sAmpereController,
                  label: "S (ampere)",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: tAmpereController,
                  label: "T (ampere)",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: rnVoltageController,
                  label: "R-N voltage",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: snVoltageController,
                  label: "S-N voltage",
                  suffixText: "V",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: tnVoltageController,
                  label: "T-N voltage",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: snVoltageController,
                  label: "N-G voltage",
                  suffixText: "V",
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: bebanAcRController,
                  label: "R Ampere",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: bebanAcSController,
                  label: "S Ampere",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: bebanAcTController,
                  label: "T Ampere",
                  suffixText: "A",
                ),
              ),
            ],
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
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false);
                },
                color: primaryBlue,
                clickColor: clickBlue),
          )
        ],
      );
    }

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
                    "Arester Type : ${kwh.aresterType}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Arester : ${kwh.arester}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cos : ${kwh.cos}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cos Type : ${kwh.cosType}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Jumlah Phasa : ${kwh.jumlahPhasa}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel G : ${kwh.warnaKabelG}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel N : ${kwh.warnaKabelN}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel S : ${kwh.warnaKabelS}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel R : ${kwh.warnaKabelR}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel T : ${kwh.warnaKabelT}",
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
              backgroundColor: Colors.white,
              body: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 20),
                  children: [
                    InputDokumentasi(
                      imagesProvider: imagesProvider,
                      controller: deskripsiController,
                      isKwhPage: true,
                      pageName: "kwh",
                    ),
                    Visibility(visible: inputCount == 1, child: input())
                  ]),
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
