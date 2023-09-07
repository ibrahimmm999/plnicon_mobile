import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/baterai_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class BateraiPage extends StatefulWidget {
  const BateraiPage({
    super.key,
    required this.bateraiMaster,
    required this.pm,
    required this.title,
  });
  final BateraiMasterModel bateraiMaster;
  final PmModel pm;
  final String title;
  @override
  State<BateraiPage> createState() => _BateraiPageState();
}

class _BateraiPageState extends State<BateraiPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  getinit() async {}
  @override
  Widget build(BuildContext context) {
    TextEditingController loadController = TextEditingController();
    TextEditingController groupVBankController = TextEditingController();
    TextEditingController cellv1Controller = TextEditingController();
    TextEditingController cellv2Controller = TextEditingController();
    TextEditingController cellv3Controller = TextEditingController();
    TextEditingController cellv4Controller = TextEditingController();
    TextEditingController timeDischargeController = TextEditingController();
    TextEditingController stopUjiBateraiController = TextEditingController();
    TextEditingController performanceController = TextEditingController();
    TextEditingController sisaKapasitasController = TextEditingController();
    TextEditingController kemampuanBackUpTimeController =
        TextEditingController();
    TextEditingController jumlahBateraiRusakController =
        TextEditingController();
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
                    "Nama : ${widget.bateraiMaster.nama}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk : ${widget.bateraiMaster.merk}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kapasitas : ${widget.bateraiMaster.kapasitas}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Persentase : ${widget.bateraiMaster.persentase}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SN : ${widget.bateraiMaster.sn}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tanggal Uji : ${widget.bateraiMaster.tanggalUji}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tipe : ${widget.bateraiMaster.tipe}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "V Batterai : ${widget.bateraiMaster.vBatt}",
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
                      pageName: "baterai"),
                  TextInput(
                    controller: loadController,
                    label: "Load",
                    placeholder: "Load",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: groupVBankController,
                    label: "Group V bank",
                    placeholder: "Group V bank",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: cellv1Controller,
                    label: "Cell V1",
                    placeholder: "Cell V1",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: cellv2Controller,
                    label: "Cell V2",
                    placeholder: "Cell V2",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: cellv3Controller,
                    label: "Cell V3",
                    placeholder: "Cell V3",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: cellv4Controller,
                    label: "Cell V4",
                    placeholder: "Cell V4",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: timeDischargeController,
                    label: "Time Discharge",
                    placeholder: "Time Discharge",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: stopUjiBateraiController,
                    label: "Stop Uji Baterai",
                    placeholder: "Stop Uji Baterai",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: performanceController,
                    label: "Performance",
                    placeholder: "Performance",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: sisaKapasitasController,
                    label: "Sisa Kapasitas",
                    placeholder: "Sisa Kapasitas",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: kemampuanBackUpTimeController,
                    label: "Kemampuan Backup Time",
                    placeholder: "Kemampuan Backup Time",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: jumlahBateraiRusakController,
                    label: "Jumlah Baterai Rusak",
                    placeholder: "Jumlah Baterai Rusak",
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
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
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
