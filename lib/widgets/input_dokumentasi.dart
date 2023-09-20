import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';

class InputDokumentasi extends StatefulWidget {
  const InputDokumentasi(
      {super.key,
      required this.controller,
      required this.pageName,
      required this.imagesProvider,
      this.isKwhPage = false});
  final TextEditingController controller;
  final bool isKwhPage;
  final String pageName;
  final ImagesProvider imagesProvider;

  @override
  State<InputDokumentasi> createState() => _InputDokumentasiState();
}

String contentPath = '';
File? contentFile;
int inputCount = 11;
List<String> inputFoto = [
  "Foto Fisik KWH",
  "Foto Pembersihan KWH",
  "Foto Beban Phasa R",
  "Foto Beban Phasa S",
  "Foto Beban Phasa T",
  "Foto Tegangan R-N",
  "Foto Tegangan S-N ",
  "Foto Tegangan T-N ",
  "Foto Tegangan N-G ",
  "Foto Tegangan R-S ",
  "Foto Tegangan R-T ",
  "Foto Tegangan S-T ",
];

class _InputDokumentasiState extends State<InputDokumentasi> {
  @override
  void initState() {
    super.initState();
    contentPath = '';
    contentFile = null;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> handlePicker() async {
      widget.imagesProvider.setCroppedImageFile = null;
      await widget.imagesProvider.pickImage();
      await widget.imagesProvider.cropImage(
          imageFile: widget.imagesProvider.imageFile, key: widget.pageName);
      setState(() {
        if (widget.imagesProvider.croppedImagePath.isNotEmpty) {
          contentPath = widget.imagesProvider.croppedImagePath;
          contentFile = widget.imagesProvider.croppedImageFile;
        }
      });
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultRadius),
              border: Border.all(
                width: 2,
                color: neutral500,
              )),
          height: 360,
          width: double.infinity,
          child: widget.imagesProvider.foto.isEmpty
              ? Center(
                  child: Text(
                    "Foto",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget.imagesProvider.foto.entries.map((e) {
                    return Container(
                      width: 240,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Image.file(
                            File(e.key),
                            height: 240,
                            width: 240,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            e.value,
                            style: buttonText.copyWith(color: textDarkColor),
                            overflow: TextOverflow.clip,
                          )
                        ],
                      ),
                    );
                  }).toList()),
        ),
        GestureDetector(
          onTap: () async {
            await handlePicker();
            if (widget.imagesProvider.croppedImageFile != null) {
              if (inputCount > 0 && widget.pageName == "kwh") {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) => CustomPopUp(
                    title: "Deskripsi",
                    controller: widget.controller,
                    add: () {
                      widget.imagesProvider.addDeskripsi(
                          path: widget.imagesProvider.croppedImageFile!.path,
                          deskripsi:
                              "${widget.controller.text} ( ${inputFoto[11 - inputCount - 1]} )");
                      widget.controller.clear();
                    },
                  ),
                );
              } else {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) => CustomPopUp(
                    title: "Deskripsi",
                    controller: widget.controller,
                    add: () {
                      widget.imagesProvider.addDeskripsi(
                          // key: widget.pageName,
                          path: contentPath,
                          deskripsi: widget.controller.text);
                      widget.controller.clear();
                    },
                  ),
                );
              }
            }
            inputCount -= 1;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(defaultRadius)),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  !(widget.isKwhPage)
                      ? "Tambah Foto"
                      : inputCount > 0
                          ? inputFoto[11 - inputCount]
                          : "Tambah Foto",
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
      ],
    );
  }
}
