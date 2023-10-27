import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/inverter_master_model.dart';
import 'package:plnicon_mobile/models/nilai/inverter_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_inverter_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/transaksional/inverter_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class InverterPage extends StatefulWidget {
  const InverterPage(
      {super.key,
      required this.title,
      required this.inverter,
      required this.pm});
  final InverterMasterModel inverter;
  final String title;
  final PmModel pm;

  @override
  State<InverterPage> createState() => _InverterPageState();
}

class _InverterPageState extends State<InverterPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  String fotoFullRackInverter = "";
  String fotoDisplayInverter = "";
  String fotoInverterTampakDepan = "";
  bool loading = true;
  String hasilUji = "";
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider inverterProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);
    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await inverterProvider.getInverter(widget.pm.id, widget.inverter.id);
        hasilUji = inverterProvider.listInverter.isEmpty
            ? ""
            : inverterProvider.listInverter.first.hasilUji;
        if (inverterProvider.listInverter.isNotEmpty) {
          for (var element in inverterProvider.listInverter.first.foto!) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");

            if (element.deskripsi == "Foto Full Rack Inverter") {
              fotoFullRackInverter = url;
            } else if (element.deskripsi == "Foto Inverter Tampak Depan") {
              fotoInverterTampakDepan = url;
            } else if (element.deskripsi == "Foto Display Inverter") {
              fotoDisplayInverter = url;
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
    TransaksionalProvider inverterProvider =
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
        text: inverterProvider.listInverter.isEmpty
            ? ""
            : inverterProvider.listInverter.last.load);
    TextEditingController inputACController = TextEditingController(
        text: inverterProvider.listInverter.isEmpty
            ? ""
            : inverterProvider.listInverter.last.inputAc);
    TextEditingController inputDCController = TextEditingController(
        text: inverterProvider.listInverter.isEmpty
            ? ""
            : inverterProvider.listInverter.last.inputDc);
    TextEditingController outputDCController = TextEditingController(
        text: inverterProvider.listInverter.isEmpty
            ? ""
            : inverterProvider.listInverter.last.ouputDc);
    TextEditingController mainfallController = TextEditingController(
        text: inverterProvider.listInverter.isEmpty
            ? ""
            : inverterProvider.listInverter.last.mainfall);
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController temuanController = TextEditingController(
        text: inverterProvider.listInverter.isEmpty
            ? ""
            : inverterProvider.listInverter.last.temuan);
    TextEditingController rekomendasiController = TextEditingController(
        text: inverterProvider.listInverter.isEmpty
            ? ""
            : inverterProvider.listInverter.last.rekomendasi);

    PageProvider pageProvider = Provider.of<PageProvider>(context);

    List<String> listHasilPengujian = ["OK", "Not OK"];
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
                    "Merk : ${widget.inverter.merk}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kondisi : ${widget.inverter.kondisi}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tipe : ${widget.inverter.tipe}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kapasitas : ${widget.inverter.kapasitas}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SN : ${widget.inverter.sn}",
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
                                builder: (context) => EditInverterPage(
                                    inverter: widget.inverter,
                                    title: "Edit Inverter")));
                      },
                      color: primaryGreen,
                      clickColor: clickGreen),
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
                                                      "Foto Full Rack Inverter") {
                                                    fotoFullRackInverter = "";
                                                  } else if (e.value ==
                                                      "Foto Inverter Tampak Depan") {
                                                    fotoInverterTampakDepan =
                                                        "";
                                                  } else if (e.value ==
                                                      "Foto Display Inverter") {
                                                    fotoDisplayInverter = "";
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
                    "Foto Full Rack Inverter",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoFullRackInverter.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Full Rack Inverter");
                              // imagesProvider.foto[contentPath] =
                              //     imagesProvider.foto;
                              fotoFullRackInverter = contentPath;
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
                              onTap: fotoFullRackInverter.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "AC Outdoor");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoFullRackInverter = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoFullRackInverter.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoFullRackInverter)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoFullRackInverter))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoFullRackInverter.isEmpty
                                    ? "Tambah Foto"
                                    : fotoFullRackInverter,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoFullRackInverter.isEmpty,
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
                    "Foto Inverter Tampak Depan",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoInverterTampakDepan.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Inverter Tampak Depan");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoInverterTampakDepan = contentPath;
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
                              onTap: fotoInverterTampakDepan.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi:
                                                "Foto Inverter Tampak Depan");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoInverterTampakDepan = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoInverterTampakDepan.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(
                                                      fotoInverterTampakDepan)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(
                                                      fotoInverterTampakDepan))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoInverterTampakDepan.isEmpty
                                    ? "Tambah Foto"
                                    : fotoInverterTampakDepan,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: fotoInverterTampakDepan.isNotEmpty
                                ? () {
                                    setState(() {
                                      imagesProvider.deleteImage(
                                          path: fotoInverterTampakDepan);
                                      fotoInverterTampakDepan = "";
                                    });
                                  }
                                : () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi:
                                              "Foto Inverter Tampak Depan");
                                      // imagesProvider.listFoto[contentPath] =
                                      //     imagesProvider.foto;
                                      fotoInverterTampakDepan = contentPath;
                                      print(imagesProvider.foto);
                                      deskripsiController.clear();
                                    }
                                  },
                            child: Visibility(
                              visible: fotoInverterTampakDepan.isEmpty,
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
                    "Foto Display Inverter",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoDisplayInverter.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto Display Inverter");
                              // imagesProvider.listFoto[contentPath] =
                              //     imagesProvider.foto;
                              fotoDisplayInverter = contentPath;
                              print(imagesProvider.foto);
                              deskripsiController.clear();
                            }
                          }
                        : () {
                            fotoDisplayInverter
                                    .contains("https://jakban.iconpln.co.id")
                                ? showImageViewer(context,
                                    Image.network(fotoDisplayInverter).image,
                                    swipeDismissible: true,
                                    doubleTapZoomable: true)
                                : showImageViewer(context,
                                    Image.file(File(fotoDisplayInverter)).image,
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
                              onTap: fotoDisplayInverter.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Foto Display Inverter");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoDisplayInverter = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoDisplayInverter.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoDisplayInverter)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(
                                                      File(fotoDisplayInverter))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoDisplayInverter.isEmpty
                                    ? "Tambah Foto"
                                    : fotoDisplayInverter,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoDisplayInverter.isEmpty,
                            child: GestureDetector(
                              onTap: () async {
                                await handlePicker();
                                if (imagesProvider.croppedImageFile != null) {
                                  imagesProvider.addDeskripsi(
                                      path: contentPath,
                                      deskripsi: "Foto Display Inverter");
                                  // imagesProvider.listFoto[contentPath] =
                                  //     imagesProvider.foto;
                                  fotoDisplayInverter = contentPath;
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
                    controller: loadController,
                    label: "Load",
                    placeholder: "Load",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: inputACController,
                    label: "Input AC",
                    placeholder: "Input AC",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: inputDCController,
                    label: "Input DC",
                    placeholder: "Input DC",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: outputDCController,
                    label: "Output DC",
                    placeholder: "Output DC",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInput(
                    controller: mainfallController,
                    label: "Mainfall",
                    placeholder: "Mainfall",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hasil Uji",
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
                    value: hasilUji.isEmpty ? null : hasilUji,
                    onChanged: (value) {
                      hasilUji = value.toString();
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
                          if (inverterProvider.listInverter.isEmpty) {
                            InverterNilaiModel inverter =
                                await InverterService().postInverter(
                                    inverterId: widget.inverter.id,
                                    pmId: widget.pm.id,
                                    load: loadController.text,
                                    inputAc: inputACController.text,
                                    inputDc: inputDCController.text,
                                    outputDc: outputDCController.text,
                                    mainfall: mainfallController.text,
                                    hasilUji: hasilUji,
                                    temuan: temuanController.text,
                                    rekomendasi: rekomendasiController.text);
                          } else {
                            InverterNilaiModel inverter =
                                await InverterService().editInverter(
                                    id: inverterProvider.listInverter.last.id,
                                    inverterId: widget.inverter.id,
                                    pmId: widget.pm.id,
                                    load: loadController.text,
                                    inputAc: inputACController.text,
                                    inputDc: inputDCController.text,
                                    outputDc: outputDCController.text,
                                    mainfall: mainfallController.text,
                                    hasilUji: hasilUji,
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
