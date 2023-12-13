import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plnicon_mobile/models/foto_model.dart';
import 'package:plnicon_mobile/models/master/ac_master_model.dart';
import 'package:plnicon_mobile/models/nilai/ac_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_ac_page.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
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

class AcPage extends StatefulWidget {
  const AcPage({
    super.key,
    required this.acMaster,
    required this.pm,
    required this.title,
  });
  final AcMasterModel acMaster;
  final PmModel pm;
  final String title;

  @override
  State<AcPage> createState() => _AcPageState();
}

class _AcPageState extends State<AcPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  String fotoAcOutdoor = "";
  String fotoAcSuhu = "";
  String fotoAcIndoor = "";
  String pengujian = "";
  bool loading = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider acProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await acProvider.getAc(widget.pm.id, widget.acMaster.id);
        pengujian = acProvider.listAc.isEmpty
            ? ""
            : acProvider.listAc.first.hasilPengujian;
        if (acProvider.listAc.isNotEmpty) {
          for (var element in acProvider.listAc.first.foto!) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");

            if (element.deskripsi == "AC Outdoor") {
              fotoAcOutdoor = url;
            } else if (element.deskripsi == "AC Indoor") {
              fotoAcIndoor = url;
            } else if (element.deskripsi == "Suhu AC") {
              fotoAcSuhu = url;
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
    TransaksionalProvider acProvider =
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

    TextEditingController suhuController = TextEditingController(
        text: acProvider.listAc.isEmpty
            ? ""
            : acProvider.listAc.last.suhuAc.toString());
    TextEditingController temuanController = TextEditingController(
        text: acProvider.listAc.isEmpty ? "" : acProvider.listAc.last.temuan);
    TextEditingController rekomendasiController = TextEditingController(
        text: acProvider.listAc.isEmpty
            ? ""
            : acProvider.listAc.last.rekomendasi);
    TextEditingController deskripsiController = TextEditingController();

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
                    "Nama : ${widget.acMaster.nama}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kondisi : ${widget.acMaster.kondisi}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk : ${widget.acMaster.merk}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kapasitas : ${widget.acMaster.kapasitas}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tekanan Freon : ${widget.acMaster.tekananFreon}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Mode Hidup : ${widget.acMaster.modeHidup}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tanggal Instalasi : ${widget.acMaster.tanggalInstalasi}",
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
                                builder: (context) => EditAcPage(
                                      acMaster: widget.acMaster,
                                      title: "Edit AC",
                                      pm: widget.pm,
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
                        await AcMasterService()
                            .deleteAcMaster(id: widget.acMaster.id);
                        // ignore: use_build_context_synchronously
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
                                                if (e.value == "AC Outdoor") {
                                                  fotoAcOutdoor = "";
                                                } else if (e.value ==
                                                    "AC Indoor") {
                                                  fotoAcIndoor = "";
                                                } else if (e.value ==
                                                    "Suhu AC") {
                                                  fotoAcSuhu = "";
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
                  "Foto Ac Outdoor",
                  style: buttonText.copyWith(color: textDarkColor),
                ),
                GestureDetector(
                  onTap: fotoAcOutdoor.isEmpty
                      ? () async {
                          await handlePicker();
                          if (imagesProvider.croppedImageFile != null) {
                            imagesProvider.addDeskripsi(
                                path: contentPath, deskripsi: "AC Outdoor");
                            // imagesProvider.foto[contentPath] =
                            //     imagesProvider.foto;
                            fotoAcOutdoor = contentPath;
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
                            onTap: fotoAcOutdoor.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "AC Outdoor");
                                      // imagesProvider.listFoto[contentPath] =
                                      //     imagesProvider.foto;
                                      fotoAcOutdoor = contentPath;
                                      print(imagesProvider.foto);
                                      deskripsiController.clear();
                                    }
                                  }
                                : () {
                                    fotoAcOutdoor.contains(
                                            "https://jakban.iconpln.co.id")
                                        ? showImageViewer(context,
                                            Image.network(fotoAcOutdoor).image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true)
                                        : showImageViewer(
                                            context,
                                            Image.file(File(fotoAcOutdoor))
                                                .image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true);
                                  },
                            child: Text(
                              fotoAcOutdoor.isEmpty
                                  ? "Tambah Foto"
                                  : fotoAcOutdoor,
                              style: buttonText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: fotoAcOutdoor.isEmpty,
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
                  "Foto Ac Indoor",
                  style: buttonText.copyWith(color: textDarkColor),
                ),
                GestureDetector(
                  onTap: fotoAcIndoor.isEmpty
                      ? () async {
                          await handlePicker();
                          if (imagesProvider.croppedImageFile != null) {
                            imagesProvider.addDeskripsi(
                                path: contentPath, deskripsi: "AC Indoor");
                            // imagesProvider.listFoto[contentPath] =
                            //     imagesProvider.foto;
                            fotoAcIndoor = contentPath;
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
                            onTap: fotoAcIndoor.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "AC Indoor");
                                      // imagesProvider.listFoto[contentPath] =
                                      //     imagesProvider.foto;
                                      fotoAcIndoor = contentPath;
                                      print(imagesProvider.foto);
                                      deskripsiController.clear();
                                    }
                                  }
                                : () {
                                    fotoAcIndoor.contains(
                                            "https://jakban.iconpln.co.id")
                                        ? showImageViewer(context,
                                            Image.network(fotoAcIndoor).image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true)
                                        : showImageViewer(
                                            context,
                                            Image.file(File(fotoAcIndoor))
                                                .image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true);
                                  },
                            child: Text(
                              fotoAcIndoor.isEmpty
                                  ? "Tambah Foto"
                                  : fotoAcIndoor,
                              style: buttonText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: fotoAcIndoor.isNotEmpty
                              ? () {
                                  setState(() {
                                    imagesProvider.deleteImage(
                                        path: fotoAcIndoor);
                                    fotoAcIndoor = "";
                                  });
                                }
                              : () async {
                                  await handlePicker();
                                  if (imagesProvider.croppedImageFile != null) {
                                    imagesProvider.addDeskripsi(
                                        path: contentPath,
                                        deskripsi: "AC Indoor");
                                    // imagesProvider.listFoto[contentPath] =
                                    //     imagesProvider.foto;
                                    fotoAcIndoor = contentPath;
                                    print(imagesProvider.foto);
                                    deskripsiController.clear();
                                  }
                                },
                          child: Visibility(
                            visible: fotoAcIndoor.isEmpty,
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
                  "Foto Suhu",
                  style: buttonText.copyWith(color: textDarkColor),
                ),
                GestureDetector(
                  onTap: fotoAcSuhu.isEmpty
                      ? () async {
                          await handlePicker();
                          if (imagesProvider.croppedImageFile != null) {
                            imagesProvider.addDeskripsi(
                                path: contentPath, deskripsi: "Suhu AC");
                            // imagesProvider.listFoto[contentPath] =
                            //     imagesProvider.foto;
                            fotoAcSuhu = contentPath;
                            print(imagesProvider.foto);
                            deskripsiController.clear();
                          }
                        }
                      : () {
                          fotoAcSuhu.contains("https://jakban.iconpln.co.id")
                              ? showImageViewer(
                                  context, Image.network(fotoAcSuhu).image,
                                  swipeDismissible: true,
                                  doubleTapZoomable: true)
                              : showImageViewer(
                                  context, Image.file(File(fotoAcSuhu)).image,
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
                            onTap: fotoAcSuhu.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Suhu AC");
                                      // imagesProvider.listFoto[contentPath] =
                                      //     imagesProvider.foto;
                                      fotoAcSuhu = contentPath;
                                      print(imagesProvider.foto);
                                      deskripsiController.clear();
                                    }
                                  }
                                : () {
                                    fotoAcSuhu.contains(
                                            "https://jakban.iconpln.co.id")
                                        ? showImageViewer(context,
                                            Image.network(fotoAcSuhu).image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true)
                                        : showImageViewer(context,
                                            Image.file(File(fotoAcSuhu)).image,
                                            swipeDismissible: true,
                                            doubleTapZoomable: true);
                                  },
                            child: Text(
                              fotoAcSuhu.isEmpty ? "Tambah Foto" : fotoAcSuhu,
                              style: buttonText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: fotoAcSuhu.isEmpty,
                          child: GestureDetector(
                            onTap: () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath, deskripsi: "Suhu AC");
                                // imagesProvider.listFoto[contentPath] =
                                //     imagesProvider.foto;
                                fotoAcSuhu = contentPath;
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
                        if (acProvider.listAc.isEmpty) {
                          if (suhuController.text.isNotEmpty &&
                              pengujian.isNotEmpty &&
                              fotoAcIndoor.isNotEmpty &&
                              fotoAcOutdoor.isNotEmpty &&
                              fotoAcSuhu.isNotEmpty) {
                            AcNilaiModel ac = await AcService().postAc(
                                acId: widget.acMaster.id,
                                pmId: widget.pm.id,
                                suhuAc: int.parse(suhuController.text),
                                hasilPengujian: pengujian,
                                temuan: temuanController.text,
                                rekomendasi: rekomendasiController.text);
                            imagesProvider.foto.forEach((key, value) async {
                              await AcService().postFotoAc(
                                  acNilaiId: ac.id,
                                  urlFoto: key,
                                  description: value);
                            });
                            Navigator.pop(context);
                          } else {
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
                          if (suhuController.text.isNotEmpty &&
                              pengujian.isNotEmpty &&
                              fotoAcIndoor.isNotEmpty &&
                              fotoAcOutdoor.isNotEmpty &&
                              fotoAcSuhu.isNotEmpty) {
                            AcNilaiModel ac = await AcService().editAc(
                                foto: [
                                  const FotoModel(
                                      id: 99,
                                      url: "url",
                                      deskripsi: "deskripsi")
                                ],
                                id: acProvider.listAc.last.id,
                                acId: widget.acMaster.id,
                                pmId: widget.pm.id,
                                suhuAc: int.parse(suhuController.text),
                                hasilPengujian: pengujian,
                                temuan: temuanController.text,
                                rekomendasi: rekomendasiController.text);
                            if (acProvider.listAc.isNotEmpty) {
                              print(acProvider.listAc.last.foto);
                              for (var item in acProvider.listAc.last.foto!) {
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
                                  await AcService()
                                      .deleteImage(imageId: item.id);
                                }
                              }
                            }
                            print("ISI IMAGE PROVIDER");
                            print(imagesProvider.foto);
                            imagesProvider.foto.forEach((key, value) async {
                              if (!(key
                                  .contains("https://jakban.iconpln.co.id"))) {
                                await AcService().postFotoAc(
                                    acNilaiId: ac.id,
                                    urlFoto: key,
                                    description: value);
                              }
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } else {
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
                        // ignore: use_build_context_synchronously
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
