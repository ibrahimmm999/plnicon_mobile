import 'package:flutter/material.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';

class SelectItemPMPage extends StatelessWidget {
  const SelectItemPMPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<String, Function()> nama = {
    //   "AC": () => Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => ACPage())),
    //   "Baterai": () => Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const BateraiPage())),
    //   "Environment": () => Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const EnvironmentPage())),
    //   "Genset": () => Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const GensetPage())),
    //   "KWH": () => Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const KWHPage())),
    //   "Perangkat": () => Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const DataPerangkatPage())),
    //   "Inverter": () => Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const InverterPage())),
    //   "Rectifier": () => Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const RectiPage())),
    //   "PDB": () => Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const PDBPage())),
    //   "Ex Alarm": () => Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => const ExAlarmPage()))
    // };
    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "Nama POP"),
      body: ListView(
        children: [],
      ),
    );
  }
}
