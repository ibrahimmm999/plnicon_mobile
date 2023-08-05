import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plnicon_mobile/pages/main_page.dart';
import 'package:plnicon_mobile/providers/images_provider.dart';
import 'package:plnicon_mobile/theme/theme.dart';
import 'package:plnicon_mobile/widgets/custom_appbar.dart';
import 'package:plnicon_mobile/widgets/custom_button.dart';
import 'package:plnicon_mobile/widgets/text_input.dart';
import 'package:provider/provider.dart';

class RectiPage extends StatefulWidget {
  const RectiPage({super.key});

  @override
  State<RectiPage> createState() => _RectiPageState();
}

String contentPath = '';
File? contentFile;

class _RectiPageState extends State<RectiPage> {
  @override
  void initState() {
    super.initState();
    contentPath = '';
    contentFile = null;
  }

  @override
  Widget build(BuildContext context) {
    int phasa = 1;
    TextEditingController loadrController = TextEditingController();
    TextEditingController loadsController = TextEditingController();
    TextEditingController loadtController = TextEditingController();
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

    return Scaffold(
      appBar: const CustomAppBar(isMainPage: false, title: "RECTIFIER"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        children: [
          contentFile != null
              ? Image.file(
                  contentFile!,
                  height: 240,
                  width: 240,
                  fit: BoxFit.cover,
                )
              : GestureDetector(
                  onTap: () async {
                    await handlePicker();
                  },
                  child: Container(
                    height: 240,
                    width: 240,
                    color: const Color.fromARGB(255, 223, 223, 223),
                  ),
                ),
          TextInput(
            controller: loadrController,
            label: "Load R",
            placeholder: "Load R",
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: phasa == 3,
            child: TextInput(
              controller: loadsController,
              label: "Load S",
              placeholder: "Load S",
            ),
          ),
          SizedBox(
            height: phasa == 3 ? 20 : 0,
          ),
          Visibility(
            visible: phasa == 3,
            child: TextInput(
              controller: loadtController,
              label: "Load T",
              placeholder: "Load T",
            ),
          ),
          SizedBox(
            height: phasa == 3 ? 20 : 0,
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
      ),
    );
  }
}
