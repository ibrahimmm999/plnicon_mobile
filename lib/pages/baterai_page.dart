import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';

class BateraiPage extends StatelessWidget {
  const BateraiPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController loadController = TextEditingController();
    TextEditingController groupVBankController = TextEditingController();
    TextEditingController cellv1Controller = TextEditingController();
    TextEditingController cellv2Controller = TextEditingController();
    TextEditingController cellv3Controller = TextEditingController();
    TextEditingController cellv4Controller = TextEditingController();
    TextEditingController timeDischargeController = TextEditingController();
    TextEditingController stopUjiBateraiController = TextEditingController();
    TextEditingController performanceController = TextEditingController();
    TextEditingController sisaKapasitasController = TextEditingController();
    TextEditingController kemampuanBackUpTimeController =
        TextEditingController();
    TextEditingController jumlahBateraiRusakController =
        TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(
        isMainPage: false,
        title: "BATERAI",
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        children: [
          InputDokumentasi(
              controller: deskripsiController, pageName: "baterai"),
          TextInput(
            controller: loadController,
            label: "Load",
            placeholder: "Load",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: groupVBankController,
            label: "Group V bank",
            placeholder: "Group V bank",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: cellv1Controller,
            label: "Cell V1",
            placeholder: "Cell V1",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: cellv2Controller,
            label: "Cell V2",
            placeholder: "Cell V2",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: cellv3Controller,
            label: "Cell V3",
            placeholder: "Cell V3",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: cellv4Controller,
            label: "Cell V4",
            placeholder: "Cell V4",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: timeDischargeController,
            label: "Time Discharge",
            placeholder: "Time Discharge",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: stopUjiBateraiController,
            label: "Stop Uji Baterai",
            placeholder: "Stop Uji Baterai",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: performanceController,
            label: "Performance",
            placeholder: "Performance",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: sisaKapasitasController,
            label: "Sisa Kapasitas",
            placeholder: "Sisa Kapasitas",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: kemampuanBackUpTimeController,
            label: "Kemampuan Backup Time",
            placeholder: "Kemampuan Backup Time",
          ),
          const SizedBox(
            height: 20,
          ),
          TextInput(
            controller: jumlahBateraiRusakController,
            label: "Jumlah Baterai Rusak",
            placeholder: "Jumlah Baterai Rusak",
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
