import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/input_dokumentasi.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class KWHPage extends StatefulWidget {
  const KWHPage({super.key});

  @override
  State<KWHPage> createState() => _KWHPageState();
}

String contentPath = '';
File? contentFile;

class _KWHPageState extends State<KWHPage> {
  @override
  void initState() {
    super.initState();
    contentPath = '';
    contentFile = null;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController loadR = TextEditingController();
    TextEditingController loadS = TextEditingController();
    TextEditingController loadT = TextEditingController();
    TextEditingController teganganR = TextEditingController();
    TextEditingController teganganS = TextEditingController();
    TextEditingController teganganT = TextEditingController();
    TextEditingController temuanController = TextEditingController();
    TextEditingController rekomendasiController = TextEditingController();
    ImagesProvider imagesProvider = Provider.of<ImagesProvider>(context);

    Future<void> handlePicker() async {
      imagesProvider.setCroppedImageFile = null;
      await imagesProvider.pickImage();
      await imagesProvider.cropImage(imageFile: imagesProvider.imageFile);
      setState(() {
        if (imagesProvider.croppedImagePath.isNotEmpty) {
          contentPath = imagesProvider.croppedImagePath;
          contentFile = imagesProvider.croppedImageFile;
        }
      });
    }

    Widget input() {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: loadR,
                  label: "Load R",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: loadS,
                  label: "Load S",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: loadT,
                  label: "Load T",
                  suffixText: "A",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextInput(
                  controller: teganganR,
                  label: "Tegangan R",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: teganganS,
                  label: "Tegangan S",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextInput(
                  controller: teganganT,
                  label: "Load T",
                  suffixText: "V",
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const InputDokumentasi(),
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
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (route) => false);
                },
                color: primaryBlue,
                clickColor: clickBlue),
          )
        ],
      );
    }

    Widget dokumentasi() {
      return Column(
        children: [
          Container(
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
              children: imagesProvider.listImage
                  .map((e) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image: FileImage(e))),
                        height: 240,
                        width: 240,
                      ))
                  .toList(),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await handlePicker();
              },
              child: Text("Dokumentasi"))
        ],
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "KWH"),
      backgroundColor: Colors.white,
      body: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
          children: [dokumentasi(), input()]),
    );
  }
}
