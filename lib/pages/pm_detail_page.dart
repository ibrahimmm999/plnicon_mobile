import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/ac_page.dart';
import 'package:plnicon_mobile/pages/genset_page.dart';
import 'package:plnicon_mobile/pages/inverter_page.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
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
        margin: const EdgeInsets.symmetric(vertical: 4),
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
                      child: CircularProgressIndicator(
                          backgroundColor: primaryBlue),
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
                  ]));
  }
}
