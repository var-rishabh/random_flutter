import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImageProvider extends ChangeNotifier {
  File? _image;

  File? get image => _image;

  void captureImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedImage == null) {
      return;
    }
    _image = File(pickedImage.path);
    notifyListeners();
  }

  void removeImage() {
    _image = null;
    notifyListeners();
  }
}