import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:plnicon_mobile/theme/theme.dart';

class PhotoViewPage extends StatelessWidget {
  final String foto;
  final String description;
  const PhotoViewPage(
      {super.key, required this.foto, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: primaryBlue,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 280,
                child: PhotoView(
                  imageProvider: FileImage(File(foto)),
                ),
              ),
            ),
            Text(description)
          ],
        ));
  }
}
