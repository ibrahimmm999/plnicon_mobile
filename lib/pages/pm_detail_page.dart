import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/ac_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_ac_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_ats_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_baterai_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_environment_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_exalarm_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_genset_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_inverter_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_kwh_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_mcb_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_modul_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_pdb_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_perangkat_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_rack_page.dart';
import 'package:plnicon_mobile/pages/add_master/add_recti_page.dart';
import 'package:plnicon_mobile/pages/ats_page.dart';
import 'package:plnicon_mobile/pages/baterai_page.dart';
import 'package:plnicon_mobile/pages/data_perangkat_page.dart';
import 'package:plnicon_mobile/pages/environment_page.dart';
import 'package:plnicon_mobile/pages/ex_alarm_page.dart';
import 'package:plnicon_mobile/pages/genset_page.dart';
import 'package:plnicon_mobile/pages/inverter_page.dart';
import 'package:plnicon_mobile/pages/kwh_page.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/pages/mcb_page.dart';
import 'package:plnicon_mobile/pages/modul_page.dart';
import 'package:plnicon_mobile/pages/pdb_page.dart';
import 'package:plnicon_mobile/pages/rack_page.dart';
import 'package:plnicon_mobile/pages/recti_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/pop_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/services/pm_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
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

  bool isLoading = false;
  getinit() async {
    setState(() {
      isLoading = true;
    });
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    PopProvider popProvider = Provider.of<PopProvider>(context, listen: false);
    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await popProvider.getDataPop(id: widget.pm.popId);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    PopProvider popProvider = Provider.of<PopProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    Widget card(String title) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Text(
          title,
          style: buttonText.copyWith(color: textDarkColor),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          leading: GestureDetector(
              onTap: () {
                popProvider.listPop.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false);
              },
              child: const Icon(Icons.arrow_back)),
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
        body: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: CircularProgressIndicator(
                          backgroundColor: primaryBlue)),
                ],
              )
            : ListView(
                padding: EdgeInsets.only(
                    left: defaultMargin,
                    top: 20,
                    right: defaultMargin,
                    bottom: 60),
                children: [
                    // KWH
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "KWH",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddKwhPage(
                                                    popId: widget.pm.popId,
                                                  )),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listKwh.isNotEmpty
                                      ? popProvider.listPop.first.listKwh
                                          .map((e) {
                                          var index = popProvider
                                                  .listPop.first.listKwh
                                                  .indexOf(e) +
                                              1;
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          KWHPage(
                                                            pm: widget.pm,
                                                            kwh: e,
                                                            title: "KWH $index",
                                                          )),
                                                );
                                              },
                                              child: card("KWH $index"));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),

                    // Genset
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Genset",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddGensetPage(
                                                      popId: widget.pm.popId))),
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listGenset.isNotEmpty
                                      ? popProvider.listPop.first.listGenset
                                          .map((e) {
                                          var index = popProvider
                                                  .listPop.first.listGenset
                                                  .indexOf(e) +
                                              1;
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          GensetPage(
                                                            pm: widget.pm,
                                                            gensetMasterModel:
                                                                e,
                                                            title:
                                                                "Genset $index",
                                                          )),
                                                );
                                              },
                                              child: card(
                                                  "Genset $index  -  ${e.merk}"));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),

                    // ATS
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "ATS",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddAtsPage(
                                                  popId: widget.pm.popId)),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listAts.isNotEmpty
                                      ? popProvider.listPop.first.listAts
                                          .map((e) {
                                          var index = popProvider
                                                  .listPop.first.listAts
                                                  .indexOf(e) +
                                              1;
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AtsPage(
                                                            pm: widget.pm,
                                                            ats: e,
                                                            title: "ATS $index",
                                                          )),
                                                );
                                              },
                                              child: card(
                                                  "ATS $index  -  ${e.merk}"));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),

                    // PDB
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "PDB",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddPdbPage(
                                                  popId: widget.pm.popId)),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listPdb.isNotEmpty
                                      ? popProvider.listPop.first.listPdb
                                          .map((e) {
                                          var index = popProvider
                                                  .listPop.first.listPdb
                                                  .indexOf(e) +
                                              1;
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PDBPage(
                                                            pm: widget.pm,
                                                            pdb: e,
                                                            title: "PDB $index",
                                                          )),
                                                );
                                              },
                                              child: card("PDB $index"));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // Rectifier
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rectifier",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddRectiPage(
                                                      popId: widget.pm.popId)),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listRect.isNotEmpty
                                      ? popProvider.listPop.first.listRect
                                          .map((e) {
                                          var index = popProvider
                                                  .listPop.first.listRect
                                                  .indexOf(e) +
                                              1;
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RectiPage(
                                                            rect: e,
                                                            pm: widget.pm,
                                                            title:
                                                                "Rectifier $index",
                                                          )),
                                                );
                                              },
                                              child: card("Rectifier $index"));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // Modul
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Modul",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddModulPage(
                                                        pop: widget.pm.pop)),
                                          ),
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      popProvider
                                              .listPop.first.listRect.isNotEmpty
                                          ? popProvider.listPop.first.listRect
                                              .map((rect) {
                                              if (rect.listModul.isNotEmpty) {
                                                var index = popProvider
                                                        .listPop.first.listRect
                                                        .indexOf(rect) +
                                                    1;
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          index == 1 ? 8 : 16,
                                                    ),
                                                    Text(
                                                      "Rectifier $index :",
                                                      style: buttonText.copyWith(
                                                          color: textDarkColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Column(
                                                      children: rect.listModul
                                                          .map((e) {
                                                        var index = rect
                                                                .listModul
                                                                .indexOf(e) +
                                                            1;
                                                        return GestureDetector(
                                                            onTap: () {
                                                              imagesProvider
                                                                  .clearList();
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ModulPage(
                                                                              pm: widget.pm,
                                                                              modul: e,
                                                                              title: "Modul $index",
                                                                            )),
                                                              );
                                                            },
                                                            child: card(
                                                                "Modul $index"));
                                                      }).toList(),
                                                    )
                                                  ],
                                                );
                                              } else {
                                                return Text(
                                                  "N/A",
                                                  style: body,
                                                );
                                              }
                                            }).toList()
                                          : [
                                              Text(
                                                "N/A",
                                                style: body,
                                              )
                                            ]),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // Baterai
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Baterai",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddBateraiPage(
                                                      popId: widget.pm.popId)),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: popProvider.listPop.first.listRect
                                            .isNotEmpty &&
                                        popProvider.listPop.first.listRect.first
                                            .listBaterai.isNotEmpty
                                    ? popProvider.listPop.first.listRect.first
                                        .listBaterai
                                        .map((e) {
                                        var index = popProvider.listPop.first
                                                .listRect.first.listBaterai
                                                .indexOf(e) +
                                            1;
                                        return GestureDetector(
                                            onTap: () {
                                              imagesProvider.clearList();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BateraiPage(
                                                          pm: widget.pm,
                                                          bateraiMaster: e,
                                                          title:
                                                              "Baterai $index",
                                                        )),
                                              );
                                            },
                                            child: card("Baterai $index"));
                                      }).toList()
                                    : [
                                        Text(
                                          "N/A",
                                          style: body,
                                        )
                                      ],
                              ),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // Inverter
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Inverter",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddInverterPage(
                                                      popId: widget.pm.popId,
                                                    )));
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listInverter.isNotEmpty
                                      ? popProvider.listPop.first.listInverter
                                          .map((e) {
                                          var index = popProvider
                                                  .listPop.first.listInverter
                                                  .indexOf(e) +
                                              1;
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          InverterPage(
                                                            pm: widget.pm,
                                                            inverter: e,
                                                            title:
                                                                "Inverter $index",
                                                          )),
                                                );
                                              },
                                              child: card(
                                                  "Inverter $index  -  ${e.merk}"));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // Ex Alarm
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Ex Alarm",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddExAlarmPage(
                                                    pm: widget.pm,
                                                    title: "Add Ex Alarm",
                                                  ))),
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listExAlarm.isNotEmpty
                                      ? popProvider.listPop.first.listExAlarm
                                          .map((e) {
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ExAlarmPage(
                                                            exalarm: e,
                                                            pm: widget.pm,
                                                            title: "Ex Alarm",
                                                          )),
                                                );
                                              },
                                              child: card("Ex Alarm"));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // AC
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "AC",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddAcPage(
                                                    popId: widget.pm.popId,
                                                  )),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: popProvider
                                        .listPop.first.listAc.isNotEmpty
                                    ? popProvider.listPop.first.listAc.map((e) {
                                        var index = popProvider
                                                .listPop.first.listAc
                                                .indexOf(e) +
                                            1;
                                        return GestureDetector(
                                            onTap: () async {
                                              imagesProvider.clearList();

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AcPage(
                                                          pm: widget.pm,
                                                          acMaster: e,
                                                          title: "AC $index",
                                                        )),
                                              );
                                            },
                                            child: card(
                                                "AC $index  -  ${e.merk}"));
                                      }).toList()
                                    : [
                                        Text(
                                          "N/A",
                                          style: body,
                                        )
                                      ],
                              ),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // Environment
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Environment",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                    child: const Icon(Icons.add),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddEnvPage(pm: widget.pm)),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider.listPop.first
                                          .listEnvironment.isNotEmpty
                                      ? popProvider
                                          .listPop.first.listEnvironment
                                          .map((e) {
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EnvironmentPage(
                                                            pm: widget.pm,
                                                            environment: e,
                                                            title:
                                                                "Environment",
                                                          )),
                                                );
                                              },
                                              child: card("Environment "));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // Rack
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Rack",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddRackPage(pm: widget.pm)),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listRack.isNotEmpty
                                      ? popProvider.listPop.first.listRack
                                          .map((e) {
                                          var index = popProvider
                                                  .listPop.first.listRack
                                                  .indexOf(e) +
                                              1;
                                          return GestureDetector(
                                              onTap: () {
                                                imagesProvider.clearList();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RackPage(
                                                            pm: widget.pm,
                                                            rack: e,
                                                            title:
                                                                "Rack $index",
                                                          )),
                                                );
                                              },
                                              child: card("Rack $index"));
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    // Mcb
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "MCB",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddMcbPage(
                                                  popId: widget.pm.popId)),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listPdb.isNotEmpty
                                      ? popProvider.listPop.first.listPdb
                                          .map((pdb) {
                                          if (pdb.listMcb.isNotEmpty) {
                                            var index = popProvider
                                                    .listPop.first.listPdb
                                                    .indexOf(pdb) +
                                                1;
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: index == 1 ? 8 : 16,
                                                ),
                                                Text(
                                                  "Pdb $index :",
                                                  style: buttonText.copyWith(
                                                      color: textDarkColor),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Column(
                                                  children:
                                                      pdb.listMcb.map((e) {
                                                    var index =
                                                        pdb.listMcb.indexOf(e) +
                                                            1;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        imagesProvider
                                                            .clearList();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  McbPage(
                                                                      pm: widget
                                                                          .pm,
                                                                      title:
                                                                          "MCB $index",
                                                                      mcb: e)),
                                                        );
                                                      },
                                                      child: card("MCB $index"),
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            );
                                          } else {
                                            return Text(
                                              "N/A",
                                              style: body,
                                            );
                                          }
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),

                    // Perangkat
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4)
                            ],
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Perangkat",
                                    style: buttonText.copyWith(
                                        color: textDarkColor),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddPerangkatPage(
                                                      popId: widget.pm.popId)),
                                        );
                                      },
                                      child: const Icon(Icons.add))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(defaultRadius))),
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: popProvider
                                          .listPop.first.listRack.isNotEmpty
                                      ? popProvider.listPop.first.listRack
                                          .map((rack) {
                                          if (rack.listPerangkat.isNotEmpty) {
                                            var index = popProvider
                                                    .listPop.first.listRack
                                                    .indexOf(rack) +
                                                1;
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: index == 1 ? 8 : 16,
                                                ),
                                                Text(
                                                  "Rack $index :",
                                                  style: buttonText.copyWith(
                                                      color: textDarkColor),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Column(
                                                  children: rack.listPerangkat
                                                      .map((e) {
                                                    var index = rack
                                                            .listPerangkat
                                                            .indexOf(e) +
                                                        1;
                                                    return GestureDetector(
                                                      onTap: () {
                                                        imagesProvider
                                                            .clearList();
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DataPerangkatPage(
                                                                    perangkat:
                                                                        e,
                                                                    pm: widget
                                                                        .pm,
                                                                  )),
                                                        );
                                                      },
                                                      child: card(
                                                          "Perangkat $index"),
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            );
                                          } else {
                                            return Text(
                                              "N/A",
                                              style: body,
                                            );
                                          }
                                        }).toList()
                                      : [
                                          Text(
                                            "N/A",
                                            style: body,
                                          )
                                        ]),
                            ),
                          ],
                        )),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      child: CustomButton(
                          text: "SUBMIT",
                          onPressed: () async {
                            final String? tokenUser =
                                await UserService().getTokenPreference();
                            if (tokenUser == null) {
                            } else {
                              if (await userProvider.getUser(
                                  token: tokenUser)) {
                                await PmService().editPm(
                                    token: tokenUser,
                                    pmId: widget.pm.id,
                                    area: widget.pm.area,
                                    detailPm: widget.pm.detailPm,
                                    userId: widget.pm.userId,
                                    jenis: widget.pm.jenis,
                                    kategori: widget.pm.kategori,
                                    plan: widget.pm.plan,
                                    popId: widget.pm.popId,
                                    realisasi: widget.pm.realisasi,
                                    statusApproval: widget.pm.statusApproval,
                                    wilayah: widget.pm.wilayah,
                                    status: "REALISASI");
                              }
                            }
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                              (route) => false,
                            );
                          },
                          color: primaryGreen,
                          clickColor: clickGreen),
                    )
                  ]));
  }
}
