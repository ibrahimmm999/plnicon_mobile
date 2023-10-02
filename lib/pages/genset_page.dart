import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/genset_master_model.dart';
import 'package:plnicon_mobile/models/nilai/genset_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_genset_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/transaksional/genset_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class GensetPage extends StatefulWidget {
  const GensetPage(
      {super.key,
      required this.gensetMasterModel,
      required this.title,
      required this.pm});
  final GensetMasterModel gensetMasterModel;
  final String title;
  final PmModel pm;

  @override
  State<GensetPage> createState() => _GensetPageState();
}

class _GensetPageState extends State<GensetPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  String fotoTampakDepan = "";
  String fotoTampakSamping = "";
  String fotoLevelBBM = "";
  String fotojumlahJamRunning = "";
  String fotoTeganganAccuSebelumRunning = "";
  String fotoPembersihanBagianDalam = "";
  String fotoPembersihanAreaSekitar = "";
  String fotoTeganganChargingAccu = "";
  String fotoAtsSaatFailOver = "";
  String fotoTeganganGensetDenganBeban = "";
  String fotoArusGensetDenganBeban = "";
  String fotoTemperaturGenset = "";
  String fotoPLNOn = "";
  String fotoAtsGensetOnManual = "";
  String fotoTeganganGensetTanpaBeban = "";
  String fotoArusGensetTanpaBeban = "";
  String fotoArusChargingAccu = "";
  bool loadingGenset = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider gensetProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await gensetProvider.getGenset(
            widget.pm.id, widget.gensetMasterModel.id);
        if (gensetProvider.listGenset.isNotEmpty) {
          for (var element in gensetProvider.listGenset.first.foto!) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");
            if (element.deskripsi == "Foto Tampak Depan") {
              fotoTampakDepan = url;
            } else if (element.deskripsi == "Foto Tampak Samping") {
              fotoTampakSamping = url;
            } else if (element.deskripsi == "Foto Level BBM") {
              fotoLevelBBM = url;
            } else if (element.deskripsi == "Jumlah Jam Running") {
              fotojumlahJamRunning = url;
            } else if (element.deskripsi == "Tegangan Accu Sebelum Running") {
              fotoTeganganAccuSebelumRunning = url;
            } else if (element.deskripsi == "Pembersihan Bagian Dalam") {
              fotoPembersihanBagianDalam = url;
            } else if (element.deskripsi == "Pembersihan Area Sekitar") {
              fotoPembersihanAreaSekitar = url;
            } else if (element.deskripsi == "Tegangan Charging Accu") {
              fotoTeganganChargingAccu = url;
            } else if (element.deskripsi == "Foto ATS Saat Fail Over") {
              fotoAtsSaatFailOver = url;
            } else if (element.deskripsi == "Tegangan Genset Dengan Beban") {
              fotoTeganganGensetDenganBeban = url;
            } else if (element.deskripsi == "Arus Genset Dengan Beban") {
              fotoArusGensetDenganBeban = url;
            } else if (element.deskripsi == "Temperatur Genset") {
              fotoTemperaturGenset = url;
            } else if (element.deskripsi == "Foto PLN ON") {
              fotoPLNOn = url;
            } else if (element.deskripsi == "Foto ATS Genset On Manual") {
              fotoAtsGensetOnManual = url;
            } else if (element.deskripsi == "Tegangan Genset Tanpa Beban") {
              fotoTeganganGensetTanpaBeban = url;
            } else if (element.deskripsi == "Arus Genset Tanpa Beban") {
              fotoArusGensetTanpaBeban = url;
            } else if (element.deskripsi == "Arus Charging Accu") {
              fotoArusChargingAccu = url;
            }
            imagesProvider.foto[url] = element.deskripsi;
          }
        }
      }
    }
    setState(() {
      loadingGenset = false;
    });
    print(loadingGenset);
  }

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

    PageProvider pageProvider = Provider.of<PageProvider>(context);
    TransaksionalProvider gensetProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController fuelController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.fuel.toString());
    TextEditingController hourMeterController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.hourMeter.toString());
    TextEditingController teganganAccuController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.teganganAccu.toString());
    TextEditingController teganganChargerController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.teganganCharger.toString());
    TextEditingController arusChargerController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.arusCharger.toString());
    TextEditingController tempOnController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.tempOn.toString());
    TextEditingController ujiBebanVoltController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.ujiBebanVolt.toString());
    TextEditingController ujiBebanArusController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.ujiBebanArus.toString());
    TextEditingController ujiTanpaBebanArusController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.ujiTanpaBebanArus.toString());
    TextEditingController ujiTanpaBebanVoltController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.ujiTanpaBebanVolt.toString());
    TextEditingController failOverTestController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.failOverTest.toString());
    TextEditingController indoorCleanController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.indoorClean.toString());
    TextEditingController outdoorCleanController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.outdoorClean.toString());
    TextEditingController kartuGantungUrlController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.kartuGantungUrl.toString());
    TextEditingController temuanController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.temuan.toString());
    TextEditingController rekomendasiController = TextEditingController(
        text: gensetProvider.listGenset.isEmpty
            ? ""
            : gensetProvider.listGenset.last.rekomendasi.toString());

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

    Widget dokumentasi() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            margin: const EdgeInsets.only(bottom: 20),
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
                      style: buttonText.copyWith(color: textDarkColor),
                    ),
                  )
                : ListView(
                    scrollDirection: Axis.horizontal,
                    children: imagesProvider.foto.entries.map((e) {
                      return Container(
                        width: 240,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
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
                              style: buttonText.copyWith(color: textDarkColor),
                              overflow: TextOverflow.clip,
                            )
                          ],
                        ),
                      );
                    }).toList()),
          ),
          Text(
            "Foto Tampak Depan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoTampakDepan.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath, deskripsi: "Foto Tampak Depan");
                      fotoTampakDepan = contentPath;
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoTampakDepan.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Foto Tampak Depan");
                                fotoTampakDepan = contentPath;
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoTampakDepan
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(context,
                                      Image.network(fotoTampakDepan).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(context,
                                      Image.file(File(fotoTampakDepan)).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoTampakDepan.isEmpty
                            ? "Tambah Foto"
                            : fotoTampakDepan,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: fotoTampakDepan.isEmpty,
                    child: Icon(
                      Icons.photo_camera_outlined,
                      color: textLightColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "Foto Tampak Samping",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoTampakSamping.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath, deskripsi: "Foto Tampak Samping");
                      fotoTampakSamping = contentPath;
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoTampakSamping.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Foto Tampak Samping");
                                fotoTampakSamping = contentPath;
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoTampakSamping
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(context,
                                      Image.network(fotoTampakSamping).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(context,
                                      Image.file(File(fotoTampakSamping)).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoTampakSamping.isEmpty
                            ? "Tambah Foto"
                            : fotoTampakSamping,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: fotoTampakSamping.isEmpty,
                    child: Icon(
                      Icons.photo_camera_outlined,
                      color: textLightColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "Foto Level BBM",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoLevelBBM.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath, deskripsi: "Foto Level BBM");
                      fotoLevelBBM = contentPath;
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoLevelBBM.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Foto Level BBM");
                                fotoLevelBBM = contentPath;
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoLevelBBM
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(context,
                                      Image.network(fotoLevelBBM).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(context,
                                      Image.file(File(fotoLevelBBM)).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoLevelBBM.isEmpty ? "Tambah Foto" : fotoLevelBBM,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: fotoLevelBBM.isEmpty,
                    child: Icon(
                      Icons.photo_camera_outlined,
                      color: textLightColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "Foto Jumlah Jam Running",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotojumlahJamRunning.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath, deskripsi: "Jumlah Jam Running");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotojumlahJamRunning = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotojumlahJamRunning.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Jumlah Jam Running");
                                fotojumlahJamRunning = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotojumlahJamRunning
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(context,
                                      Image.network(fotojumlahJamRunning).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(fotojumlahJamRunning))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotojumlahJamRunning.isEmpty
                            ? "Tambah Foto"
                            : fotojumlahJamRunning,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotojumlahJamRunning.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotojumlahJamRunning);
                              fotojumlahJamRunning = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Jumlah Jam Running");
                              fotojumlahJamRunning = contentPath;
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotojumlahJamRunning.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Tegangan Accu Sebelum Running",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoTeganganAccuSebelumRunning.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Tegangan Accu Sebelum Running");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoTeganganAccuSebelumRunning = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoTeganganAccuSebelumRunning.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Tegangan Accu Sebelum Running");
                                fotoTeganganAccuSebelumRunning = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoTeganganAccuSebelumRunning
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(
                                              fotoTeganganAccuSebelumRunning)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(
                                              fotoTeganganAccuSebelumRunning))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoTeganganAccuSebelumRunning.isEmpty
                            ? "Tambah Foto"
                            : fotoTeganganAccuSebelumRunning,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoTeganganAccuSebelumRunning.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoTeganganAccuSebelumRunning);
                              fotoTeganganAccuSebelumRunning = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Tegangan Accu Sebelum Running");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoTeganganAccuSebelumRunning = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoTeganganAccuSebelumRunning.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Pembersihan Bagian Dalam",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoPembersihanBagianDalam.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Pembersihan Bagian Dalam");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoPembersihanBagianDalam = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoPembersihanBagianDalam.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Pembersihan Bagian Dalam");
                                fotoPembersihanBagianDalam = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoPembersihanBagianDalam
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(fotoPembersihanBagianDalam)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(
                                              File(fotoPembersihanBagianDalam))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoPembersihanBagianDalam.isEmpty
                            ? "Tambah Foto"
                            : fotoPembersihanBagianDalam,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoPembersihanBagianDalam.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoPembersihanBagianDalam);
                              fotoPembersihanBagianDalam = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Pembersihan Bagian Dalam");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoPembersihanBagianDalam = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoPembersihanBagianDalam.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Pembersihan Area Sekitar",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoPembersihanAreaSekitar.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Pembersihan Area Sekitar");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoPembersihanAreaSekitar = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoPembersihanAreaSekitar.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Pembersihan Area Sekitar");
                                fotoPembersihanAreaSekitar = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoPembersihanAreaSekitar
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(fotoPembersihanAreaSekitar)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(
                                              File(fotoPembersihanAreaSekitar))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoPembersihanAreaSekitar.isEmpty
                            ? "Tambah Foto"
                            : fotoPembersihanAreaSekitar,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoPembersihanAreaSekitar.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoPembersihanAreaSekitar);
                              fotoPembersihanAreaSekitar = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Pembersihan Area Sekitar");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoPembersihanAreaSekitar = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoPembersihanAreaSekitar.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Tegangan Charging Accu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoTeganganChargingAccu.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Tegangan Charging Accu");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoTeganganChargingAccu = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoTeganganChargingAccu.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Tegangan Charging Accu");
                                fotoTeganganChargingAccu = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoTeganganChargingAccu
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(fotoTeganganChargingAccu)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(fotoTeganganChargingAccu))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoTeganganChargingAccu.isEmpty
                            ? "Tambah Foto"
                            : fotoTeganganChargingAccu,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoTeganganChargingAccu.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoTeganganChargingAccu);
                              fotoTeganganChargingAccu = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Tegangan Charging Accu");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoTeganganChargingAccu = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoTeganganChargingAccu.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto ATS Saat Fail Over",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoAtsSaatFailOver.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Foto ATS Saat Fail Over");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoAtsSaatFailOver = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoAtsSaatFailOver.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Foto ATS Saat Fail Over");
                                fotoAtsSaatFailOver = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoAtsSaatFailOver
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(context,
                                      Image.network(fotoAtsSaatFailOver).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(fotoAtsSaatFailOver))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoAtsSaatFailOver.isEmpty
                            ? "Tambah Foto"
                            : fotoAtsSaatFailOver,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoAtsSaatFailOver.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoAtsSaatFailOver);
                              fotoAtsSaatFailOver = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto ATS Saat Fail Over");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoAtsSaatFailOver = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoAtsSaatFailOver.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Tegangan Genset Dengan Beban",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoTeganganGensetDenganBeban.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Tegangan Genset Dengan Beban");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoTeganganGensetDenganBeban = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoTeganganGensetDenganBeban.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Tegangan Genset Dengan Beban");
                                fotoTeganganGensetDenganBeban = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoTeganganGensetDenganBeban
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(
                                              fotoTeganganGensetDenganBeban)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(
                                              fotoTeganganGensetDenganBeban))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoTeganganGensetDenganBeban.isEmpty
                            ? "Tambah Foto"
                            : fotoTeganganGensetDenganBeban,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoTeganganGensetDenganBeban.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoTeganganGensetDenganBeban);
                              fotoTeganganGensetDenganBeban = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Tegangan Genset Dengan Beban");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoTeganganGensetDenganBeban = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoTeganganGensetDenganBeban.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Arus Genset Dengan Beban",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoArusGensetDenganBeban.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Arus Genset Dengan Beban");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoArusGensetDenganBeban = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoArusGensetDenganBeban.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Arus Genset Dengan Beban");
                                fotoArusGensetDenganBeban = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoArusGensetDenganBeban
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(fotoArusGensetDenganBeban)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(
                                              File(fotoArusGensetDenganBeban))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoArusGensetDenganBeban.isEmpty
                            ? "Tambah Foto"
                            : fotoArusGensetDenganBeban,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoArusGensetDenganBeban.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoArusGensetDenganBeban);
                              fotoArusGensetDenganBeban = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Arus Genset Dengan Beban");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoArusGensetDenganBeban = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoArusGensetDenganBeban.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Temperatur Genset",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoTemperaturGenset.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath, deskripsi: "Temperatur Genset");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoTemperaturGenset = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoTemperaturGenset.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Temperatur Genset");
                                fotoTemperaturGenset = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoTemperaturGenset
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(context,
                                      Image.network(fotoTemperaturGenset).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(fotoTemperaturGenset))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoTemperaturGenset.isEmpty
                            ? "Tambah Foto"
                            : fotoTemperaturGenset,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoTemperaturGenset.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoTemperaturGenset);
                              fotoTemperaturGenset = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Temperatur Genset");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoTemperaturGenset = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoTemperaturGenset.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto PLN On",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoPLNOn.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath, deskripsi: "Foto PLN On");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoPLNOn = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoPLNOn.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Foto PLN On");
                                fotoPLNOn = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoPLNOn.contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context, Image.network(fotoPLNOn).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(context,
                                      Image.file(File(fotoPLNOn)).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoPLNOn.isEmpty ? "Tambah Foto" : fotoPLNOn,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoPLNOn.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(path: fotoPLNOn);
                              fotoPLNOn = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath, deskripsi: "Foto PLN On");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoPLNOn = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoPLNOn.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto ATS Genset On Manual",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoAtsGensetOnManual.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Foto ATS Genset On Manual");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoAtsGensetOnManual = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoAtsGensetOnManual.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Foto ATS Genset On Manual");
                                fotoAtsGensetOnManual = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoAtsGensetOnManual
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(fotoAtsGensetOnManual)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(fotoAtsGensetOnManual))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoAtsGensetOnManual.isEmpty
                            ? "Tambah Foto"
                            : fotoAtsGensetOnManual,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoAtsGensetOnManual.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoAtsGensetOnManual);
                              fotoAtsGensetOnManual = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto ATS Genset On Manual");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoAtsGensetOnManual = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoAtsGensetOnManual.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Tegangan Genset Tanpa Beban",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoTeganganGensetTanpaBeban.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Tegangan Genset Tanpa Beban");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoTeganganGensetTanpaBeban = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoTeganganGensetTanpaBeban.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Tegangan Genset Tanpa Beban");
                                fotoTeganganGensetTanpaBeban = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoTeganganGensetTanpaBeban
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(
                                              fotoTeganganGensetTanpaBeban)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(
                                              fotoTeganganGensetTanpaBeban))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoTeganganGensetTanpaBeban.isEmpty
                            ? "Tambah Foto"
                            : fotoTeganganGensetTanpaBeban,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoTeganganGensetTanpaBeban.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoTeganganGensetTanpaBeban);
                              fotoTeganganGensetTanpaBeban = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Tegangan Genset Tanpa Beban");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoTeganganGensetTanpaBeban = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoTeganganGensetTanpaBeban.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Arus Genset Tanpa Beban",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoArusGensetTanpaBeban.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath,
                          deskripsi: "Arus Genset Tanpa Beban");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoArusGensetTanpaBeban = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoArusGensetTanpaBeban.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Arus Genset Tanpa Beban");
                                fotoArusGensetTanpaBeban = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoArusGensetTanpaBeban
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(
                                      context,
                                      Image.network(fotoArusGensetTanpaBeban)
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(fotoArusGensetTanpaBeban))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoArusGensetTanpaBeban.isEmpty
                            ? "Tambah Foto"
                            : fotoArusGensetTanpaBeban,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoArusGensetTanpaBeban.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoArusGensetTanpaBeban);
                              fotoArusGensetTanpaBeban = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Arus Genset Tanpa Beban");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoArusGensetTanpaBeban = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoArusGensetTanpaBeban.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Foto Arus Charging Accu",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          GestureDetector(
            onTap: fotoArusChargingAccu.isEmpty
                ? () async {
                    await handlePicker();
                    if (imagesProvider.croppedImageFile != null) {
                      imagesProvider.addDeskripsi(
                          path: contentPath, deskripsi: "Arus Charging Accu");
                      // imagesProvider.listFoto[contentPath] =
                      //     imagesProvider.foto;
                      fotoArusChargingAccu = contentPath;
                      print(imagesProvider.foto);
                      deskripsiController.clear();
                    }
                  }
                : () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              decoration: BoxDecoration(
                  color: primaryBlue,
                  borderRadius: BorderRadius.circular(defaultRadius)),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: fotoArusChargingAccu.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Arus Charging Accu");
                                fotoArusChargingAccu = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {
                              fotoArusChargingAccu
                                      .contains("https://jakban.iconpln.co.id")
                                  ? showImageViewer(context,
                                      Image.network(fotoArusChargingAccu).image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true)
                                  : showImageViewer(
                                      context,
                                      Image.file(File(fotoArusChargingAccu))
                                          .image,
                                      swipeDismissible: true,
                                      doubleTapZoomable: true);
                            },
                      child: Text(
                        fotoArusChargingAccu.isEmpty
                            ? "Tambah Foto"
                            : fotoArusChargingAccu,
                        style: buttonText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: fotoArusChargingAccu.isNotEmpty
                        ? () {
                            setState(() {
                              imagesProvider.deleteImage(
                                  path: fotoArusChargingAccu);
                              fotoArusChargingAccu = "";
                            });
                          }
                        : () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Arus Charging Accu");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoArusChargingAccu = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          },
                    child: Visibility(
                      visible: fotoArusChargingAccu.isEmpty,
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: textLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "Tambahan Foto",
            style: buttonText.copyWith(color: textDarkColor),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 20, top: 4),
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
                    "Merk : ${widget.gensetMasterModel.merk}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SN : ${widget.gensetMasterModel.sn}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Accu : ${widget.gensetMasterModel.accu.toString()}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Bahan Bakar : ${widget.gensetMasterModel.bahanBakar}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kapasitas : ${widget.gensetMasterModel.kapasitas}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Max Fuel : ${widget.gensetMasterModel.maxFuel}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Accu : ${widget.gensetMasterModel.merkAccu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Engine : ${widget.gensetMasterModel.merkEngine}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Genset : ${widget.gensetMasterModel.merkGen}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Switch : ${widget.gensetMasterModel.switchGenset}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tipe Batt Charger : ${widget.gensetMasterModel.switchGenset}",
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
                    height: 32,
                  ),
                  CustomButton(
                      text: "Edit Data",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditGensetPage(
                                    gensetMasterModel: widget.gensetMasterModel,
                                    title: "Edit Genset")));
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
        case 1:
          {
            return Scaffold(
              body: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: 20),
                children: [
                  dokumentasi(),
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
                    controller: indoorCleanController,
                    label: "Indoor Clean",
                    placeholder: "Indoor Clean",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: outdoorCleanController,
                    label: "Outdoor Clean",
                    placeholder: "Outdoor Clean",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: failOverTestController,
                    label: "Fail Over Test",
                    placeholder: "Fail Over Test",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: kartuGantungUrlController,
                    label: "Kartu Gantung Url",
                    placeholder: "Kartu Gantung Url",
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
                          GensetNilaiModel gen = await GensetService()
                              .postGenset(
                                  gensetId: widget.gensetMasterModel.id,
                                  pmId: widget.pm.id,
                                  fuel: int.parse(fuelController.text),
                                  hourMeter:
                                      double.parse(hourMeterController.text),
                                  teganganAccu:
                                      double.parse(teganganAccuController.text),
                                  teganganCharger:
                                      double.parse(
                                          teganganChargerController.text),
                                  arusCharger: double.parse(arusChargerController
                                      .text),
                                  failOverTest: failOverTestController.text,
                                  tempOn: double.parse(tempOnController.text),
                                  ujiBebanVolt:
                                      double.parse(ujiBebanVoltController.text),
                                  ujiBebanArus:
                                      double.parse(ujiBebanArusController.text),
                                  ujiTanpaBebanVolt:
                                      double.parse(ujiTanpaBebanVoltController
                                          .text),
                                  ujiTanpaBebanArus: double.parse(
                                      ujiTanpaBebanArusController.text),
                                  indoorClean: indoorCleanController.text,
                                  outdoorClean: outdoorCleanController.text,
                                  kartuGantungUrl:
                                      kartuGantungUrlController.text,
                                  temuan: temuanController.text,
                                  rekomendasi: rekomendasiController.text);
                          imagesProvider.foto.forEach((key, value) async {
                            await GensetService().postFotoGenset(
                                gensetNilaiId: gen.id,
                                urlFoto: key,
                                description: value);
                          });
                          Navigator.pop(context);
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
                widget.title,
                style: header2.copyWith(color: textLightColor),
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: loadingGenset
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: loadingGenset
              ? [const Center(child: CircularProgressIndicator())]
              : [
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
