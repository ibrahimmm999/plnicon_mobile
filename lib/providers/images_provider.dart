import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagesProvider extends ChangeNotifier {
  File? _imageFile;
  File? _croppedImageFile;
  String _croppedImagePath = '';
  /*
  ex : {"AC 1": {"path1": "Deskripsi foto"}}
  */
  Map<String, Map<String, String>> listImage = {
    "kwh": {},
    "ac": {},
    "baterai": {},
    "perangkat": {},
    "environment": {},
    "exalarm": {},
    "genset": {},
    "inverter": {},
    "pdb": {},
    "rectifier": {},
  };

  File? get imageFile => _imageFile;
  File? get croppedImageFile => _croppedImageFile;
  String get croppedImagePath => _croppedImagePath;

  set setCroppedImageFile(File? file) {
    _croppedImageFile = file;
    notifyListeners();
  }

  Future<bool> pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      _imageFile = pickedImage != null ? File(pickedImage.path) : null;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cropImage(
      {required File? imageFile, required String key}) async {
    try {
      var cropedImage =
          await ImageCropper().cropImage(sourcePath: imageFile!.path);
      _croppedImagePath = cropedImage != null ? cropedImage.path : '';
      _croppedImageFile = cropedImage != null ? File(cropedImage.path) : null;
      if (cropedImage != null) {
        listImage[key]!
            .addEntries(<String, String>{cropedImage.path: ""}.entries);
      }
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void addDeskripsi(
      {String? deskripsi, required String key, required String path}) {
    listImage[key]?.update(path, (value) => deskripsi ?? "");
    notifyListeners();
  }
}
