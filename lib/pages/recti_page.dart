import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class RectiPage extends StatefulWidget {
  const RectiPage({super.key});

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

    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "RECTIFIER"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        children: [
          InputDokumentasi(
              controller: deskripsiController, pageName: "rectifier"),
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
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false);
                },
                color: primaryBlue,
                clickColor: clickBlue),
          )
        ],
      ),
    );
  }
}
