// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/kwh_master_model.dart';
import 'package:plnicon_mobile/models/nilai/kwh_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_kwh_page.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/master/kwh_master_service.dart';
import 'package:plnicon_mobile/services/transaksional/kwh_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
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
  void initState() {
    getinit();
    super.initState();
  }

  String fotoKwh = "";
  String fotoVrn = "";
  String fotoVsn = "";
  String fotoVtn = "";
  String fotoVrs = "";
  String fotoVst = "";
  String fotoVrt = "";
  String fotoVng = "";
  String fotoLoadR = "";
  String fotoLoadS = "";
  String fotoLoadT = "";
  bool loading = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider kwhProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    imagesProvider.clearList();
    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await kwhProvider.getKwh(widget.pm.id, widget.kwh.id);
        if (kwhProvider.listKwh.isNotEmpty) {
          for (var element in kwhProvider.listKwh.first.foto!) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");

            if (element.deskripsi == "Foto KWH") {
              fotoKwh = url;
            } else if (element.deskripsi == "Tegangan Phasa R") {
              fotoVrn = url;
            } else if (element.deskripsi == "Tegangan Phasa S") {
              fotoVsn = url;
            } else if (element.deskripsi == "Tegangan Phasa T") {
              fotoVtn = url;
            } else if (element.deskripsi == "Tegangan R-S") {
              fotoVrs = url;
            } else if (element.deskripsi == "Tegangan R-T") {
              fotoVrt = url;
            } else if (element.deskripsi == "Tegangan S-T") {
              fotoVst = url;
            } else if (element.deskripsi == "Tegangan N-G") {
              fotoVng = url;
            } else if (element.deskripsi == "Load Phasa R") {
              fotoLoadR = url;
            } else if (element.deskripsi == "Load Phasa S") {
              fotoLoadS = url;
            } else if (element.deskripsi == "Load Phasa T") {
              fotoLoadT = url;
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
    TransaksionalProvider kwhProvider =
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

    TextEditingController deskripsiController = TextEditingController();

    TextEditingController rsVoltageController = TextEditingController(
        text: kwhProvider.listKwh.isEmpty ? "" : kwhProvider.listKwh.last.vrs);

    TextEditingController rtVoltageController = TextEditingController(
        text: kwhProvider.listKwh.isEmpty ? "" : kwhProvider.listKwh.last.vrt);
    TextEditingController ngVoltageController = TextEditingController(
        text: kwhProvider.listKwh.isEmpty ? "" : kwhProvider.listKwh.last.vng);

    TextEditingController stVoltageController = TextEditingController(
        text: kwhProvider.listKwh.isEmpty ? "" : kwhProvider.listKwh.last.vst);
    TextEditingController teganganPhasaRController = TextEditingController(
        text: kwhProvider.listKwh.isEmpty ? "" : kwhProvider.listKwh.last.vrn);
    TextEditingController teganganPhasaSController = TextEditingController(
        text: kwhProvider.listKwh.isEmpty ? "" : kwhProvider.listKwh.last.vsn);
    TextEditingController teganganPhasaTController = TextEditingController(
        text: kwhProvider.listKwh.isEmpty ? "" : kwhProvider.listKwh.last.vtn);

    TextEditingController temuanController = TextEditingController(
        text:
            kwhProvider.listKwh.isEmpty ? "" : kwhProvider.listKwh.last.temuan);

    TextEditingController loadPhasaR = TextEditingController(
        text: kwhProvider.listKwh.isEmpty
            ? ""
            : kwhProvider.listKwh.last.loadPhasaR);

    TextEditingController loadPhasaS = TextEditingController(
        text: kwhProvider.listKwh.isEmpty
            ? ""
            : kwhProvider.listKwh.last.loadPhasaS);

    TextEditingController loadPhasaT = TextEditingController(
        text: kwhProvider.listKwh.isEmpty
            ? ""
            : kwhProvider.listKwh.last.loadPhasaT);
    TextEditingController rekomendasiController = TextEditingController(
        text: kwhProvider.listKwh.isEmpty
            ? ""
            : kwhProvider.listKwh.last.rekomendasi);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    Widget input() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: loadPhasaR,
                  label: "Load R",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: loadPhasaS,
                  label: "Load S",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: loadPhasaT,
                  label: "Load T",
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
                  controller: rsVoltageController,
                  label: "Tegangan R-S",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: rtVoltageController,
                  label: "R-T voltage",
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
                  controller: stVoltageController,
                  label: "Tegangan S-T",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: ngVoltageController,
                  label: "Tegangan N-G",
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
                  controller: teganganPhasaRController,
                  label: "Tegangan R",
                  suffixText: "",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: teganganPhasaSController,
                  label: "Tegangan S",
                  suffixText: "",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: teganganPhasaTController,
                  label: "Tegangan T",
                  suffixText: "",
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
                  if (kwhProvider.listKwh.isEmpty) {
                    if (fotoKwh.isNotEmpty &&
                        fotoLoadR.isNotEmpty &&
                        fotoLoadS.isNotEmpty &&
                        fotoLoadT.isNotEmpty &&
                        fotoVng.isNotEmpty &&
                        fotoVrn.isNotEmpty &&
                        fotoVrs.isNotEmpty &&
                        fotoVrt.isNotEmpty &&
                        fotoVsn.isNotEmpty &&
                        fotoVst.isNotEmpty &&
                        fotoVtn.isNotEmpty) {
                      KwhNilaiModel kwhInput = await KwhService().postKwh(
                          kwhId: widget.kwh.id,
                          pmId: widget.pm.id,
                          loadr: loadPhasaR.text,
                          loads: loadPhasaS.text,
                          loadt: loadPhasaT.text,
                          vrs: rsVoltageController.text,
                          vrt: rtVoltageController.text,
                          vst: stVoltageController.text,
                          vng: ngVoltageController.text,
                          vrn: teganganPhasaRController.text,
                          vsn: teganganPhasaSController.text,
                          vtn: teganganPhasaTController.text,
                          temuan: temuanController.text,
                          rekomendasi: rekomendasiController.text);
                      imagesProvider.foto.forEach((key, value) async {
                        await KwhService().postFotoKwh(
                            kwhNilaiId: int.parse(kwhInput.id),
                            urlFoto: key,
                            description: deskripsiController.text);
                        Navigator.pop(context);
                      });
                    } else {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
                  } else {
                    if (fotoKwh.isNotEmpty &&
                        fotoLoadR.isNotEmpty &&
                        fotoLoadS.isNotEmpty &&
                        fotoLoadT.isNotEmpty &&
                        fotoVng.isNotEmpty &&
                        fotoVrn.isNotEmpty &&
                        fotoVrs.isNotEmpty &&
                        fotoVrt.isNotEmpty &&
                        fotoVsn.isNotEmpty &&
                        fotoVst.isNotEmpty &&
                        fotoVtn.isNotEmpty) {
                      KwhNilaiModel kwhInput = await KwhService().editKwh(
                          id: int.parse(kwhProvider.listKwh.last.id),
                          kwhId: widget.kwh.id,
                          pmId: widget.pm.id,
                          loadr: double.parse(loadPhasaR.text),
                          loads: double.parse(loadPhasaS.text),
                          loadt: double.parse(loadPhasaT.text),
                          vrs: double.parse(rsVoltageController.text),
                          vrt: double.parse(rtVoltageController.text),
                          vst: double.parse(stVoltageController.text),
                          vng: double.parse(ngVoltageController.text),
                          vrn: double.parse(teganganPhasaRController.text),
                          vsn: double.parse(teganganPhasaSController.text),
                          vtn: double.parse(teganganPhasaTController.text),
                          temuan: temuanController.text,
                          rekomendasi: rekomendasiController.text);
                      //  if (acProvider.listKwh.isNotEmpty) {
                      //   for (var item in acProvider.listKwh.last.foto!) {
                      //     await AcService().deleteImage(imageId: item.id);
                      //   }
                      // }
                      imagesProvider.foto.forEach((key, value) async {
                        await KwhService().postFotoKwh(
                            kwhNilaiId: int.parse(kwhInput.id),
                            urlFoto: key,
                            description: deskripsiController.text);
                      });
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
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
                    "Tanggal Instalasi : ${widget.kwh.tanggalInstalasi}",
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
                                    pm: widget.pm,
                                    kwh: widget.kwh,
                                    title: "Edit KWH")));
                      },
                      color: primaryGreen,
                      clickColor: clickGreen),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Delete",
                      onPressed: () async {
                        await KwhMasterService()
                            .deleteKwhMaster(id: widget.kwh.id);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    PmDetailPage(pm: widget.pm))),
                            (route) => false);
                      },
                      color: primaryRed,
                      clickColor: clickRed),
                ],
              ),
            );
          }
        case 1:
          {
            return Scaffold(
              backgroundColor: Colors.white,
              body: loading
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Center(child: CircularProgressIndicator())],
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultMargin, vertical: 20),
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
                                                e.key.contains(
                                                        "https://jakban.iconpln.co.id")
                                                    ? showImageViewer(
                                                        context,
                                                        Image.network(e.key)
                                                            .image,
                                                        swipeDismissible: true,
                                                        doubleTapZoomable: true)
                                                    : showImageViewer(
                                                        context,
                                                        Image.file(File(e.key))
                                                            .image,
                                                        swipeDismissible: true,
                                                        doubleTapZoomable:
                                                            true);
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
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          imagesProvider
                                                              .deleteImage(
                                                                  path: e.key);
                                                          if (e.value ==
                                                              "Foto KWH") {
                                                            fotoKwh = "";
                                                          } else if (e.value ==
                                                              "Foto Load R") {
                                                            fotoLoadR = "";
                                                          } else if (e.value ==
                                                              "Foto Load S") {
                                                            fotoLoadS = "";
                                                          } else if (e.value ==
                                                              "Foto Load T") {
                                                            fotoLoadT = "";
                                                          } else if (e.value ==
                                                              "Foto Tegangan N-G") {
                                                            fotoVng = "";
                                                          } else if (e.value ==
                                                              "Foto Tegangan Phasa R") {
                                                            fotoVrn = "";
                                                          } else if (e.value ==
                                                              "Foto Tegangan R-S") {
                                                            fotoVrs = "";
                                                          } else if (e.value ==
                                                              "Foto Tegangan R-T") {
                                                            fotoVrt = "";
                                                          } else if (e.value ==
                                                              "Foto Tegangan Phasa S") {
                                                            fotoVsn = "";
                                                          } else if (e.value ==
                                                              "Foto Tegangan S-T") {
                                                            fotoVst = "";
                                                          } else if (e.value ==
                                                              "Foto Tegangan Phasa T") {
                                                            fotoVtn = "";
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 255, 73, 60),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                            "Foto KWH",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoKwh.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Foto KWH");
                                      fotoKwh = contentPath;
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoKwh.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi: "Foto KWH");
                                                fotoKwh = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoKwh.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoKwh)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(File(fotoKwh))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoKwh.isEmpty
                                            ? "Tambah Foto"
                                            : fotoKwh,
                                        style: buttonText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: fotoKwh.isEmpty,
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
                            "Foto Tegangan Phasa R",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoVrn.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Tegangan Phasa R");
                                      fotoVrn = contentPath;
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoVrn.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi:
                                                        "Tegangan Phasa R");
                                                fotoVrn = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoVrn.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoVrn)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(File(fotoVrn))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoVrn.isEmpty
                                            ? "Tambah Foto"
                                            : fotoVrn,
                                        style: buttonText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: fotoVrn.isEmpty,
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
                            "Foto Tegangan Phasa S",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoVsn.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Tegangan Phasa S");
                                      fotoVsn = contentPath;
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoVsn.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi:
                                                        "Tegangan Phasa S");
                                                fotoVsn = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoVsn.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoVsn)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(File(fotoVsn))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoVsn.isEmpty
                                            ? "Tambah Foto"
                                            : fotoVsn,
                                        style: buttonText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: fotoVsn.isEmpty,
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
                            "Foto Tegangan Phasa T",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoVst.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Tegangan Phasa T");
                                      fotoVst = contentPath;
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoVst.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi:
                                                        "Tegangan Phasa T");
                                                fotoVst = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoVst.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoVst)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(File(fotoVst))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoVst.isEmpty
                                            ? "Tambah Foto"
                                            : fotoVst,
                                        style: buttonText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: fotoVst.isEmpty,
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
                            "Foto Tegangan R-S",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoVrs.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Tegangan R-S");
                                      fotoVrs = contentPath;
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoVrs.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi: "Tegangan R-S");
                                                fotoVrs = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoVrs.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoVrs)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(File(fotoVrs))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoVrs.isEmpty
                                            ? "Tambah Foto"
                                            : fotoVrs,
                                        style: buttonText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: fotoVrs.isEmpty,
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
                            "Foto Tegangan R-T",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoVrt.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Tegangan R-T");
                                      fotoVrt = contentPath;
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoVrt.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi: "Tegangan R-T");
                                                fotoVrt = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoVrt.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoVrt)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(File(fotoVrt))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoVrt.isEmpty
                                            ? "Tambah Foto"
                                            : fotoVrt,
                                        style: buttonText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: fotoVrt.isEmpty,
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
                            "Foto Tegangan S-T",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoVst.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Tegangan S-T");
                                      fotoVst = contentPath;
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoVst.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi: "Tegangan S-T");
                                                fotoVst = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoVst.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoVst)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(File(fotoVst))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoVst.isEmpty
                                            ? "Tambah Foto"
                                            : fotoVst,
                                        style: buttonText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: fotoVst.isEmpty,
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
                            "Foto Tegangan N-G",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoVng.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Tegangan N-G");
                                      fotoVng = contentPath;
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoVng.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi: "Tegangan N-G");
                                                fotoVng = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoVng.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoVng)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(File(fotoVng))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoVng.isEmpty
                                            ? "Tambah Foto"
                                            : fotoVng,
                                        style: buttonText,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: fotoVng.isEmpty,
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
                            "Foto Load Phasa R",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoLoadR.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Load Phasa R");
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoLoadR.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi: "Load Phasa R");
                                                fotoLoadR = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoLoadR.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoLoadR)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(
                                                              File(fotoLoadR))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoLoadR.isEmpty
                                            ? "Tambah Foto"
                                            : fotoLoadR,
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
                          Text(
                            "Foto Load Phasa S",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoLoadS.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Load Phasa S");
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoLoadS.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi: "Load Phasa S");
                                                fotoLoadS = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoLoadS.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoLoadS)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(
                                                              File(fotoLoadS))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoLoadS.isEmpty
                                            ? "Tambah Foto"
                                            : fotoLoadS,
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
                          Text(
                            "Foto Load Phasa T",
                            style: buttonText.copyWith(color: textDarkColor),
                          ),
                          GestureDetector(
                            onTap: fotoLoadT.isEmpty
                                ? () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Load Phasa T");
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
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: fotoLoadT.isEmpty
                                          ? () async {
                                              await handlePicker();
                                              if (imagesProvider
                                                      .croppedImageFile !=
                                                  null) {
                                                imagesProvider.addDeskripsi(
                                                    path: contentPath,
                                                    deskripsi: "Load Phasa T");
                                                fotoLoadT = contentPath;
                                                deskripsiController.clear();
                                              }
                                            }
                                          : () {
                                              fotoLoadT.contains(
                                                      "https://jakban.iconpln.co.id")
                                                  ? showImageViewer(
                                                      context,
                                                      Image.network(fotoLoadT)
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true)
                                                  : showImageViewer(
                                                      context,
                                                      Image.file(
                                                              File(fotoLoadT))
                                                          .image,
                                                      swipeDismissible: true,
                                                      doubleTapZoomable: true);
                                            },
                                      child: Text(
                                        fotoLoadT.isEmpty
                                            ? "Tambah Foto"
                                            : fotoLoadT,
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
