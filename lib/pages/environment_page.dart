import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/environment_master_model.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/master/env_master_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_dropdown.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class EnvironmentPage extends StatefulWidget {
  const EnvironmentPage({
    super.key,
    required this.environment,
    required this.title,
  });
  final EnvironmentMasterModel environment;
  final String title;

  @override
  State<EnvironmentPage> createState() => _EnvironmentPageState();
}

class _EnvironmentPageState extends State<EnvironmentPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  String fotoPopTampakDepan = "";
  String fotoPopTampakBelakang = "";
  String fotoPopTampakSampingKanan = "";
  String fotoPopTampakSampingKiri = "";
  String fotoPopBagianDalam = "";
  String bangunan = "";
  bool loading = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        // await acProvider.getAc(widget.pm.id, widget.acMaster.id);
        bangunan = widget.environment.bangunan.isEmpty
            ? ""
            : widget.environment.bangunan;
        // if (widget.environment..isNotEmpty) {
        //   for (var element in widget.environment..first.foto!) {
        //     String url = element.url.replaceAll("http://localhost",
        //         "https://jakban.iconpln.co.id/backend-plnicon/public");

        //     if (element.deskripsi == "AC Outdoor") {
        //       fotoPopTampakDepan = url;
        //     } else if (element.deskripsi == "POP Tampak Belakang") {
        //       fotoPopTampakBelakang = url;
        //     } else if (element.deskripsi == "Suhu AC") {
        //       fotoPopTampakSampingKanan = url;
        //     }
        //     imagesProvider.foto[url] = element.deskripsi;
        //   }
        // }
      }
    }
    loading = false;
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

    TextEditingController exhaustController = TextEditingController(
        text: widget.environment.exhaust.isEmpty
            ? ""
            : widget.environment.exhaust);
    TextEditingController kesehatanExhaustController = TextEditingController(
        text: widget.environment.kebersihanExhaust.isEmpty
            ? ""
            : widget.environment.kebersihanExhaust);
    TextEditingController lampuController = TextEditingController(
        text: widget.environment.lampu.isEmpty ? "" : widget.environment.lampu);
    TextEditingController jumlahLampuController = TextEditingController(
        text: widget.environment.jumlahLampu.isEmpty
            ? ""
            : widget.environment.jumlahLampu);
    TextEditingController kesehatanBangunanController = TextEditingController(
        text: widget.environment.kebersihanBangunan.isEmpty
            ? ""
            : widget.environment.kebersihanExhaust);
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    List<String> listBangunan = ["Ok", "Not OK"];
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
                    "Bangunan : ${widget.environment.bangunan}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Exhaust : ${widget.environment.exhaust}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Jumlah Lampu : ${widget.environment.jumlahLampu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Jumlah Lampu Menyala : ${widget.environment.lampu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Suhu Ruangan : ${widget.environment.suhuRuangan} °C",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kebersihan Bangunan : ${widget.environment.kebersihanBangunan}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kebersihan Exhaust : ${widget.environment.kebersihanExhaust}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Temuan : ${widget.environment.temuan}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Rekomendasi : ${widget.environment.rekomendasi}",
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
                                                      "POP Tampak Depan") {
                                                    fotoPopTampakDepan = "";
                                                  } else if (e.value ==
                                                      "POP Tampak Belakang") {
                                                    fotoPopTampakBelakang = "";
                                                  } else if (e.value ==
                                                      "POP Tampak Samping Kanan") {
                                                    fotoPopTampakSampingKanan =
                                                        "";
                                                  } else if (e.value ==
                                                      "POP Tampak Samping Kiri") {
                                                    fotoPopTampakSampingKiri =
                                                        "";
                                                  } else if (e.value ==
                                                      "POP Bagian Dalam") {
                                                    fotoPopBagianDalam = "";
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
                    "Foto POP Tampak Depan",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoPopTampakDepan.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "POP Tampak Depan");
                              // imagesProvider.foto[contentPath] =
                              //     imagesProvider.foto;
                              fotoPopTampakDepan = contentPath;
                              print(imagesProvider.foto);
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
                              onTap: fotoPopTampakDepan.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "POP Tampak Depan");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoPopTampakDepan = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoPopTampakDepan.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoPopTampakDepan)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(
                                                      File(fotoPopTampakDepan))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoPopTampakDepan.isEmpty
                                    ? "Tambah Foto"
                                    : fotoPopTampakDepan,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoPopTampakDepan.isEmpty,
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
                    "Foto POP Tampak Belakang",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoPopTampakBelakang.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "POP Tampak Belakang");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoPopTampakBelakang = contentPath;
                              print(imagesProvider.foto);
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
                              onTap: fotoPopTampakBelakang.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "POP Tampak Belakang");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoPopTampakBelakang = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoPopTampakBelakang.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoPopTampakBelakang)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoPopTampakBelakang))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoPopTampakBelakang.isEmpty
                                    ? "Tambah Foto"
                                    : fotoPopTampakBelakang,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: fotoPopTampakBelakang.isNotEmpty
                                ? () {
                                    setState(() {
                                      imagesProvider.deleteImage(
                                          path: fotoPopTampakBelakang);
                                      fotoPopTampakBelakang = "";
                                    });
                                  }
                                : () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "POP Tampak Belakang");
                                      // imagesProvider.listFoto[contentPath] =
                                      //     imagesProvider.foto;
                                      fotoPopTampakBelakang = contentPath;
                                      print(imagesProvider.foto);
                                      deskripsiController.clear();
                                    }
                                  },
                            child: Visibility(
                              visible: fotoPopTampakBelakang.isEmpty,
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
                    "Foto POP Tampak Samping Kanan",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoPopTampakSampingKanan.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "POP Tampak Samping Kanan");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoPopTampakSampingKanan = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoPopTampakSampingKanan
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(
                                    context,
                                    Image.network(fotoPopTampakSampingKanan)
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(
                                    context,
                                    Image.file(File(fotoPopTampakSampingKanan))
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
                              onTap: fotoPopTampakSampingKanan.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi:
                                                "POP Tampak Samping Kanan");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoPopTampakSampingKanan = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoPopTampakSampingKanan.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoPopTampakSampingKanan)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoPopTampakSampingKanan))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoPopTampakSampingKanan.isEmpty
                                    ? "Tambah Foto"
                                    : fotoPopTampakSampingKanan,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoPopTampakSampingKanan.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi: "POP Tampak Samping Kanan");
                                  // imagesProvider.listFoto[contentPath] =
                                  //     imagesProvider.foto;
                                  fotoPopTampakSampingKanan = contentPath;
                                  print(imagesProvider.foto);
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
                    "Foto POP Tampak Samping Kiri",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoPopTampakSampingKiri.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "POP Tampak Samping Kiri");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoPopTampakSampingKiri = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoPopTampakSampingKiri
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(
                                    context,
                                    Image.network(fotoPopTampakSampingKiri)
                                        .image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(
                                    context,
                                    Image.file(File(fotoPopTampakSampingKiri))
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
                              onTap: fotoPopTampakSampingKiri.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi:
                                                "POP Tampak Samping Kiri");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoPopTampakSampingKiri = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoPopTampakSampingKiri.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoPopTampakSampingKiri)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoPopTampakSampingKiri))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoPopTampakSampingKiri.isEmpty
                                    ? "Tambah Foto"
                                    : fotoPopTampakSampingKiri,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoPopTampakSampingKiri.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi: "POP Tampak Samping Kiri");
                                  // imagesProvider.listFoto[contentPath] =
                                  //     imagesProvider.foto;
                                  fotoPopTampakSampingKiri = contentPath;
                                  print(imagesProvider.foto);
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
                    "Foto POP Bagian Dalam",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoPopBagianDalam.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "POP Bagian Dalam");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoPopBagianDalam = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoPopBagianDalam
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(context,
                                    Image.network(fotoPopBagianDalam).image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(context,
                                    Image.file(File(fotoPopBagianDalam)).image,
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
                              onTap: fotoPopBagianDalam.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "POP Bagian Dalam");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoPopBagianDalam = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoPopBagianDalam.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoPopBagianDalam)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(
                                                      File(fotoPopBagianDalam))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoPopBagianDalam.isEmpty
                                    ? "Tambah Foto"
                                    : fotoPopBagianDalam,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoPopBagianDalam.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi: "POP Bagian Dalam");
                                  // imagesProvider.listFoto[contentPath] =
                                  //     imagesProvider.foto;
                                  fotoPopBagianDalam = contentPath;
                                  print(imagesProvider.foto);
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
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              print(imagesProvider.foto);
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
                    items: listBangunan
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                              ),
                            ))
                        .toList(),
                    value: bangunan.isEmpty ? null : bangunan,
                    onChanged: (value) {
                      bangunan = value.toString();
                      // setState(() {});
                    },
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
                          imagesProvider.foto.forEach((key, value) async {
                            await EnvironmentMasterService().postFotoEnv(
                                envId: widget.environment.id,
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
