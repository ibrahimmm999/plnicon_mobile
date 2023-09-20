import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/kwh_master_model.dart';
import 'package:plnicon_mobile/models/nilai/kwh_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_kwh_page.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/pages/photo_view_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/services/transaksional/kwh_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class KWHPage extends StatefulWidget {
  const KWHPage({
    super.key,
    required this.kwh,
    required this.title,
    required this.pm,
  });
  final KwhMasterModel kwh;
  final PmModel pm;
  final String title;

  @override
  State<KWHPage> createState() => _KWHPageState();
}

class _KWHPageState extends State<KWHPage> {
  @override
  Widget build(BuildContext context) {
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    Future<void> handlePicker() async {
      imagesProvider.setCroppedImageFile = null;
      await imagesProvider.pickImage();
      await imagesProvider.cropImage(
          imageFile: imagesProvider.imageFile, key: "");
      setState(() {
        if (imagesProvider.croppedImagePath.isNotEmpty) {
          contentPath = imagesProvider.croppedImagePath;
          contentFile = imagesProvider.croppedImageFile;
        }
      });
    }

    TextEditingController deskripsiController = TextEditingController();

    TextEditingController rnVoltageController = TextEditingController();

    TextEditingController snVoltageController = TextEditingController();
    TextEditingController ngVoltageController = TextEditingController();

    TextEditingController tnVoltageController = TextEditingController();
    TextEditingController bebanAcRController = TextEditingController();
    TextEditingController bebanAcSController = TextEditingController();
    TextEditingController bebanAcTController = TextEditingController();

    TextEditingController temuanController = TextEditingController();

    TextEditingController rAmpereController = TextEditingController();

    TextEditingController sAmpereController = TextEditingController();

    TextEditingController tAmpereController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    PageProvider pageProvider = Provider.of<PageProvider>(context);
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
                  controller: ngVoltageController,
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
                onPressed: () async {
                  KwhNilaiModel kwhInput = await KwhService().postKwh(
                      kwhId: widget.kwh.id,
                      pmId: widget.pm.id,
                      vrn: double.parse(rnVoltageController.text),
                      vsn: double.parse(snVoltageController.text),
                      vtn: double.parse(tnVoltageController.text),
                      vng: double.parse(ngVoltageController.text),
                      vrs: double.parse(bebanAcSController.text),
                      vrt: double.parse(bebanAcRController.text),
                      vst: double.parse(bebanAcTController.text),
                      loadr: double.parse(rAmpereController.text),
                      loads: double.parse(sAmpereController.text),
                      loadt: double.parse(tAmpereController.text),
                      temuan: temuanController.text,
                      rekomendasi: rekomendasiController.text);
                  imagesProvider.foto.forEach((key, value) async {
                    await KwhService().postFotoKwh(
                        kwhNilaiId: kwhInput.id,
                        urlFoto: key,
                        description: deskripsiController.text);
                  });
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
                    "Arester Type : ${widget.kwh.aresterType}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Arester : ${widget.kwh.arester}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cos : ${widget.kwh.cos}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Cos Type : ${widget.kwh.cosType}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Jumlah Phasa : ${widget.kwh.jumlahPhasa}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "capmcbr : ${widget.kwh.capmcbr}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "capmcbs : ${widget.kwh.capmcbs}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "capmcbt : ${widget.kwh.capmcbt}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel G : ${widget.kwh.warnaKabelG}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel N : ${widget.kwh.warnaKabelN}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel S : ${widget.kwh.warnaKabelS}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel R : ${widget.kwh.warnaKabelR}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Warna Kabel T : ${widget.kwh.warnaKabelT}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Luas Kabel R : ${widget.kwh.luasKabelR}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Luas Kabel S : ${widget.kwh.luasKabelS}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Luas Kabel T : ${widget.kwh.luasKabelT}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Luas Kabel N : ${widget.kwh.luasKabelN}",
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
                  CustomButton(
                      text: "Edit",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditKwhPage(
                                    kwh: widget.kwh, title: "Edit KWH")));
                      },
                      color: primaryBlue,
                      clickColor: clickBlue)
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
                    // InputDokumentasi(
                    //   imagesProvider: imagesProvider,
                    //   controller: deskripsiController,
                    //   isKwhPage: true,
                    //   pageName: "kwh",
                    // ),
                    // Visibility(visible: inputCount == 0, child: input())
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius),
                              border: Border.all(
                                width: 2,
                                color: neutral500,
                              )),
                          height: 360,
                          width: double.infinity,
                          child: imagesProvider.foto.isEmpty
                              ? Center(
                                  child: Text(
                                    "Foto",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                )
                              : ListView(
                                  scrollDirection: Axis.horizontal,
                                  children:
                                      imagesProvider.foto.entries.map((e) {
                                    return Container(
                                      width: 240,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        PhotoViewPage(
                                                            foto: e.key,
                                                            description:
                                                                e.value)),
                                              );
                                            },
                                            child: Image.file(
                                              File(e.key),
                                              height: 240,
                                              width: 240,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                            e.value,
                                            style: buttonText.copyWith(
                                                color: textDarkColor),
                                            overflow: TextOverflow.clip,
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (context) => CustomPopUp(
                                  title: "Deskripsi",
                                  controller: deskripsiController,
                                  add: () {
                                    imagesProvider.addDeskripsi(
                                        path: contentPath,
                                        deskripsi: deskripsiController.text);
                                    deskripsiController.clear();
                                  },
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: primaryBlue,
                                borderRadius:
                                    BorderRadius.circular(defaultRadius)),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tambah Foto",
                                  style: buttonText,
                                ),
                                Icon(
                                  Icons.photo_camera_outlined,
                                  color: textLightColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    input()
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
