import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickProvider extends ChangeNotifier {
  File? pickedImageFile;

  void pickImage() async {
    final pickedImageCam = await ImagePicker()
        .pickImage(source: ImageSource.camera, 
        imageQuality: 50, 
        maxWidth: 150);

    if(pickedImageCam == null){
      return;
    }

    pickedImageFile = File(pickedImageCam.path);
    notifyListeners();
  }
}
