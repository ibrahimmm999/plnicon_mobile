import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class GensetPage extends StatelessWidget {
  const GensetPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController deskripsiController = TextEditingController();
    TextEditingController fuelController = TextEditingController();
    TextEditingController hourMeterController = TextEditingController();
    TextEditingController teganganAccuController = TextEditingController();
    TextEditingController teganganChargerController = TextEditingController();
    TextEditingController arusChargerController = TextEditingController();
    TextEditingController tempOnController = TextEditingController();
    TextEditingController ujiBebanVoltController = TextEditingController();
    TextEditingController ujiBebanArusController = TextEditingController();
    TextEditingController ujiTanpaBebanArusController = TextEditingController();
    TextEditingController ujiTanpaBebanVoltController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "GENSET"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        children: [
          InputDokumentasi(controller: deskripsiController, pageName: "genset"),
          TextInput(
            controller: fuelController,
            label: "Fuel",
            placeholder: "Fuel",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: hourMeterController,
            label: "Hour Meter",
            placeholder: "Hour Meter",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: teganganAccuController,
            label: "Tegangan Accu",
            placeholder: "Tegangan Accu",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: teganganChargerController,
            label: "Tegangan Charger",
            placeholder: "Tegangan Charger",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: arusChargerController,
            label: "Arus Charger",
            placeholder: "Arus Charger",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: tempOnController,
            label: "Temp On",
            placeholder: "Temp On",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: ujiBebanVoltController,
            label: "Uji Beban Volt",
            placeholder: "Uji Beban Volt",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: ujiBebanArusController,
            label: "Uji Beban Arus",
            placeholder: "Uji Beban Arus",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: ujiTanpaBebanVoltController,
            label: "Uji Tanpa Beban Volt",
            placeholder: "Uji Tanpa Beban Volt",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: ujiTanpaBebanArusController,
            label: "Uji Tanpa Beban Arus",
            placeholder: "Uji Tanpa Beban Arus",
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
