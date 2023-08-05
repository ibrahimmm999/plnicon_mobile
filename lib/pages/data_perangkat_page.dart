import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_dropdown.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class DataPerangkatPage extends StatelessWidget {
  const DataPerangkatPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namaController = TextEditingController();
    TextEditingController merkController = TextEditingController();
    TextEditingController terminasiController = TextEditingController();
    TextEditingController tipeController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "DATA PERANGKAT"),
      body: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
          children: [
            TextInput(
              controller: namaController,
              label: "Nama Perangkat",
              placeholder: "Nama Perangkat",
            ),
            const SizedBox(
              height: 20,
            ),
            TextInput(
              controller: merkController,
              label: "Merk",
              placeholder: "Merk",
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Sumber Main",
              style: buttonText.copyWith(color: textDarkColor),
            ),
            const CustomDropDown(list: ["AC", "DC"]),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Sumber Backup",
              style: buttonText.copyWith(color: textDarkColor),
            ),
            const CustomDropDown(list: ["AC", "DC", "Tidak Ada"]),
            const SizedBox(
              height: 20,
            ),
            TextInput(
              controller: terminasiController,
              placeholder: "Terminasi",
              label: "Terminasi",
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Jenis",
              style: buttonText.copyWith(color: textDarkColor),
            ),
            const CustomDropDown(list: ["Aktif", "ODF"]),
            const SizedBox(
              height: 20,
            ),
            TextInput(
              controller: tipeController,
              placeholder: "Tipe",
              label: "Tipe",
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
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                        (route) => false);
                  },
                  color: primaryBlue,
                  clickColor: clickBlue),
            )
          ]),
    );
  }
}
