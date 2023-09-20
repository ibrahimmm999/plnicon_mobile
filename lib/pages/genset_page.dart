import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/genset_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_genset_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/services/master/genset_master_service.dart';
import 'package:plnicon_mobile/services/transaksional/genset_service.dart';
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

    PopProvider popProvider = Provider.of<PopProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController fuelController = TextEditingController();
    TextEditingController hourMeterController = TextEditingController();
    TextEditingController teganganAccuController = TextEditingController();
    TextEditingController teganganChargerController = TextEditingController();
    TextEditingController arusChargerController = TextEditingController();
    TextEditingController tempOnController = TextEditingController();
    TextEditingController ujiBebanVoltController = TextEditingController();
    TextEditingController ujiBebanArusController = TextEditingController();
    TextEditingController ujiTanpaBebanArusController = TextEditingController();
    TextEditingController ujiTanpaBebanVoltController = TextEditingController();
    TextEditingController failOverTestController = TextEditingController();
    TextEditingController indoorCleanController = TextEditingController();
    TextEditingController outdoorCleanController = TextEditingController();
    TextEditingController kartuGantungUrlController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();

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
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                    "Accu",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Bahan Bakar",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kapasitas",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Max Fuel",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Accu",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Engine",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk Genset",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Switch",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tipe Batt Charger",
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
                          await GensetService().postGenset(
                              gensetId: widget.gensetMasterModel.id,
                              pmId: widget.pm.id,
                              fuel: int.parse(fuelController.text),
                              hourMeter: double.parse(hourMeterController.text),
                              teganganAccu:
                                  double.parse(teganganAccuController.text),
                              teganganCharger:
                                  double.parse(teganganChargerController.text),
                              arusCharger:
                                  double.parse(arusChargerController.text),
                              failOverTest: failOverTestController.text,
                              tempOn: double.parse(tempOnController.text),
                              ujiBebanVolt:
                                  double.parse(ujiBebanVoltController.text),
                              ujiBebanArus:
                                  double.parse(ujiBebanArusController.text),
                              ujiTanpaBebanVolt: double.parse(
                                  ujiTanpaBebanVoltController.text),
                              ujiTanpaBebanArus: double.parse(
                                  ujiTanpaBebanArusController.text),
                              indoorClean: indoorCleanController.text,
                              outdoorClean: outdoorCleanController.text,
                              kartuGantungUrl: kartuGantungUrlController.text,
                              temuan: temuanController.text,
                              rekomendasi: rekomendasiController.text);

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
