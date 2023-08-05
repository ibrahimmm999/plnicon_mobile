import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_dropdown.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class BateraiPage extends StatelessWidget {
  const BateraiPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namaController = TextEditingController();
    TextEditingController merkController = TextEditingController();
    TextEditingController snController = TextEditingController();
    TextEditingController kapasitasController = TextEditingController();
    TextEditingController persentaseController = TextEditingController();
    TextEditingController vController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(
        isMainPage: false,
        title: "BATERAI",
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        children: [
          TextInput(
            controller: namaController,
            label: "Nama Baterai",
            placeholder: "Nama Baterai",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: merkController,
            label: "Merk Baterai",
            placeholder: "Merk Baterai",
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Tipe Baterai",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const CustomDropDown(list: ["LITHIUM", "VRLA"]),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: snController,
            label: "Serial Number Baterai",
            placeholder: "Serial Number Baterai",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: kapasitasController,
            label: "Kapasitas",
            placeholder: "Kapasitas",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: persentaseController,
            label: "Persentase",
            placeholder: "Persentase",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: vController,
            label: "Tegangan Baterai",
            placeholder: "Tegangan Baterai",
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
      ),
    );
  }
}
