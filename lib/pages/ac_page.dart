import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plnicon_mobile/models/master/ac_master_model.dart';
import 'package:plnicon_mobile/models/nilai/ac_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/services/transaksional/ac_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class ACPage extends StatefulWidget {
  const ACPage({
    super.key,
    required this.acMaster,
    required this.pm,
    required this.title,
  });
  final AcMasterModel acMaster;
  final PmModel pm;
  final String title;

  @override
  State<ACPage> createState() => _ACPageState();
}

String pengujian = "";
int suhu = 0;
String temuan = '';
String rekomendasi = '';

class _ACPageState extends State<ACPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  getinit() async {
    if (await TransaksionalProvider().getAc(widget.pm.id, widget.acMaster.id)) {
      suhu = TransaksionalProvider().currentAc.suhuAc;
      pengujian = TransaksionalProvider().currentAc.hasilPengujian;
      temuan = TransaksionalProvider().currentAc.temuan;
      rekomendasi = TransaksionalProvider().currentAc.rekomendasi;
    }
  }

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider transaksionalProvider =
        Provider.of<TransaksionalProvider>(context);
    TextEditingController suhuController =
        TextEditingController(text: suhu.toString());

    TextEditingController temuanController =
        TextEditingController(text: temuan);

    TextEditingController rekomendasiController =
        TextEditingController(text: rekomendasi);
    TextEditingController deskripsiController = TextEditingController(text: "");
    List<String> listHasilPengujian = ["Ok", "B aja", "Buruk"];
    PageProvider pageProvider = Provider.of<PageProvider>(context);
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

    Widget buildContent() {
      int newPage = pageProvider.pmPage;
      switch (newPage) {
        case 0:
          {
            return Scaffold(
              body: ListView(
                padding: EdgeInsets.all(defaultMargin),
                children: [
                  Text(
                    "Nama : ${widget.acMaster.nama}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kondisi : ${widget.acMaster.kondisi}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Merk : ${widget.acMaster.merk}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kapasitas : ${widget.acMaster.kapasitas}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tekanan Freon : ${widget.acMaster.tekananFreon}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Mode Hidup : ${widget.acMaster.modeHidup}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tanggal Instalasi : -",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }
        case 1:
          {
            return Scaffold(
                body: ListView(
              padding: EdgeInsets.all(defaultMargin),
              children: [
                InputDokumentasi(
                    controller: deskripsiController, pageName: "ac"),
                const SizedBox(
                  height: 20,
                ),
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
                  value: pengujian.isEmpty ? null : pengujian,
                  onChanged: (value) {
                    setState(() {
                      pengujian = value.toString();
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
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
                      onPressed: () async {
                        await AcService().postAc(
                            acId: widget.acMaster.id,
                            pmId: 1,
                            suhuAc: int.parse(suhuController.text),
                            hasilPengujian: pengujian,
                            temuan: temuanController.text,
                            rekomendasi: rekomendasiController.text);
                        Navigator.pop(context);
                      },
                      color: primaryBlue,
                      clickColor: clickBlue),
                )
              ],
            ));
          }
        default:
          {
            return Scaffold();
          }
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          leading: GestureDetector(
              onTap: () {
                TransaksionalProvider().setAc(AcNilaiModel(
                    id: 0,
                    acId: widget.acMaster.id,
                    pmId: widget.pm.id,
                    suhuAc: int.parse(suhuController.text),
                    hasilPengujian: pengujian,
                    temuan: temuanController.text,
                    rekomendasi: rekomendasiController.text,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now()));
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          title: Center(
            child: Container(
              margin: const EdgeInsets.only(right: 60),
              child: Text(
                widget.title,
                style: header2.copyWith(color: textLightColor),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            switchContent(),
            Expanded(child: buildContent()),
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
          pageProvider.setPmPage = index;
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
                      pageProvider.pmPage == index ? primaryBlue : neutral500,
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
