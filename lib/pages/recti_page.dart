import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/services/transaksional/rect_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
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

String contentPath = '';
File? contentFile;

class _RectiPageState extends State<RectiPage> {
  @override
  void initState() {
    super.initState();
    contentPath = '';
    contentFile = null;
  }

  @override
  Widget build(BuildContext context) {
    int phasa = 3;
    TextEditingController loadrController = TextEditingController();
    TextEditingController loadsController = TextEditingController();
    TextEditingController loadtController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
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
                  InputDokumentasi(
                      imagesProvider: imagesProvider,
                      controller: deskripsiController,
                      pageName: "rectifier"),
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
                          await RectService().postRect(
                              rectId: widget.rect.id,
                              pmId: widget.pm.id,
                              loadr: double.parse(loadrController.text),
                              loads: double.parse(loadsController.text),
                              loadt: double.parse(loadtController.text),
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
