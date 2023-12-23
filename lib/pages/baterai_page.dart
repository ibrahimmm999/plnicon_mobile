// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/baterai_master_model.dart';
import 'package:plnicon_mobile/models/nilai/baterai_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_baterai_page.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/master/baterai_master_service.dart';
import 'package:plnicon_mobile/services/transaksional/baterai_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_button_loading.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
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

  String fotoRackBaterai = "";
  String fotoBankBaterai = "";
  String fotoTeganganTerhubungRecti = "";
  String fotoSettingDummyLoad = "";
  String fotoDisplayMenuUtamaSetelahDisetting = "";
  String fotoDisplayMenuUtamaSetelahStarting = "";
  String fotoSaatPengujian = "";
  String fotoHasilPengujian = "";
  String fotoNotifikasiDummyLoadSetelahPengujian = "";
  bool loading = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider bateraiProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await bateraiProvider.getBaterai(widget.pm.id, widget.bateraiMaster.id);
        if (bateraiProvider.listBaterai.isNotEmpty) {
          for (var element in bateraiProvider.listBaterai.first.foto!) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");

            if (element.deskripsi == "Foto Rack Baterai") {
              fotoRackBaterai = url;
            } else if (element.deskripsi == "Foto Tegangan Terhubung Recti") {
              fotoTeganganTerhubungRecti = url;
            } else if (element.deskripsi == "Foto Bank Baterai") {
              fotoBankBaterai = url;
            } else if (element.deskripsi == "Foto Setting Dummy Load") {
              fotoSettingDummyLoad = url;
            } else if (element.deskripsi ==
                "Foto Display Menu Utama Setelah Disetting") {
              fotoDisplayMenuUtamaSetelahDisetting = url;
            } else if (element.deskripsi ==
                "Foto Display Menu Utama Setelah Starting") {
              fotoDisplayMenuUtamaSetelahStarting = url;
            } else if (element.deskripsi == "Foto Saat Pengujian") {
              fotoSaatPengujian = url;
            } else if (element.deskripsi == "Foto Hasil Pengujian") {
              fotoHasilPengujian = url;
            } else if (element.deskripsi ==
                "Foto Notifikasi Dummy Load Setelah Pengujian") {
              fotoNotifikasiDummyLoadSetelahPengujian = url;
            }
            imagesProvider.foto[url] = element.deskripsi;
          }
        }
      }
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider bateraiProvider =
        Provider.of<TransaksionalProvider>(context);
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

    TextEditingController loadController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.load.toString());
    TextEditingController groupVBankController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.groupVbank.toString());
    TextEditingController timeDischargeController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.timeDischarge.toString());
    TextEditingController stopUjiBateraiController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.stopUjiBaterai.toString());
    TextEditingController performanceController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.performance.toString());
    TextEditingController sisaKapasitasController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.sisaKapasitas.toString());
    TextEditingController kemampuanBackUpTimeController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.kemampuanBackupTime.toString());
    TextEditingController temuanController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.temuan.toString());
    TextEditingController rekomendasiController = TextEditingController(
        text: bateraiProvider.listBaterai.isEmpty
            ? ""
            : bateraiProvider.listBaterai.last.rekomendasi.toString());
    TextEditingController deskripsiController = TextEditingController();
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
                    "Tanggal Instalasi : ${widget.bateraiMaster.tanggalInstalasi}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  CustomButton(
                      text: "Edit Data",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditBateraiPage(
                                      baterai: widget.bateraiMaster,
                                      popId: widget.pm.popId,
                                    )));
                      },
                      color: primaryGreen,
                      clickColor: clickGreen),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Delete",
                      onPressed: () async {
                        await BateraiMasterService()
                            .delete(id: widget.bateraiMaster.id);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    PmDetailPage(pm: widget.pm))),
                            (route) => false);
                      },
                      color: primaryRed,
                      clickColor: clickRed),
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        e.key.contains(
                                                "https://jakban.iconpln.co.id")
                                            ? showImageViewer(context,
                                                Image.network(e.key).image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true)
                                            : showImageViewer(context,
                                                Image.file(File(e.key)).image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true);
                                      },
                                      child: Stack(
                                        children: [
                                          e.key.contains(
                                                  "https://jakban.iconpln.co.id")
                                              ? Image.network(
                                                  e.key,
                                                  height: 240,
                                                  width: 240,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  File(e.key),
                                                  height: 240,
                                                  width: 240,
                                                  fit: BoxFit.cover,
                                                ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  imagesProvider.deleteImage(
                                                      path: e.key);
                                                  if (e.value ==
                                                      "Foto Rack Baterai") {
                                                    fotoRackBaterai = "";
                                                  } else if (e.value ==
                                                      "Foto Bank Baterai") {
                                                    fotoBankBaterai = "";
                                                  } else if (e.value ==
                                                      "Foto Tegangan Terhubung Recti") {
                                                    fotoTeganganTerhubungRecti =
                                                        "";
                                                  } else if (e.value ==
                                                      "Foto Setting Dummy Load") {
                                                    fotoSettingDummyLoad = "";
                                                  } else if (e.value ==
                                                      "Foto Display Menu Utama Setelah Disetting") {
                                                    fotoDisplayMenuUtamaSetelahDisetting =
                                                        "";
                                                  } else if (e.value ==
                                                      "Foto Display Menu Utama Setelah Starting") {
                                                    fotoDisplayMenuUtamaSetelahStarting =
                                                        "";
                                                  } else if (e.value ==
                                                      "Foto Saat Pengujian") {
                                                    fotoSaatPengujian = "";
                                                  } else if (e.value ==
                                                      "Foto Notifikasi Dummy Load Setelah Pengujian") {
                                                    fotoNotifikasiDummyLoadSetelahPengujian =
                                                        "";
                                                  } else if (e.value ==
                                                      "Foto Hasil Pengujian") {
                                                    fotoHasilPengujian = "";
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 255, 73, 60),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          180),
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 24,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
                  const SizedBox(
                    height: 28,
                  ),
                  Text(
                    "Foto Rack Baterai",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoRackBaterai.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Rack Baterai");
                              fotoRackBaterai = contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap: fotoRackBaterai.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Foto Rack Baterai");
                                        fotoRackBaterai = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoRackBaterai.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoRackBaterai)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(fotoRackBaterai))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoRackBaterai.isEmpty
                                    ? "Tambah Foto"
                                    : fotoRackBaterai,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: fotoRackBaterai.isNotEmpty
                                ? () {
                                    setState(() {
                                      imagesProvider.deleteImage(
                                          path: fotoRackBaterai);
                                      fotoRackBaterai = "";
                                    });
                                  }
                                : () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Foto Rack Baterai");
                                      fotoRackBaterai = contentPath;
                                      deskripsiController.clear();
                                    }
                                  },
                            child: Visibility(
                              visible: fotoRackBaterai.isEmpty,
                              child: Icon(
                                Icons.photo_camera_outlined,
                                color: textLightColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Foto Bank Baterai",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoBankBaterai.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Bank Baterai");
                              fotoBankBaterai = contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap: fotoBankBaterai.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Foto Bank Baterai");
                                        fotoBankBaterai = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoBankBaterai.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoBankBaterai)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(fotoBankBaterai))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoBankBaterai.isEmpty
                                    ? "Tambah Foto"
                                    : fotoBankBaterai,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: fotoBankBaterai.isNotEmpty
                                ? () {
                                    setState(() {
                                      imagesProvider.deleteImage(
                                          path: fotoBankBaterai);
                                      fotoBankBaterai = "";
                                    });
                                  }
                                : () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Foto Bank Baterai");
                                      fotoBankBaterai = contentPath;
                                      deskripsiController.clear();
                                    }
                                  },
                            child: Visibility(
                              visible: fotoBankBaterai.isEmpty,
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
                    "Foto Setting Dummy Load",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoSettingDummyLoad.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Setting Dummy Load");
                              fotoSettingDummyLoad = contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoSettingDummyLoad
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(context,
                                    Image.network(fotoSettingDummyLoad).image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(
                                    context,
                                    Image.file(File(fotoSettingDummyLoad))
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true);
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap: fotoSettingDummyLoad.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi:
                                                "Foto Setting Dummy Load");
                                        fotoSettingDummyLoad = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoSettingDummyLoad.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoSettingDummyLoad)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoSettingDummyLoad))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoSettingDummyLoad.isEmpty
                                    ? "Tambah Foto"
                                    : fotoSettingDummyLoad,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoSettingDummyLoad.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi: "Foto Setting Dummy Load");
                                  fotoSettingDummyLoad = contentPath;
                                  deskripsiController.clear();
                                }
                              },
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
                    "Foto Display Menu Utama Setelah Disetting",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoDisplayMenuUtamaSetelahDisetting.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi:
                                      "Foto Display Menu Utama Setelah Disetting");
                              fotoDisplayMenuUtamaSetelahDisetting =
                                  contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoDisplayMenuUtamaSetelahDisetting
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(
                                    context,
                                    Image.network(
                                            fotoDisplayMenuUtamaSetelahDisetting)
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(
                                    context,
                                    Image.file(File(
                                            fotoDisplayMenuUtamaSetelahDisetting))
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true);
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap:
                                  fotoDisplayMenuUtamaSetelahDisetting.isEmpty
                                      ? () async {
                                          await handlePicker();
                                          if (imagesProvider.croppedImageFile !=
                                              null) {
                                            imagesProvider.addDeskripsi(
                                                path: contentPath,
                                                deskripsi:
                                                    "Foto Display Menu Utama Setelah Disetting");
                                            fotoDisplayMenuUtamaSetelahDisetting =
                                                contentPath;
                                            deskripsiController.clear();
                                          }
                                        }
                                      : () {
                                          fotoDisplayMenuUtamaSetelahDisetting
                                                  .contains(
                                                      "https://jakban.iconpln.co.id")
                                              ? showImageViewer(
                                                  context,
                                                  Image.network(
                                                          fotoDisplayMenuUtamaSetelahDisetting)
                                                      .image,
                                                  swipeDismissible: true,
                                                  doubleTapZoomable: true)
                                              : showImageViewer(
                                                  context,
                                                  Image.file(File(
                                                          fotoDisplayMenuUtamaSetelahDisetting))
                                                      .image,
                                                  swipeDismissible: true,
                                                  doubleTapZoomable: true);
                                        },
                              child: Text(
                                fotoDisplayMenuUtamaSetelahDisetting.isEmpty
                                    ? "Tambah Foto"
                                    : fotoDisplayMenuUtamaSetelahDisetting,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                fotoDisplayMenuUtamaSetelahDisetting.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi:
                                          "Foto Display Menu Utama Setelah Disetting");
                                  fotoDisplayMenuUtamaSetelahDisetting =
                                      contentPath;
                                  deskripsiController.clear();
                                }
                              },
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
                    "Foto Display Menu Utama Setelah Starting",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoDisplayMenuUtamaSetelahStarting.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi:
                                      "Foto Display Menu Utama Setelah Starting");
                              fotoDisplayMenuUtamaSetelahStarting = contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoDisplayMenuUtamaSetelahStarting
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(
                                    context,
                                    Image.network(
                                            fotoDisplayMenuUtamaSetelahStarting)
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(
                                    context,
                                    Image.file(File(
                                            fotoDisplayMenuUtamaSetelahStarting))
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true);
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap: fotoDisplayMenuUtamaSetelahStarting.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi:
                                                "Foto Display Menu Utama Setelah Starting");
                                        fotoDisplayMenuUtamaSetelahStarting =
                                            contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoDisplayMenuUtamaSetelahStarting
                                              .contains(
                                                  "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoDisplayMenuUtamaSetelahStarting)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoDisplayMenuUtamaSetelahStarting))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoDisplayMenuUtamaSetelahStarting.isEmpty
                                    ? "Tambah Foto"
                                    : fotoDisplayMenuUtamaSetelahStarting,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                fotoDisplayMenuUtamaSetelahStarting.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi:
                                          "Foto Display Menu Utama Setelah Starting");
                                  fotoDisplayMenuUtamaSetelahStarting =
                                      contentPath;
                                  deskripsiController.clear();
                                }
                              },
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
                    "Foto Tegangan Terhubung Recti",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoTeganganTerhubungRecti.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Tegangan Terhubung Recti");
                              fotoTeganganTerhubungRecti = contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoTeganganTerhubungRecti
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(
                                    context,
                                    Image.network(fotoTeganganTerhubungRecti)
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(
                                    context,
                                    Image.file(File(fotoTeganganTerhubungRecti))
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true);
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap: fotoTeganganTerhubungRecti.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi:
                                                "Foto Tegangan Terhubung Recti");
                                        fotoTeganganTerhubungRecti =
                                            contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoTeganganTerhubungRecti.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoTeganganTerhubungRecti)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoTeganganTerhubungRecti))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoTeganganTerhubungRecti.isEmpty
                                    ? "Tambah Foto"
                                    : fotoTeganganTerhubungRecti,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoTeganganTerhubungRecti.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi:
                                          "Foto Tegangan Terhubung Recti");
                                  fotoTeganganTerhubungRecti = contentPath;
                                  deskripsiController.clear();
                                }
                              },
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
                    "Foto Saat Pengujian",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoSaatPengujian.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Saat Pengujian");
                              fotoSaatPengujian = contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoSaatPengujian
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(context,
                                    Image.network(fotoSaatPengujian).image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(context,
                                    Image.file(File(fotoSaatPengujian)).image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true);
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap: fotoSaatPengujian.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Foto Saat Pengujian");
                                        fotoSaatPengujian = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoSaatPengujian.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoSaatPengujian)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(
                                                      File(fotoSaatPengujian))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoSaatPengujian.isEmpty
                                    ? "Tambah Foto"
                                    : fotoSaatPengujian,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoSaatPengujian.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi: "Foto Saat Pengujian");
                                  fotoSaatPengujian = contentPath;
                                  deskripsiController.clear();
                                }
                              },
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
                    "Foto Hasil Pengujian",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoHasilPengujian.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Hasil Pengujian");
                              fotoHasilPengujian = contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoHasilPengujian
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(context,
                                    Image.network(fotoHasilPengujian).image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(context,
                                    Image.file(File(fotoHasilPengujian)).image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true);
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap: fotoHasilPengujian.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Foto Hasil Pengujian");
                                        fotoHasilPengujian = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoHasilPengujian.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoHasilPengujian)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(
                                                      File(fotoHasilPengujian))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoHasilPengujian.isEmpty
                                    ? "Tambah Foto"
                                    : fotoHasilPengujian,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoHasilPengujian.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi: "Foto Hasil Pengujian");
                                  fotoHasilPengujian = contentPath;
                                  deskripsiController.clear();
                                }
                              },
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
                    "Foto Notifikasi Dummy Load Setelah Pengujian",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoNotifikasiDummyLoadSetelahPengujian.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi:
                                      "Foto Notifikasi Dummy Load Setelah Pengujian");
                              fotoNotifikasiDummyLoadSetelahPengujian =
                                  contentPath;
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoNotifikasiDummyLoadSetelahPengujian
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(
                                    context,
                                    Image.network(
                                            fotoNotifikasiDummyLoadSetelahPengujian)
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(
                                    context,
                                    Image.file(File(
                                            fotoNotifikasiDummyLoadSetelahPengujian))
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true);
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                              onTap: fotoNotifikasiDummyLoadSetelahPengujian
                                      .isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi:
                                                "Foto Notifikasi Dummy Load Setelah Pengujian");
                                        fotoNotifikasiDummyLoadSetelahPengujian =
                                            contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoNotifikasiDummyLoadSetelahPengujian
                                              .contains(
                                                  "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoNotifikasiDummyLoadSetelahPengujian)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoNotifikasiDummyLoadSetelahPengujian))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoNotifikasiDummyLoadSetelahPengujian.isEmpty
                                    ? "Tambah Foto"
                                    : fotoNotifikasiDummyLoadSetelahPengujian,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                fotoNotifikasiDummyLoadSetelahPengujian.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi:
                                          "Foto Notifikasi Dummy Load Setelah Pengujian");
                                  fotoNotifikasiDummyLoadSetelahPengujian =
                                      contentPath;
                                  deskripsiController.clear();
                                }
                              },
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
                    "Foto Tambahan",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await handlePicker();
                      if (imagesProvider.croppedImageFile != null) {
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
                    child: isLoading
                        ? CustomButtonLoading(color: primaryGreen)
                        : CustomButton(
                            text: "Save",
                            onPressed: () async {
                              if (bateraiProvider.listBaterai.isEmpty) {
                                if (fotoBankBaterai.isNotEmpty &&
                                    fotoDisplayMenuUtamaSetelahDisetting
                                        .isNotEmpty &&
                                    fotoDisplayMenuUtamaSetelahStarting
                                        .isNotEmpty &&
                                    fotoHasilPengujian.isNotEmpty &&
                                    fotoNotifikasiDummyLoadSetelahPengujian
                                        .isNotEmpty &&
                                    fotoRackBaterai.isNotEmpty &&
                                    fotoSaatPengujian.isNotEmpty &&
                                    fotoSettingDummyLoad.isNotEmpty &&
                                    fotoTeganganTerhubungRecti.isNotEmpty &&
                                    loadController.text.isNotEmpty &&
                                    groupVBankController.text.isNotEmpty &&
                                    timeDischargeController.text.isNotEmpty &&
                                    stopUjiBateraiController.text.isNotEmpty &&
                                    performanceController.text.isNotEmpty &&
                                    kemampuanBackUpTimeController
                                        .text.isNotEmpty) {
                                  BateraiNilaiModel baterai =
                                      await BateraiService().postBaterai(
                                          bateraiId: widget.bateraiMaster.id,
                                          pmId: widget.pm.id,
                                          load:
                                              double.parse(loadController.text),
                                          groupVBank: double.parse(
                                              groupVBankController.text),
                                          timeDischarge: int.parse(
                                              timeDischargeController.text),
                                          stopUjiBaterai: int.parse(
                                              stopUjiBateraiController.text),
                                          performance: double.parse(
                                              performanceController.text),
                                          sisaKapasitas: double.parse(
                                              sisaKapasitasController.text),
                                          kemampuanBackUpTime: double.parse(
                                              kemampuanBackUpTimeController
                                                  .text),
                                          temuan: temuanController.text,
                                          rekomendasi: rekomendasiController.text);
                                  await Future.forEach(
                                      imagesProvider.foto.entries,
                                      (element) async {
                                    await BateraiService().postFotoBaterai(
                                        bateraiNilaiId: baterai.id,
                                        urlFoto: element.key,
                                        description: element.value);
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PmDetailPage(pm: widget.pm)),
                                      (route) => false);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: primaryRed,
                                      content: const Text(
                                        'Isi data serta foto dengan lengkap',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                if (fotoBankBaterai.isNotEmpty &&
                                    fotoDisplayMenuUtamaSetelahDisetting
                                        .isNotEmpty &&
                                    fotoDisplayMenuUtamaSetelahStarting
                                        .isNotEmpty &&
                                    fotoHasilPengujian.isNotEmpty &&
                                    fotoNotifikasiDummyLoadSetelahPengujian
                                        .isNotEmpty &&
                                    fotoRackBaterai.isNotEmpty &&
                                    fotoSaatPengujian.isNotEmpty &&
                                    fotoSettingDummyLoad.isNotEmpty &&
                                    fotoTeganganTerhubungRecti.isNotEmpty &&
                                    loadController.text.isNotEmpty &&
                                    groupVBankController.text.isNotEmpty &&
                                    timeDischargeController.text.isNotEmpty &&
                                    stopUjiBateraiController.text.isNotEmpty &&
                                    performanceController.text.isNotEmpty &&
                                    kemampuanBackUpTimeController
                                        .text.isNotEmpty) {
                                  BateraiNilaiModel baterai =
                                      await BateraiService().editBaterai(
                                          id: bateraiProvider
                                              .listBaterai.last.id,
                                          bateraiId: widget.bateraiMaster.id,
                                          pmId: widget.pm.id,
                                          load:
                                              double.parse(loadController.text),
                                          groupVBank: double.parse(
                                              groupVBankController.text),
                                          timeDischarge: int.parse(
                                              timeDischargeController.text),
                                          stopUjiBaterai: int.parse(
                                              stopUjiBateraiController.text),
                                          performance: double.parse(
                                              performanceController.text),
                                          sisaKapasitas: double.parse(
                                              sisaKapasitasController.text),
                                          kemampuanBackUpTime: double.parse(
                                              kemampuanBackUpTimeController.text),
                                          temuan: temuanController.text,
                                          rekomendasi: rekomendasiController.text);
                                  if (bateraiProvider.listBaterai.isNotEmpty) {
                                    for (var item in bateraiProvider
                                        .listBaterai.last.foto!) {
                                      bool isDelete = true;
                                      for (var itemImagesProvider
                                          in imagesProvider.foto.entries) {
                                        String url = item.url.replaceAll(
                                            "http://localhost",
                                            "https://jakban.iconpln.co.id/backend-plnicon/public");
                                        if (url == itemImagesProvider.key) {
                                          isDelete = false;
                                        }
                                      }
                                      if (isDelete) {
                                        await BateraiService()
                                            .deleteImage(imageId: item.id);
                                      }
                                    }
                                  }
                                  await Future.forEach(
                                      imagesProvider.foto.entries,
                                      (element) async {
                                    if (!(element.key.contains(
                                        "https://jakban.iconpln.co.id"))) {
                                      await BateraiService().postFotoBaterai(
                                          bateraiNilaiId: baterai.id,
                                          urlFoto: element.key,
                                          description: element.value);
                                    }
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PmDetailPage(pm: widget.pm)),
                                      (route) => false);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: primaryRed,
                                      content: const Text(
                                        'Isi data suhu, pengujian, serta foto dengan lengkap',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            color: primaryGreen,
                            clickColor: clickGreen),
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
        appBar: CustomAppBar(isMainPage: false, title: widget.title),
        body: Column(
          children: loading
              ? [
                  Center(
                      child: CircularProgressIndicator(
                          backgroundColor: primaryBlue))
                ]
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
