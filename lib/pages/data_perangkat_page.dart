import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class DataPerangkatPage extends StatelessWidget {
  const DataPerangkatPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "DATA PERANGKAT"),
      body: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
          children: [
            InputDokumentasi(
                controller: deskripsiController, pageName: "perangkat"),
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
