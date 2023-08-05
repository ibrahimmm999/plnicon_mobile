import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_dropdown.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class InverterPage extends StatelessWidget {
  const InverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loadController = TextEditingController();
    TextEditingController inputACController = TextEditingController();
    TextEditingController inputDCController = TextEditingController();
    TextEditingController outputDCController = TextEditingController();
    TextEditingController mainfallController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "INVERTER"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        children: [
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
            controller: inputDCController,
            label: "Input DC",
            placeholder: "Input DC",
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
          const CustomDropDown(list: ["OK", "Not OK"]),
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
      ),
    );
  }
}
