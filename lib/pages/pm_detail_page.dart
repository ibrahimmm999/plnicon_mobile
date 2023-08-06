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
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class PMDetailPage extends StatelessWidget {
  const PMDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Function()> nama = {
      "AC": () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ACPage())),
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

    Widget switchContent() {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 52,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomePageNav(
                title: 'Data Teknis',
                index: 0,
                width: MediaQuery.sizeOf(context).width * 0.5),
            HomePageNav(
                title: 'Hasil Ukur/Uji',
                index: 1,
                width: MediaQuery.sizeOf(context).width * 0.5),
          ],
        ),
      );
    }

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
      return Expanded(
          child: ListView(
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
      ));
    }

    return Scaffold(
        appBar: const CustomAppBar(isMainPage: false, title: "Nama POP"),
        body: Column(
          children: [
            switchContent(),
            const SizedBox(
              height: 4,
            ),
            content()
          ],
        ));
  }
}

class HomePageNav extends StatelessWidget {
  const HomePageNav({
    Key? key,
    required this.title,
    required this.index,
    required this.width,
  }) : super(key: key);

  final String title;
  final int index;
  final double width;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          pageProvider.setHomePage = index;
        },
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
              ),
              Container(
                margin: const EdgeInsets.only(top: 14),
                height: 3,
                width: width,
                decoration: BoxDecoration(
                  color:
                      pageProvider.homePage == index ? primaryBlue : neutral500,
                  borderRadius: BorderRadius.circular(18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
