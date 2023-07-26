import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class ACPage extends StatefulWidget {
  const ACPage({super.key});

  @override
  State<ACPage> createState() => _ACPageState();
}

class _ACPageState extends State<ACPage> {
  @override
  Widget build(BuildContext context) {
    String? selectedItem;
    List<String> listHasilPengujian = ["Ok", "B aja", "Buruk"];
    TextEditingController suhuController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    return Scaffold(
        appBar: const CustomAppBar(isMainPage: false, title: "AC"),
        body: ListView(
          padding: EdgeInsets.all(defaultMargin),
          children: [
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
            DropdownButtonFormField(
              alignment: Alignment.centerLeft,
              style: buttonText.copyWith(color: textDarkColor),
              borderRadius: BorderRadius.circular(defaultRadius),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(defaultRadius),
                hintText: "-",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(width: 2, color: primaryBlue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(width: 2, color: neutral500),
                ),
                hintStyle: buttonText.copyWith(color: textDarkColor),
              ),
              items: listHasilPengujian
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                        ),
                      ))
                  .toList(),
              value: selectedItem,
              onChanged: (value) {
                selectedItem = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Dokumentasi",
              style: buttonText.copyWith(color: textDarkColor),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultMargin),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              child: Row(
                children: [
                  Text(
                    "Tambahkan dokumentasi",
                    style: buttonText,
                  )
                ],
              ),
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