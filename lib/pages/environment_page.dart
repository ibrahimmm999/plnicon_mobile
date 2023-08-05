import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_dropdown.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class EnvironmentPage extends StatelessWidget {
  const EnvironmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController exhaustController = TextEditingController();
    TextEditingController kesehatanExhaustController = TextEditingController();
    TextEditingController lampuController = TextEditingController();
    TextEditingController jumlahLampuController = TextEditingController();
    TextEditingController kesehatanBangunanController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: 'ENVIRONMENT'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        children: [
          TextInput(
            controller: exhaustController,
            label: "Exhaust",
            placeholder: "Exhaust",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: kesehatanExhaustController,
            label: "Kesehatan Exhaust",
            placeholder: "Kesehatan Exhaust",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: lampuController,
            label: "Lampu",
            placeholder: "Lampu",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: jumlahLampuController,
            label: "Jumlah Lampu",
            placeholder: "Jumlah Lampu",
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Bangunan",
            style: buttonText.copyWith(color: textDarkColor),
          ),
          const CustomDropDown(
            list: ["OK", "B Aja", "Buruk"],
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: kesehatanBangunanController,
            label: "Kesehatan Bangunan",
            placeholder: "Kesehatan Bangunan",
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
