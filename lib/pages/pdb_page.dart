// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:plnicon_mobile/models/foto_model.dart';
import 'package:plnicon_mobile/models/master/pdb_master_model.dart';
import 'package:plnicon_mobile/models/nilai/pdb_nilai_model.dart';
import 'package:plnicon_mobile/models/pm_model.dart';
import 'package:plnicon_mobile/pages/edit_master/edit_pdb_page.dart';
import 'package:plnicon_mobile/pages/pm_detail_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/providers/page_provider.dart';
import 'package:plnicon_mobile/providers/transaksional_provider.dart';
import 'package:plnicon_mobile/providers/user_provider.dart';
import 'package:plnicon_mobile/services/master/pdb_master_service.dart';
import 'package:plnicon_mobile/services/transaksional/pdb_service.dart';
import 'package:plnicon_mobile/services/user_service.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/custom_button_loading.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class PDBPage extends StatefulWidget {
  const PDBPage({
    super.key,
    required this.pdb,
    required this.title,
    required this.pm,
  });
  final PdbMasterModel pdb;
  final String title;
  final PmModel pm;

  @override
  State<PDBPage> createState() => _PDBPageState();
}

class _PDBPageState extends State<PDBPage> {
  @override
  void initState() {
    getinit();
    super.initState();
  }

  String fotoPdbTertutup = "";
  String fotoPdbTerbuka = "";
  String aresterWarna = "";
  bool loading = true;
  getinit() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    TransaksionalProvider pdbProvider =
        Provider.of<TransaksionalProvider>(context, listen: false);
    ImagesProvider imagesProvider =
        Provider.of<ImagesProvider>(context, listen: false);

    final String? token = await UserService().getTokenPreference();

