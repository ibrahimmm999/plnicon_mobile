import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';
import 'package:provider/provider.dart';

class InputDokumentasi extends StatefulWidget {
  const InputDokumentasi(
      {super.key,
      required this.controller,
      required this.pageName,
      this.isKwhPage = false});
  final TextEditingController controller;
  final bool isKwhPage;
  final String pageName;

  @override
  State<InputDokumentasi> createState() => _InputDokumentasiState();
}

String contentPath = '';
File? contentFile;
int inputCount = 11;
List<String> inputFoto = [
  "Foto panel keseluruhan",
  "Foto R (ampere)",
  "Foto S (ampere)",
  "Foto T (ampere)",
  "Foto R-N Voltage",
  "Foto S-N Voltage",
  "Foto T-N Voltage",
  "Foto N-G Voltage",
  "Foto R Ampere",
  "Foto S Ampere",
  "Foto T Ampere",
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
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);
    Future<void> handlePicker() async {
      imagesProvider.setCroppedImageFile = null;
      await imagesProvider.pickImage();
      await imagesProvider.cropImage(
          imageFile: imagesProvider.imageFile, key: widget.pageName);
      setState(() {
        if (imagesProvider.croppedImagePath.isNotEmpty) {
          contentPath = imagesProvider.croppedImagePath;
          contentFile = imagesProvider.croppedImageFile;
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
          child: imagesProvider.listImage[widget.pageName]!.entries.isEmpty
              ? Center(
                  child: Text(
                    "Foto",
                    style: buttonText.copyWith(color: textDarkColor),
                  ),
                )
              : ListView(
                  scrollDirection: Axis.horizontal,
                  children: imagesProvider.listImage[widget.pageName]!.entries
                      .map((e) {
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
            if (imagesProvider.croppedImageFile != null) {
              if (inputCount > 0 && widget.pageName == "kwh") {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) => CustomPopUp(
                    title: "Deskripsi",
                    controller: widget.controller,
                    add: () {
                      imagesProvider.addDeskripsi(
                          key: "kwh",
                          path: imagesProvider.croppedImageFile!.path,
                          deskripsi:
                              "${widget.controller.text} ( ${inputFoto[11 - inputCount]} )");
                      widget.controller.clear();
                    },
                  ),
                );
                inputCount -= 1;
                print(inputCount);
              } else {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) => CustomPopUp(
                    title: "Deskripsi",
                    controller: widget.controller,
                    add: () {
                      imagesProvider.addDeskripsi(
                          key: widget.pageName,
                          path: contentPath,
                          deskripsi: widget.controller.text);
                      widget.controller.clear();
                    },
                  ),
                );
              }
            }
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
