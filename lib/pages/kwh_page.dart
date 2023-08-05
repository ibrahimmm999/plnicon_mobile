import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class KWHPage extends StatelessWidget {
  const KWHPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> inputFoto = [
      "Foto panel keseluruhan",
      "Load R",
      "Load S",
      "Load T",
      "Tegangan R",
      "Tegangan S",
      "Tegangan T"
    ];
    TextEditingController deskripsiController = TextEditingController();

    TextEditingController loadR = TextEditingController();

    TextEditingController loadS = TextEditingController();

    TextEditingController loadT = TextEditingController();

    TextEditingController teganganR = TextEditingController();

    TextEditingController teganganS = TextEditingController();

    TextEditingController teganganT = TextEditingController();

    TextEditingController temuanController = TextEditingController();

    TextEditingController rekomendasiController = TextEditingController();

    Widget input() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: loadR,
                  label: "Load R",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: loadS,
                  label: "Load S",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: loadT,
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
                  controller: teganganR,
                  label: "Tegangan R",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: teganganS,
                  label: "Tegangan S",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: teganganT,
                  label: "Load T",
                  suffixText: "V",
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
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "KWH"),
      backgroundColor: Colors.white,
      body: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
          children: [
            InputDokumentasi(
              controller: deskripsiController,
              pageName: "kwh",
            ),
            input()
          ]),
    );
  }
}