    if (token == null) {
    } else {
      if (await userProvider.getUser(token: token)) {
        await pdbProvider.getPdb(widget.pm.id, widget.pdb.id);
        aresterWarna = pdbProvider.listPdb.isEmpty
            ? ""
            : pdbProvider.listPdb.first.aresterWarna;

        if (pdbProvider.listPdb.isNotEmpty) {
          for (var element in pdbProvider.listPdb.first.foto!) {
            String url = element.url.replaceAll("http://localhost",
                "https://jakban.iconpln.co.id/backend-plnicon/public");

            if (element.deskripsi == "Foto PDB Tertutup") {
              fotoPdbTertutup = url;
            } else if (element.deskripsi == "Foto PDB Terbuka") {
              fotoPdbTerbuka = url;
            }
            imagesProvider.foto[url] = element.deskripsi;
          }
        }
      }
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    TransaksionalProvider pdbProvider =
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
    TextEditingController temuanController = TextEditingController(
        text:
            pdbProvider.listPdb.isEmpty ? "" : pdbProvider.listPdb.last.temuan);
    TextEditingController rekomendasiController = TextEditingController(
        text: pdbProvider.listPdb.isEmpty
            ? ""
            : pdbProvider.listPdb.last.rekomendasi);

    List<String> listAresterWarna = ["Ok", "Not OK"];
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
                    "Nama : ${widget.pdb.nama}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Arester : ${widget.pdb.arester}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Arester Tipe : ${widget.pdb.aresterTipe}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tipe : ${widget.pdb.tipe}",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Tanggal Instalasi : ${widget.pdb.tanggalInstalasi}",
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
                                builder: (context) => EditPdbPage(
                                      pm: widget.pm,
                                      pdb: widget.pdb,
                                      title: "Edit PDB",
                                    )));
                      },
                      color: primaryGreen,
                      clickColor: clickGreen),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Delete",
                      onPressed: () async {
                        await PdbMasterService()
                            .deletePdbMaster(id: widget.pdb.id);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    PmDetailPage(pm: widget.pm))),
                            (route) => false);
                      },
                      color: primaryRed,
                      clickColor: clickRed),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                              style: buttonText.copyWith(color: textDarkColor),
                            ),
                          )
                        : ListView(
                            scrollDirection: Axis.horizontal,
                            children: imagesProvider.foto.entries.map((e) {
                              return Container(
                                width: 240,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
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
                                                  if (e.value ==
                                                      "Foto PDB Tertutup") {
                                                    fotoPdbTertutup = "";
                                                  } else if (e.value ==
                                                      "Foto PDB Terbuka") {
                                                    fotoPdbTerbuka = "";
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
                    "Foto PDB Terbuka",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoPdbTerbuka.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto PDB Terbuka");
                              fotoPdbTerbuka = contentPath;
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
                              onTap: fotoPdbTerbuka.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Foto PDB Terbuka");
                                        fotoPdbTerbuka = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoPdbTerbuka.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoPdbTerbuka)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(fotoPdbTerbuka))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoPdbTerbuka.isEmpty
                                    ? "Tambah Foto"
                                    : fotoPdbTerbuka,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: fotoPdbTerbuka.isEmpty,
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
                    "Foto PDB Tertutup",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                  GestureDetector(
                    onTap: fotoPdbTertutup.isEmpty
                        ? () async {
                            await handlePicker();
                            if (imagesProvider.croppedImageFile != null) {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: "Foto PDB Tertutup");
                              fotoPdbTertutup = contentPath;
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
                              onTap: fotoPdbTertutup.isEmpty
                                  ? () async {
                                      await handlePicker();
                                      if (imagesProvider.croppedImageFile !=
                                          null) {
                                        imagesProvider.addDeskripsi(
                                            path: contentPath,
                                            deskripsi: "Foto PDB Tertutup");
                                        fotoPdbTertutup = contentPath;
                                        deskripsiController.clear();
                                      }
                                    }
                                  : () {
                                      fotoPdbTertutup.contains(
                                              "https://jakban.iconpln.co.id")
                                          ? showImageViewer(
                                              context,
                                              Image.network(fotoPdbTertutup)
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true)
                                          : showImageViewer(
                                              context,
                                              Image.file(File(fotoPdbTertutup))
                                                  .image,
                                              swipeDismissible: true,
                                              doubleTapZoomable: true);
                                    },
                              child: Text(
                                fotoPdbTertutup.isEmpty
                                    ? "Tambah Foto"
                                    : fotoPdbTertutup,
                                style: buttonText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: fotoPdbTertutup.isNotEmpty
                                ? () {
                                    setState(() {
                                      imagesProvider.deleteImage(
                                          path: fotoPdbTertutup);
                                      fotoPdbTertutup = "";
                                    });
                                  }
                                : () async {
                                    await handlePicker();
                                    if (imagesProvider.croppedImageFile !=
                                        null) {
                                      imagesProvider.addDeskripsi(
                                          path: contentPath,
                                          deskripsi: "Foto PDB Tertutup");
                                      fotoPdbTertutup = contentPath;
                                      deskripsiController.clear();
                                    }
                                  },
                            child: Visibility(
                              visible: fotoPdbTertutup.isEmpty,
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
                        showDialog(
                          context: context,
                          builder: (context) => CustomPopUp(
                            title: "Deskripsi",
                            controller: deskripsiController,
                            add: () {
                              imagesProvider.addDeskripsi(
                                  path: contentPath,
                                  deskripsi: deskripsiController.text);
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
                  Text(
                    "Arester Warna",
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
                    items: listAresterWarna
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                              ),
                            ))
                        .toList(),
                    value: aresterWarna.isEmpty ? null : aresterWarna,
                    onChanged: (value) {
                      aresterWarna = value.toString();
                    },
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
                    child: isLoading
                        ? CustomButtonLoading(color: primaryGreen)
                        : CustomButton(
                            text: "Save",
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (pdbProvider.listPdb.isEmpty) {
                                if (aresterWarna.isNotEmpty &&
                                    fotoPdbTerbuka.isNotEmpty &&
                                    fotoPdbTertutup.isNotEmpty) {
                                  PdbNilaiModel pdb = await PdbService()
                                      .postPdb(
                                          pdbId: widget.pdb.id,
                                          pmId: widget.pm.id,
                                          aresterWarna: aresterWarna,
                                          temuan: temuanController.text,
                                          rekomendasi:
                                              rekomendasiController.text);
                                  await Future.forEach(
                                      imagesProvider.foto.entries,
                                      (element) async {
                                    await PdbService().postFotoPdb(
                                        pdbNilaiId: pdb.id,
                                        urlFoto: element.key,
                                        description: element.value);
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PmDetailPage(pm: widget.pm)),
                                      (route) => false);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: primaryRed,
                                      content: const Text(
                                        'Isi foto dengan lengkap',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                if (aresterWarna.isNotEmpty &&
                                    fotoPdbTerbuka.isNotEmpty &&
                                    fotoPdbTertutup.isNotEmpty) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  PdbNilaiModel pdb = await PdbService()
                                      .editPdb(
                                          foto: [
                                        const FotoModel(
                                            id: 99,
                                            url: "url",
                                            deskripsi: "deskripsi")
                                      ],
                                          id: pdbProvider.listPdb.last.id,
                                          pdbId: widget.pdb.id,
                                          pmId: widget.pm.id,
                                          aresterWarna: aresterWarna,
                                          temuan: temuanController.text,
                                          rekomendasi:
                                              rekomendasiController.text);
                                  if (pdbProvider.listPdb.isNotEmpty) {
                                    for (var item
                                        in pdbProvider.listPdb.last.foto!) {
                                      bool isDelete = true;
                                      for (var itemImagesProvider
                                          in imagesProvider.foto.entries) {
                                        String url = item.url.replaceAll(
                                            "http://localhost",
                                            "https://jakban.iconpln.co.id/backend-plnicon/public");
                                        if (url == itemImagesProvider.key) {
                                          isDelete = false;
                                        }
                                      }
                                      if (isDelete) {
                                        await PdbService()
                                            .deleteImage(imageId: item.id);
                                      }
                                    }
                                  }
                                  await Future.forEach(
                                      imagesProvider.foto.entries,
                                      (element) async {
                                    if (!(element.key.contains(
                                        "https://jakban.iconpln.co.id"))) {
                                      await PdbService().postFotoPdb(
                                          pdbNilaiId: pdb.id,
                                          urlFoto: element.key,
                                          description: element.value);
                                    }
                                  });
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PmDetailPage(pm: widget.pm)),
                                      (route) => false);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: primaryRed,
                                      content: const Text(
                                        'Isi foto dengan lengkap',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            color: primaryGreen,
                            clickColor: clickGreen),
                  )
                ],
              ),
            );
          }
        default:
          {
            return const Scaffold();
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
