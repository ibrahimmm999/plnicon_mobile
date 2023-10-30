import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/master/exalarm_master_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_exalarm_page.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/master/exalarm_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class ExAlarmPage extends StatefulWidget {
  const ExAlarmPage(
      {super.key,
      required this.exalarm,
      required this.title,
      required this.pm});
  final ExAlarmMasterModel exalarm;
  final String title;
  final PmModel pm;

  @override
  State<ExAlarmPage> createState() => _ExAlarmPageState();
}

class _ExAlarmPageState extends State<ExAlarmPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  String fotoRackEa = "";
  String fotoEa = "";
  bool loading = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider exAlarmProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await exAlarmProvider.getExalarm(widget.pm.id, widget.exalarm.id);

        if (exAlarmProvider.listExalarm.isNotEmpty) {
          for (var element in exAlarmProvider.listExalarm.first.foto!) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");

            if (element.deskripsi == "RACK EA") {
              fotoRackEa = url;
            } else if (element.deskripsi == "FOTO EA") {
              fotoEa = url;
            }
            imagesProvider.foto[url] = element.deskripsi;
          }
        }
      }
    }
    loading = false;
    print(exAlarmProvider.listExalarm);
  }

  @override
  Widget build(BuildContext context) {
    TransaksionalProvider exAlarmProvider =
        Provider.of<TransaksionalProvider>(context);
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    Future<void> handlePicker() async {
      imagesProvider.setCroppedImageFile = null;
      await imagesProvider.pickImage();
      await imagesProvider.cropImage(
          imageFile: imagesProvider.imageFile, key: "");
      setState(() {
        if (imagesProvider.croppedImagePath.isNotEmpty) {
          contentPath = imagesProvider.croppedImagePath;
          contentFile = imagesProvider.croppedImageFile;
        }
      });
    }

    TextEditingController deskripsiController = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
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
                    "EA : ${widget.exalarm.ea}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Genset Run Fail : ${widget.exalarm.gensetRunFail}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pintu : ${widget.exalarm.pintu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Smoke And Fire : ${widget.exalarm.smokeAndFire}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Suhu : ${widget.exalarm.suhu}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pln Off : ${widget.exalarm.plnOff}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Perangkat Ea : ${widget.exalarm.perangkatEa}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Edit",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditExAlarmPage(
                                    pm: widget.pm,
                                    exalarm: widget.exalarm,
                                    title: "Edit Inverter")));
                      },
                      color: primaryGreen,
                      clickColor: clickGreen),
                ],
              ),
            );
          }
        case 1:
          {
            return Scaffold(
              body: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultMargin, vertical: 20),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(defaultRadius),
                          border: Border.all(
                            width: 2,
                            color: neutral500,
                          )),
                      height: 360,
                      width: double.infinity,
                      child: imagesProvider.foto.isEmpty
                          ? Center(
                              child: Text(
                                "Foto",
                                style:
                                    buttonText.copyWith(color: textDarkColor),
                              ),
                            )
                          : ListView(
                              scrollDirection: Axis.horizontal,
                              children: imagesProvider.foto.entries.map((e) {
                                return Container(
                                  width: 240,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          e.key.contains(
                                                  "https://jakban.iconpln.co.id")
                                              ? showImageViewer(context,
                                                  Image.network(e.key).image,
                                                  swipeDismissible: true,
                                                  doubleTapZoomable: true)
                                              : showImageViewer(context,
                                                  Image.file(File(e.key)).image,
                                                  swipeDismissible: true,
                                                  doubleTapZoomable: true);
                                        },
                                        child: Stack(
                                          children: [
                                            e.key.contains(
                                                    "https://jakban.iconpln.co.id")
                                                ? Image.network(
                                                    e.key,
                                                    height: 240,
                                                    width: 240,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.file(
                                                    File(e.key),
                                                    height: 240,
                                                    width: 240,
                                                    fit: BoxFit.cover,
                                                  ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    imagesProvider.deleteImage(
                                                        path: e.key);
                                                    if (e.value == "RACK EA") {
                                                      fotoRackEa = "";
                                                    } else if (e.value ==
                                                        "FOTO EA") {
                                                      fotoEa = "";
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 255, 73, 60),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            180),
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 24,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        e.value,
                                        style: buttonText.copyWith(
                                            color: textDarkColor),
                                        overflow: TextOverflow.clip,
                                      )
                                    ],
                                  ),
                                );
                              }).toList()),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      "Foto RACK EA",
                      style: buttonText.copyWith(color: textDarkColor),
                    ),
                    GestureDetector(
                      onTap: fotoRackEa.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath, deskripsi: "RACK EA");
                                // imagesProvider.foto[contentPath] =
                                //     imagesProvider.foto;
                                fotoRackEa = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        margin: const EdgeInsets.only(bottom: 20, top: 4),
                        decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: fotoRackEa.isEmpty
                                    ? () async {
                                        await handlePicker();
                                        if (imagesProvider.croppedImageFile !=
                                            null) {
                                          imagesProvider.addDeskripsi(
                                              path: contentPath,
                                              deskripsi: "RACK EA");
                                          // imagesProvider.listFoto[contentPath] =
                                          //     imagesProvider.foto;
                                          fotoRackEa = contentPath;
                                          print(imagesProvider.foto);
                                          deskripsiController.clear();
                                        }
                                      }
                                    : () {
                                        fotoRackEa.contains(
                                                "https://jakban.iconpln.co.id")
                                            ? showImageViewer(context,
                                                Image.network(fotoRackEa).image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true)
                                            : showImageViewer(
                                                context,
                                                Image.file(File(fotoRackEa))
                                                    .image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true);
                                      },
                                child: Text(
                                  fotoRackEa.isEmpty
                                      ? "Tambah Foto"
                                      : fotoRackEa,
                                  style: buttonText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: fotoRackEa.isEmpty,
                              child: Icon(
                                Icons.photo_camera_outlined,
                                color: textLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Foto EA",
                      style: buttonText.copyWith(color: textDarkColor),
                    ),
                    GestureDetector(
                      onTap: fotoEa.isEmpty
                          ? () async {
                              await handlePicker();
                              if (imagesProvider.croppedImageFile != null) {
                                imagesProvider.addDeskripsi(
                                    path: contentPath, deskripsi: "FOTO EA");
                                // imagesProvider.listFoto[contentPath] =
                                //     imagesProvider.foto;
                                fotoEa = contentPath;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              }
                            }
                          : () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        margin: const EdgeInsets.only(bottom: 20, top: 4),
                        decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: fotoEa.isEmpty
                                    ? () async {
                                        await handlePicker();
                                        if (imagesProvider.croppedImageFile !=
                                            null) {
                                          imagesProvider.addDeskripsi(
                                              path: contentPath,
                                              deskripsi: "FOTO EA");
                                          // imagesProvider.listFoto[contentPath] =
                                          //     imagesProvider.foto;
                                          fotoEa = contentPath;
                                          print(imagesProvider.foto);
                                          deskripsiController.clear();
                                        }
                                      }
                                    : () {
                                        fotoEa.contains(
                                                "https://jakban.iconpln.co.id")
                                            ? showImageViewer(context,
                                                Image.network(fotoEa).image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true)
                                            : showImageViewer(context,
                                                Image.file(File(fotoEa)).image,
                                                swipeDismissible: true,
                                                doubleTapZoomable: true);
                                      },
                                child: Text(
                                  fotoEa.isEmpty ? "Tambah Foto" : fotoEa,
                                  style: buttonText,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: fotoEa.isNotEmpty
                                  ? () {
                                      setState(() {
                                        imagesProvider.deleteImage(
                                            path: fotoEa);
                                        fotoEa = "";
                                      });
                                    }
                                  : () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "FOTO EA");
                                        // imagesProvider.listFoto[contentPath] =
                                        //     imagesProvider.foto;
                                        fotoEa = contentPath;
                                        print(imagesProvider.foto);
                                        deskripsiController.clear();
                                      }
                                    },
                              child: Visibility(
                                visible: fotoEa.isEmpty,
                                child: Icon(
                                  Icons.photo_camera_outlined,
                                  color: textLightColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Foto Tambahan",
                      style: buttonText.copyWith(color: textDarkColor),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await handlePicker();
                        if (imagesProvider.croppedImageFile != null) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) => CustomPopUp(
                              title: "Deskripsi",
                              controller: deskripsiController,
                              add: () {
                                imagesProvider.addDeskripsi(
                                    path: contentPath,
                                    deskripsi: deskripsiController.text);
                                // imagesProvider.listFoto[contentPath] =
                                //     imagesProvider.foto;
                                print(imagesProvider.foto);
                                deskripsiController.clear();
                              },
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        margin: const EdgeInsets.only(bottom: 20, top: 4),
                        decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(defaultRadius)),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tambah Foto",
                              style: buttonText,
                            ),
                            Icon(
                              Icons.photo_camera_outlined,
                              color: textLightColor,
                            )
                          ],
                        ),
                      ),
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
                            imagesProvider.foto.forEach((key, value) async {
                              await ExAlarmService().postFotoexalarm(
                                  exalarmNilaiId: widget.exalarm.id,
                                  urlFoto: key,
                                  description: value);
                            });
                            Navigator.pop(context);
                          },
                          color: primaryBlue,
                          clickColor: clickBlue),
                    )
                  ]),
            );
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
          mainAxisAlignment:
              loading ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: loading
              ? [
                  Center(
                      child: CircularProgressIndicator(
                          backgroundColor: primaryBlue))
                ]
              : [
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
