import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_popup.dart';

class InputDokumentasi extends StatefulWidget {
  const InputDokumentasi(
      {super.key, required this.imagesProvider, required this.controller});
  final ImagesProvider imagesProvider;
  final TextEditingController controller;

  @override
  State<InputDokumentasi> createState() => _InputDokumentasiState();
}

String contentPath = '';
File? contentFile;

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
      await widget.imagesProvider
          .cropImage(imageFile: widget.imagesProvider.imageFile);
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
          height: 280,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: widget.imagesProvider.listImage
                .map((e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: FileImage(
                          e,
                        ),
                        fit: BoxFit.cover,
                      )),
                      height: 240,
                      width: 240,
                    ))
                .toList(),
          ),
        ),
        GestureDetector(
          onTap: () async {
            await handlePicker();
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (context) => CustomPopUp(
                title: "Deskripsi",
                controller: widget.controller,
                add: () async {},
              ),
            );
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
                  "Dokumentasi",
                  style: buttonText,
                ),
                Icon(
                  Icons.arrow_right_outlined,
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
