// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/perangkat_master_model.dart';
import 'package:plnicon_mobile/models/nilai/perangkat_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_perangkat_page.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/master/perangkat_service_master.dart';
import 'package:plnicon_mobile/services/transaksional/perangkat_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_button_loading.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class DataPerangkatPage extends StatefulWidget {
  const DataPerangkatPage({
    super.key,
    required this.perangkat,
    required this.pm,
  });
  final PerangkatMasterModel perangkat;
  final PmModel pm;
  @override
  State<DataPerangkatPage> createState() => _DataPerangkatPageState();
}

class _DataPerangkatPageState extends State<DataPerangkatPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  String fotoRackPerangkat = "";
  String fotoPerangkat = "";
  String fotoPembersihanPerangkat = "";
  bool loading = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider perangkatProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await perangkatProvider.getPerangkat(widget.pm.id, widget.perangkat.id);
        if (perangkatProvider.listPerangkat.isNotEmpty) {
          for (var element in perangkatProvider.listPerangkat.first.foto!) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");

            if (element.deskripsi == "Foto Rack Perangkat") {
              fotoRackPerangkat = url;
            } else if (element.deskripsi == "Foto Perangkat") {
              fotoPerangkat = url;
            } else if (element.deskripsi == "Foto Pembersihan Perangkat") {
              fotoPembersihanPerangkat = url;
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
    TransaksionalProvider perangkatProvider =
        Provider.of<TransaksionalProvider>(context);
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController temuanController = TextEditingController(
        text: perangkatProvider.listPerangkat.isEmpty
            ? ""
            : perangkatProvider.listPerangkat.last.temuan);
    TextEditingController rekomendasiController = TextEditingController(
        text: perangkatProvider.listPerangkat.isEmpty
            ? ""
            : perangkatProvider.listPerangkat.last.rekomendasi);
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
                    "Nama : ${widget.perangkat.nama}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Rack Id : ${widget.perangkat.rackId}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk : ${widget.perangkat.merk}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sumber Main : ${widget.perangkat.sumberMain}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sumber Backup : ${widget.perangkat.sumberBackup}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Jenis : ${widget.perangkat.jenis}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tipe : ${widget.perangkat.tipe}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Terminasi : ${widget.perangkat.terminasi}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tanggal Instalasi : ${widget.perangkat.tanggalInstalasi}",
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
                                builder: (context) => EditPerangkatPage(
                                      perangkat: widget.perangkat,
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
                        await PerangkatMasterService()
                            .deleteMaster(id: widget.perangkat.id);
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
              padding: EdgeInsets.all(defaultMargin),
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
                                                    "Foto Rack Perangkat") {
                                                  fotoRackPerangkat = "";
                                                } else if (e.value ==
                                                    "Foto Perangkat") {
                                                  fotoPerangkat = "";
                                                } else if (e.value ==
                                                    "Foto Pembersihan Perangkat") {
                                                  fotoPembersihanPerangkat = "";
                                                }
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 255, 73, 60),
                                                borderRadius:
                                                    BorderRadius.circular(180),
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
                  "Foto Rack Perangkat",
                  style: buttonText.copyWith(color: textDarkColor),
                ),
                GestureDetector(
                  onTap: fotoRackPerangkat.isEmpty
                      ? () async {
                          await handlePicker();
                          if (imagesProvider.croppedImageFile != null) {
                            imagesProvider.addDeskripsi(
                                path: contentPath,
                                deskripsi: "Foto Rack Perangkat");
                            fotoRackPerangkat = contentPath;
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
                            onTap: fotoRackPerangkat.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Foto Rack Perangkat");
                                      fotoRackPerangkat = contentPath;
                                      deskripsiController.clear();
                                    }
                                  }
                                : () {
                                    fotoRackPerangkat.contains(
                                            "https://jakban.iconpln.co.id")
                                        ? showImageViewer(
                                            context,
                                            Image.network(fotoRackPerangkat)
                                                .image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true)
                                        : showImageViewer(
                                            context,
                                            Image.file(File(fotoRackPerangkat))
                                                .image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true);
                                  },
                            child: Text(
                              fotoRackPerangkat.isEmpty
                                  ? "Tambah Foto"
                                  : fotoRackPerangkat,
                              style: buttonText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: fotoRackPerangkat.isEmpty,
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
                  "Foto Perangkat",
                  style: buttonText.copyWith(color: textDarkColor),
                ),
                GestureDetector(
                  onTap: fotoPerangkat.isEmpty
                      ? () async {
                          await handlePicker();
                          if (imagesProvider.croppedImageFile != null) {
                            imagesProvider.addDeskripsi(
                                path: contentPath, deskripsi: "Foto Perangkat");
                            fotoPerangkat = contentPath;
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
                            onTap: fotoPerangkat.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Foto Perangkat");
                                      fotoPerangkat = contentPath;
                                      deskripsiController.clear();
                                    }
                                  }
                                : () {
                                    fotoPerangkat.contains(
                                            "https://jakban.iconpln.co.id")
                                        ? showImageViewer(context,
                                            Image.network(fotoPerangkat).image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true)
                                        : showImageViewer(
                                            context,
                                            Image.file(File(fotoPerangkat))
                                                .image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true);
                                  },
                            child: Text(
                              fotoPerangkat.isEmpty
                                  ? "Tambah Foto"
                                  : fotoPerangkat,
                              style: buttonText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: fotoPerangkat.isNotEmpty
                              ? () {
                                  setState(() {
                                    imagesProvider.deleteImage(
                                        path: fotoPerangkat);
                                    fotoPerangkat = "";
                                  });
                                }
                              : () async {
                                  await handlePicker();
                                  if (imagesProvider.croppedImageFile != null) {
                                    imagesProvider.addDeskripsi(
                                        path: contentPath,
                                        deskripsi: "Foto Perangkat");
                                    fotoPerangkat = contentPath;
                                    deskripsiController.clear();
                                  }
                                },
                          child: Visibility(
                            visible: fotoPerangkat.isEmpty,
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
                  "Foto Pembersihan Perangkat",
                  style: buttonText.copyWith(color: textDarkColor),
                ),
                GestureDetector(
                  onTap: fotoPembersihanPerangkat.isEmpty
                      ? () async {
                          await handlePicker();
                          if (imagesProvider.croppedImageFile != null) {
                            imagesProvider.addDeskripsi(
                                path: contentPath,
                                deskripsi: "Foto Pembersihan Perangkat");
                            fotoPembersihanPerangkat = contentPath;
                            deskripsiController.clear();
                          }
                        }
                      : () {
                          fotoPembersihanPerangkat
                                  .contains("https://jakban.iconpln.co.id")
                              ? showImageViewer(context,
                                  Image.network(fotoPembersihanPerangkat).image,
                                  swipeDismissible: true,
                                  doubleTapZoomable: true)
                              : showImageViewer(
                                  context,
                                  Image.file(File(fotoPembersihanPerangkat))
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
                            onTap: fotoPembersihanPerangkat.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi:
                                              "Foto Pembersihan Perangkat");
                                      fotoPembersihanPerangkat = contentPath;
                                      deskripsiController.clear();
                                    }
                                  }
                                : () {
                                    fotoPembersihanPerangkat.contains(
                                            "https://jakban.iconpln.co.id")
                                        ? showImageViewer(
                                            context,
                                            Image.network(
                                                    fotoPembersihanPerangkat)
                                                .image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true)
                                        : showImageViewer(
                                            context,
                                            Image.file(File(
                                                    fotoPembersihanPerangkat))
                                                .image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true);
                                  },
                            child: Text(
                              fotoPembersihanPerangkat.isEmpty
                                  ? "Tambah Foto"
                                  : fotoPembersihanPerangkat,
                              style: buttonText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: fotoPembersihanPerangkat.isEmpty,
                          child: GestureDetector(
                            onTap: () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: "Foto Pembersihan Perangkat");
                                fotoPembersihanPerangkat = contentPath;
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
                            setState(() {
                              isLoading = true;
                            });
                            if (perangkatProvider.listPerangkat.isEmpty) {
                              if (fotoPerangkat.isNotEmpty &&
                                  fotoRackPerangkat.isNotEmpty &&
                                  fotoPembersihanPerangkat.isNotEmpty) {
                                PerangkatNilaiModel perangkat =
                                    await PerangkatService().postPerangkat(
                                        perangkatId: widget.perangkat.id,
                                        pmId: widget.pm.id,
                                        temuan: temuanController.text,
                                        rekomendasi:
                                            rekomendasiController.text);

                                await Future.forEach(
                                    imagesProvider.foto.entries,
                                    (element) async {
                                  await PerangkatService().postFotoPerangkat(
                                      rackId: widget.perangkat.rackId,
                                      perangkatNilaiId: perangkat.id,
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
                                      'Isi data suhu, pengujian, serta foto dengan lengkap',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            } else {
                              if (fotoPerangkat.isNotEmpty &&
                                  fotoRackPerangkat.isNotEmpty &&
                                  fotoPembersihanPerangkat.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                PerangkatNilaiModel perangkat =
                                    await PerangkatService().editPerangkat(
                                        id: perangkatProvider
                                            .listPerangkat.last.id,
                                        perangkatId: widget.perangkat.id,
                                        pmId: widget.pm.id,
                                        temuan: temuanController.text,
                                        rekomendasi:
                                            rekomendasiController.text);
                                if (perangkatProvider
                                    .listPerangkat.isNotEmpty) {
                                  for (var item in perangkatProvider
                                      .listPerangkat.last.foto!) {
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
                                      await PerangkatService()
                                          .deleteImage(imageId: item.id);
                                    }
                                  }
                                }
                                await Future.forEach(
                                    imagesProvider.foto.entries,
                                    (element) async {
                                  if (!(element.key.contains(
                                      "https://jakban.iconpln.co.id"))) {
                                    await PerangkatService().postFotoPerangkat(
                                        rackId: widget.perangkat.rackId,
                                        perangkatNilaiId: perangkat.id,
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
                                      'Isi foto dengan lengkap',
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
            ));
          }
        default:
          {
            return const Scaffold();
          }
      }
    }

    return Scaffold(
        appBar: CustomAppBar(
            isMainPage: false, title: "Perangkat ${widget.perangkat.nama}"),
        body: Column(
          mainAxisAlignment:
              loading ? MainAxisAlignment.center : MainAxisAlignment.start,
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
