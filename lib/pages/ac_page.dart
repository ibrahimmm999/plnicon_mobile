import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plnicon_mobile/models/master/ac_master_model.dart';
import 'package:plnicon_mobile/models/nilai/ac_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/master/ac_master_service.dart';
import 'package:plnicon_mobile/services/transaksional/ac_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class ACPage extends StatefulWidget {
  const ACPage({
    super.key,
    required this.acMaster,
    required this.pm,
    required this.title,
  });
  final AcMasterModel acMaster;
  final PmModel pm;
  final String title;

  @override
  State<ACPage> createState() => _ACPageState();
}

class _ACPageState extends State<ACPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  getinit() async {
    // if (await TransaksionalProvider().getAc(widget.pm.id, widget.acMaster.id)) {
    //   suhu = TransaksionalProvider().currentAc.suhuAc;
    //   pengujian = TransaksionalProvider().currentAc.hasilPengujian;
    //   temuan = TransaksionalProvider().currentAc.temuan;
    //   rekomendasi = TransaksionalProvider().currentAc.rekomendasi;
    // }
  }

  String pengujian = "";

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

    TextEditingController suhuController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController namaAcController =
        TextEditingController(text: widget.acMaster.nama);
    TextEditingController kondisiController =
        TextEditingController(text: widget.acMaster.kondisi);
    TextEditingController merkController =
        TextEditingController(text: widget.acMaster.merk);
    TextEditingController kapasitasController =
        TextEditingController(text: widget.acMaster.kapasitas);
    TextEditingController tekananFreonController =
        TextEditingController(text: widget.acMaster.tekananFreon);
    TextEditingController modeHidupController =
        TextEditingController(text: widget.acMaster.modeHidup);
    TextEditingController tanggalInstalasiController = TextEditingController();

    List<String> listHasilPengujian = ["Ok", "Not OK"];
    PageProvider pageProvider = Provider.of<PageProvider>(context);
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
                    "Nama",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  TextInput(controller: namaAcController),
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
                    "Tekanan Freon",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  TextInput(controller: tekananFreonController),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Mode Hidup",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  TextInput(controller: modeHidupController),
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
                      onPressed: () async {
                        await AcMasterService().editAcMaster(
                          popId: widget.acMaster.popId,
                          acId: widget.acMaster.id,
                          nama: namaAcController.text,
                          kondisi: kondisiController.text,
                          merk: merkController.text,
                          kapasitas: kapasitasController.text,
                          tekananFreon: tekananFreonController.text,
                          modeHidup: modeHidupController.text,
                        );
                      },
                      color: primaryGreen,
                      clickColor: clickGreen)
                ],
              ),
            );
          }
        case 1:
          {
            return Scaffold(
                body: ListView(
              padding: EdgeInsets.all(defaultMargin),
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultRadius),
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
                                style:
                                    buttonText.copyWith(color: textDarkColor),
                              ),
                            )
                          : ListView(
                              scrollDirection: Axis.horizontal,
                              children: imagesProvider.foto.entries.map((e) {
                                return Container(
                                  width: 240,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                    children: [
                                      Image.file(
                                        File(e.key),
                                        height: 240,
                                        width: 240,
                                        fit: BoxFit.cover,
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
                            borderRadius: BorderRadius.circular(defaultRadius)),
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
                Padding(
                  padding: const EdgeInsets.only(right: 120, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInput(
                          controller: suhuController,
                          label: "Suhu",
                          placeholder: "Suhu",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 8),
                        child: Text(
                          "°C",
                          style: GoogleFonts.montserrat(
                              color: textDarkColor,
                              fontSize: 24,
                              fontWeight: medium),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "Hasil Pengujian",
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
                  value: pengujian.isEmpty ? null : pengujian,
                  onChanged: (value) {
                    pengujian = value.toString();
                    // setState(() {});
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
                        AcNilaiModel ac = await AcService().postAc(
                            acId: widget.acMaster.id,
                            pmId: widget.pm.id,
                            suhuAc: int.parse(suhuController.text),
                            hasilPengujian: pengujian,
                            temuan: temuanController.text,
                            rekomendasi: rekomendasiController.text);
                        // ignore: avoid_print
                        print("AC : $ac");
                        imagesProvider.foto.forEach((key, value) async {
                          await AcService().postFotoAc(
                              acNilaiId: 199, urlFoto: key, description: value);
                        });
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      color: primaryGreen,
                      clickColor: clickGreen),
                )
              ],
            ));
          }
        default:
          {
            return const Scaffold();
          }
      }
    }

    return Scaffold(
        appBar: CustomAppBar(isMainPage: false, title: widget.title),
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
