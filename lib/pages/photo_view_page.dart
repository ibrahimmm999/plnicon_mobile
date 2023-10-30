import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  final String foto;
  final String description;
  const PhotoViewPage(
      {super.key, required this.foto, required this.description});

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

bool loading = true;

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {});
    loading = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.foto);
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: loading
                  ? CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      height: 280,
                      child: widget.foto.contains("http/")
                          ? PhotoView(
                              imageProvider: NetworkImage(widget.foto),
                            )
                          : PhotoView(
                              imageProvider: FileImage(File(widget.foto)),
                            ),
                    ),
            ),
          ],
        ));
  }
}
