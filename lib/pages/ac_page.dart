import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_dropdown.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class ACPage extends StatelessWidget {
  const ACPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController suhuController = TextEditingController(text: '');

    TextEditingController temuanController = TextEditingController(text: '');

    TextEditingController rekomendasiController =
        TextEditingController(text: '');
    TextEditingController deskripsiController = TextEditingController(text: "");
    List<String> listHasilPengujian = ["Ok", "B aja", "Buruk"];

    return Scaffold(
        appBar: const CustomAppBar(isMainPage: false, title: "AC"),
        body: ListView(
          padding: EdgeInsets.all(defaultMargin),
          children: [
            InputDokumentasi(controller: deskripsiController, pageName: "ac"),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 120, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextInput(
                      controller: suhuController,
                      label: "Suhu",
                      placeholder: "Suhu",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 8),
                    child: Text(
                      "°C",
                      style: GoogleFonts.montserrat(
                          color: textDarkColor,
                          fontSize: 24,
                          fontWeight: medium),
                    ),
                  )
                ],
              ),
            ),
            Text(
              "Hasil Pengujian",
              style: buttonText.copyWith(color: textDarkColor),
            ),
            CustomDropDown(list: listHasilPengujian),
            const SizedBox(
              height: 20,
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
          ],
        ));
  }
}
