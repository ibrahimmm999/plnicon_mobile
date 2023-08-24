import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/environment_master_model.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_dropdown.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EnvironmentPage extends StatelessWidget {
  const EnvironmentPage({
    super.key,
    required this.environment,
    required this.title,
  });
  final EnvironmentMasterModel environment;
  final String title;
  @override
  Widget build(BuildContext context) {
    TextEditingController exhaustController = TextEditingController();
    TextEditingController kesehatanExhaustController = TextEditingController();
    TextEditingController lampuController = TextEditingController();
    TextEditingController jumlahLampuController = TextEditingController();
    TextEditingController kesehatanBangunanController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
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
                    "Bangunan : ${environment.bangunan}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Exhaust : ${environment.exhaust}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Jumlah Lampu : ${environment.jumlahLampu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Jumlah Lampu Menyala : ${environment.lampu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Suhu Ruangan : ${environment.suhuRuangan} °C",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kebersihan Bangunan : ${environment.kebersihanBangunan}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kebersihan Exhaust : ${environment.kebersihanExhaust}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Temuan : ${environment.temuan}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Rekomendasi : ${environment.rekomendasi}",
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
                      imagesProvider: imagesProvider,
                      controller: deskripsiController,
                      pageName: "environment"),
                  TextInput(
                    controller: exhaustController,
                    label: "Exhaust",
                    placeholder: "Exhaust",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: kesehatanExhaustController,
                    label: "Kesehatan Exhaust",
                    placeholder: "Kesehatan Exhaust",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: lampuController,
                    label: "Lampu",
                    placeholder: "Lampu",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: jumlahLampuController,
                    label: "Jumlah Lampu",
                    placeholder: "Jumlah Lampu",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Bangunan",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const CustomDropDown(
                    list: ["OK", "B Aja", "Buruk"],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: kesehatanBangunanController,
                    label: "Kesehatan Bangunan",
                    placeholder: "Kesehatan Bangunan",
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
