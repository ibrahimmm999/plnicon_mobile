import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/ac_page.dart';
import 'package:plnicon_mobile/pages/environment_page.dart';
import 'package:plnicon_mobile/pages/ex_alarm_page.dart';
import 'package:plnicon_mobile/pages/genset_page.dart';
import 'package:plnicon_mobile/pages/inverter_page.dart';
import 'package:plnicon_mobile/pages/kwh_page.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/pages/pdb_page.dart';
import 'package:plnicon_mobile/pages/rack_page.dart';
import 'package:plnicon_mobile/pages/recti_page.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:provider/provider.dart';

class PmDetailPage extends StatefulWidget {
  const PmDetailPage({super.key, required this.pm});

  final PmModel pm;

  @override
  State<PmDetailPage> createState() => _PmDetailPageState();
}

class _PmDetailPageState extends State<PmDetailPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    PopProvider popProvider = Provider.of<PopProvider>(context, listen: false);
    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await popProvider.getDataPop(token: token, id: widget.pm.popId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    print("list: " + popProvider.listPop.toString());

    Widget card(String title) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(defaultMargin),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            // border: Border.all(width: 2),
            color: primaryBlue,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Text(
          title,
          style: buttonText,
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          leading: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                    (route) => false);
              },
              child: Icon(Icons.arrow_back)),
          title: Center(
            child: Container(
              margin: const EdgeInsets.only(right: 60),
              child: Text(
                widget.pm.pop.nama,
                style: header2.copyWith(color: textLightColor),
              ),
            ),
          ),
        ),
        // appBar: CustomAppBar(isMainPage: false, title: widget.pm.pop.nama),
        body: ListView(
            padding:
                EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
            children: popProvider.listPop.isEmpty
                ? [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                              backgroundColor: primaryBlue),
                        ],
                      ),
                    )
                  ]
                : [
                    Text(
                      "AC",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: popProvider.listPop.first.listAc.map((e) {
                        var index =
                            popProvider.listPop.first.listAc.indexOf(e) + 1;
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ACPage(
                                          acMaster: e,
                                          title: "AC $index",
                                        )),
                              );
                            },
                            child: card("AC $index  -  ${e.merk}"));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Genset",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: popProvider.listPop.first.listGenset.map((e) {
                        var index =
                            popProvider.listPop.first.listGenset.indexOf(e) + 1;
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GensetPage(
                                          gensetMasterModel: e,
                                          title: "Genset $index",
                                        )),
                              );
                            },
                            child: card("Genset $index  -  ${e.merk}"));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Inverter",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: popProvider.listPop.first.listInverter.map((e) {
                        var index =
                            popProvider.listPop.first.listInverter.indexOf(e) +
                                1;
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InverterPage(
                                          inverter: e,
                                          title: "Inverter $index",
                                        )),
                              );
                            },
                            child: card("Inverter $index  -  ${e.merk}"));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Rack",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: popProvider.listPop.first.listRack.map((e) {
                        var index =
                            popProvider.listPop.first.listRack.indexOf(e) + 1;
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RackPage(
                                          rack: e,
                                          title: "Rack $index",
                                        )),
                              );
                            },
                            child: card("Rack $index"));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Rectifier",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: popProvider.listPop.first.listRect.map((e) {
                        var index =
                            popProvider.listPop.first.listRect.indexOf(e) + 1;
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RectiPage(
                                          rect: e,
                                          title: "Rectifier $index",
                                        )),
                              );
                            },
                            child: card("Rectifier $index"));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "PDB",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: popProvider.listPop.first.listPdb.map((e) {
                        var index =
                            popProvider.listPop.first.listPdb.indexOf(e) + 1;
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PDBPage(
                                          pdb: e,
                                          title: "PDB $index",
                                        )),
                              );
                            },
                            child: card("PDB $index"));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "KWH",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: popProvider.listPop.first.listKwh.map((e) {
                        var index =
                            popProvider.listPop.first.listKwh.indexOf(e) + 1;
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KWHPage(
                                          kwh: e,
                                          title: "KWH $index",
                                        )),
                              );
                            },
                            child: card("KWH $index"));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Ex Alarm",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children: popProvider.listPop.first.listExAlarm.map((e) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExAlarmPage(
                                          exalarm: e,
                                          title: "Ex Alarm",
                                        )),
                              );
                            },
                            child: card("Ex Alarm "));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Environment",
                      style: header3,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Column(
                      children:
                          popProvider.listPop.first.listEnvironment.map((e) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EnvironmentPage(
                                          environment: e,
                                          title: "Environment",
                                        )),
                              );
                            },
                            child: card("Environment "));
                      }).toList(),
                    ),
                  ]));
  }
}
