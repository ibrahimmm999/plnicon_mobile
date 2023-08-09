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
    TextEditingController deskripsiController = TextEditingController();

    TextEditingController rAmpereController = TextEditingController();

    TextEditingController sAmpereController = TextEditingController();

    TextEditingController tAmpereController = TextEditingController();

    TextEditingController rnVoltageController = TextEditingController();

    TextEditingController snVoltageController = TextEditingController();

    TextEditingController tnVoltageController = TextEditingController();
    TextEditingController bebanAcRController = TextEditingController();
    TextEditingController bebanAcSController = TextEditingController();
    TextEditingController bebanAcTController = TextEditingController();

    TextEditingController temuanController = TextEditingController();

    TextEditingController rekomendasiController = TextEditingController();

    Widget input() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: rAmpereController,
                  label: "R (ampere)",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: sAmpereController,
                  label: "S (ampere)",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: tAmpereController,
                  label: "T (ampere)",
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
                  controller: rnVoltageController,
                  label: "R-N voltage",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: snVoltageController,
                  label: "S-N voltage",
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
                  controller: tnVoltageController,
                  label: "T-N voltage",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: snVoltageController,
                  label: "N-G voltage",
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
                  controller: bebanAcRController,
                  label: "R Ampere",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: bebanAcSController,
                  label: "S Ampere",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: bebanAcTController,
                  label: "T Ampere",
                  suffixText: "A",
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
              isKwhPage: true,
              pageName: "kwh",
            ),
            Visibility(visible: inputCount == 1, child: input())
          ]),
    );
  }
}
