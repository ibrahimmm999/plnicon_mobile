import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/ac_page.dart';
import 'package:plnicon_mobile/pages/baterai_page.dart';
import 'package:plnicon_mobile/pages/data_perangkat_page.dart';
import 'package:plnicon_mobile/pages/environment_page.dart';
import 'package:plnicon_mobile/pages/ex_alarm_page.dart';
import 'package:plnicon_mobile/pages/genset_page.dart';
import 'package:plnicon_mobile/pages/inverter_page.dart';
import 'package:plnicon_mobile/pages/kwh_page.dart';
import 'package:plnicon_mobile/pages/pdb_page.dart';
import 'package:plnicon_mobile/pages/recti_page.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class HasilUkurPage extends StatelessWidget {
  const HasilUkurPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Function()> nama = {
      "AC": () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ACPage())),
      "Baterai": () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BateraiPage())),
      "Environment": () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const EnvironmentPage())),
      "Genset": () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const GensetPage())),
      "KWH": () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const KWHPage())),
      "Perangkat": () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DataPerangkatPage())),
      "Inverter": () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const InverterPage())),
      "Rectifier": () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const RectiPage())),
      "PDB": () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PDBPage())),
      "Ex Alarm": () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ExAlarmPage()))
    };
    Widget card(String title, Function() ontap) {
      return GestureDetector(
        onTap: ontap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: neutral500,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(52, 0, 0, 0),
                    offset: Offset(0, 4),
                    blurRadius: 4)
              ],
              borderRadius: BorderRadius.circular(defaultRadius)),
          width: double.infinity,
          height: 60,
          child: Center(
              child: Text(
            title,
            style: buttonText.copyWith(color: textDarkColor),
          )),
        ),
      );
    }

    Widget choice() {
      return GridView.builder(
        physics:
            const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
        shrinkWrap: true,
        itemCount: nama.length,
        padding: EdgeInsets.symmetric(vertical: defaultMargin),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: nama.values.elementAt(index),
            child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: Center(child: Text(nama.keys.elementAt(index)))),
          );
        },
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          choice(),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Rekap Hasil",
            style: header3,
          ),
          const SizedBox(
            height: 20,
          ),
          card(
              "AC",
              () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ACPage())))
        ],
      );
    }

    return Scaffold(
      body: content(),
    );
  }
}
