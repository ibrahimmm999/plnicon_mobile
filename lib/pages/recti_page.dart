import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/nilai/rect_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_recti_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/master/rect_master_service.dart';
import 'package:plnicon_mobile/services/transaksional/rect_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

import '../models/master/rect_master_model.dart';

class RectiPage extends StatefulWidget {
  const RectiPage(
      {super.key, required this.rect, required this.title, required this.pm});
  final RectMasterModel rect;
  final String title;
  final PmModel pm;

  @override
  State<RectiPage> createState() => _RectiPageState();
}

class _RectiPageState extends State<RectiPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  String fotoLoadR = "";
  String fotoLoadS = "";
  String fotoLoadT = "";
  String fotoFisik = "";
  bool loading = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider rectProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await rectProvider.getRect(widget.pm.id, widget.rect.id);
        if (rectProvider.listRect.isNotEmpty) {
          print(rectProvider.listRect.first.foto.length);
          for (var element in rectProvider.listRect.first.foto) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");

            if (element.deskripsi == "Foto Fisik") {
              fotoFisik = url;
            } else if (element.deskripsi == "Load R") {
              fotoLoadR = url;
            } else if (element.deskripsi == "Load S") {
              fotoLoadS = url;
            } else if (element.deskripsi == "Load T") {
              fotoLoadT = url;
            }
            imagesProvider.foto[url] = element.deskripsi;
          }
        }
      }
    }
    print(imagesProvider.foto);
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider rectProvider =
        Provider.of<TransaksionalProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
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

    int phasa = widget.rect.jumlahPhasa;
    TextEditingController loadrController = TextEditingController(
        text: rectProvider.listRect.isEmpty
            ? ""
            : rectProvider.listRect.last.loadr.toString());
    TextEditingController loadsController = TextEditingController(
        text: rectProvider.listRect.isEmpty
            ? ""
            : rectProvider.listRect.last.loads.toString());
    TextEditingController loadtController = TextEditingController(
        text: rectProvider.listRect.isEmpty
            ? ""
            : rectProvider.listRect.last.loadt.toString());
    TextEditingController temuanController = TextEditingController(
        text: rectProvider.listRect.isEmpty
            ? ""
            : rectProvider.listRect.last.temuan.toString());
    TextEditingController rekomendasiController = TextEditingController(
        text: rectProvider.listRect.isEmpty
            ? ""
            : rectProvider.listRect.last.rekomendasi.toString());
    TextEditingController deskripsiController = TextEditingController();

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
                    "Merk : ${widget.rect.merk}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SN : ${widget.rect.sn}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tipe : ${widget.rect.tipe}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Jumlah Phasa : ${widget.rect.jumlahPhasa}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Modul Control : ${widget.rect.modulControl}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Modul Terpasang : ${widget.rect.modulTerpasang}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Slot Modul : ${widget.rect.slotModul}",
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
                                builder: (context) => EditRectiPage(
                                    pm: widget.pm, rect: widget.rect)));
                      },
                      color: primaryGreen,
                      clickColor: clickGreen),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Delete",
                      onPressed: () async {
                        await RectMasterService()
                            .deleteRectMaster(id: widget.rect.id);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
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
                                                  if (e.value == "Foto Fisik") {
                                                    fotoFisik = "";
                                                  } else if (e.value ==
                                                      "Load R") {
                                                    fotoLoadR = "";
                                                  } else if (e.value ==
                                                      "Load S") {
                                                    fotoLoadS = "";
                                                  } else if (e.value ==
                                                      "Load T") {
                                                    fotoLoadT = "";
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
                    "Foto Fisik",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoFisik.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath, deskripsi: "Foto Fisik");
                              fotoFisik = contentPath;
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
                              onTap: fotoFisik.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Foto Fisik");
                                        fotoFisik = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoFisik.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(context,
                                              Image.network(fotoFisik).image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(context,
                                              Image.file(File(fotoFisik)).image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoFisik.isEmpty ? "Tambah Foto" : fotoFisik,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoFisik.isEmpty,
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
                    "Foto Load R",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoLoadR.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath, deskripsi: "Load R");
                              fotoLoadR = contentPath;
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
                              onTap: fotoLoadR.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Load R");
                                        fotoLoadR = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoLoadR.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(context,
                                              Image.network(fotoLoadR).image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(context,
                                              Image.file(File(fotoLoadR)).image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoLoadR.isEmpty ? "Tambah Foto" : fotoLoadR,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoLoadR.isEmpty,
                            child: Icon(
                              Icons.photo_camera_outlined,
                              color: textLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: phasa == 3,
                    child: Text(
                      "Foto Load S",
                      style: buttonText.copyWith(color: textDarkColor),
                    ),
                  ),
                  Visibility(
                    visible: phasa == 3,
                    child: GestureDetector(
                      onTap: fotoLoadS.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath, deskripsi: "Load S");
                                fotoLoadS = contentPath;
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
                                onTap: fotoLoadS.isEmpty
                                    ? () async {
                                        await handlePicker();
                                        if (imagesProvider.croppedImageFile !=
                                            null) {
                                          imagesProvider.addDeskripsi(
                                              path: contentPath,
                                              deskripsi: "Load S");
                                          fotoLoadS = contentPath;
                                          deskripsiController.clear();
                                        }
                                      }
                                    : () {
                                        fotoLoadS.contains(
                                                "https://jakban.iconpln.co.id")
                                            ? showImageViewer(context,
                                                Image.network(fotoLoadS).image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true)
                                            : showImageViewer(
                                                context,
                                                Image.file(File(fotoLoadS))
                                                    .image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true);
                                      },
                                child: Text(
                                  fotoLoadS.isEmpty ? "Tambah Foto" : fotoLoadS,
                                  style: buttonText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: fotoLoadS.isEmpty,
                              child: Icon(
                                Icons.photo_camera_outlined,
                                color: textLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: phasa == 3,
                    child: Text(
                      "Foto Load T",
                      style: buttonText.copyWith(color: textDarkColor),
                    ),
                  ),
                  Visibility(
                    visible: phasa == 3,
                    child: GestureDetector(
                      onTap: fotoLoadT.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath, deskripsi: "Load T");
                                fotoLoadT = contentPath;
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
                                onTap: fotoLoadT.isEmpty
                                    ? () async {
                                        await handlePicker();
                                        if (imagesProvider.croppedImageFile !=
                                            null) {
                                          imagesProvider.addDeskripsi(
                                              path: contentPath,
                                              deskripsi: "Load T");
                                          fotoLoadT = contentPath;
                                          deskripsiController.clear();
                                        }
                                      }
                                    : () {
                                        fotoLoadT.contains(
                                                "https://jakban.iconpln.co.id")
                                            ? showImageViewer(context,
                                                Image.network(fotoLoadT).image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true)
                                            : showImageViewer(
                                                context,
                                                Image.file(File(fotoLoadT))
                                                    .image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true);
                                      },
                                child: Text(
                                  fotoLoadT.isEmpty ? "Tambah Foto" : fotoLoadT,
                                  style: buttonText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: fotoLoadT.isEmpty,
                              child: Icon(
                                Icons.photo_camera_outlined,
                                color: textLightColor,
                              ),
                            ),
                          ],
                        ),
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
                    controller: loadrController,
                    label: "Load R",
                    placeholder: "Load R",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: phasa == 3,
                    child: TextInput(
                      controller: loadsController,
                      label: "Load S",
                      placeholder: "Load S",
                    ),
                  ),
                  SizedBox(
                    height: phasa == 3 ? 20 : 0,
                  ),
                  Visibility(
                    visible: phasa == 3,
                    child: TextInput(
                      controller: loadtController,
                      label: "Load T",
                      placeholder: "Load T",
                    ),
                  ),
                  SizedBox(
                    height: phasa == 3 ? 20 : 0,
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
                          if (rectProvider.listRect.isEmpty) {
                            RectNilaiModel rect = await RectService().postRect(
                                rectId: widget.rect.id,
                                pmId: widget.pm.id,
                                loadr: double.parse(loadrController.text),
                                loads: loadsController.text.isEmpty
                                    ? 0.0
                                    : double.parse(loadsController.text),
                                loadt: loadtController.text.isEmpty
                                    ? 0.0
                                    : double.parse(loadtController.text),
                                temuan: temuanController.text,
                                rekomendasi: rekomendasiController.text);
                            imagesProvider.foto.forEach((key, value) async {
                              await RectService().postFotoRect(
                                  rectNilaiId: int.parse(rect.id),
                                  urlFoto: key,
                                  description: value);
                            });
                          } else {
                            RectNilaiModel rect = await RectService().editRect(
                                id: int.parse(rectProvider.listRect.last.id),
                                rectId: widget.rect.id,
                                pmId: widget.pm.id,
                                loadr: double.parse(loadrController.text),
                                loads: double.parse(loadsController.text),
                                loadt: double.parse(loadtController.text),
                                temuan: temuanController.text,
                                rekomendasi: rekomendasiController.text);
                          }
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
