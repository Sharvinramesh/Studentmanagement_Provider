import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPageProvider extends ChangeNotifier {
  String? profileImgPath;
  XFile? image;

  void setImage(XFile? img) {
    image = img;
    profileImgPath = img?.path;
    notifyListeners();
  }

  void clearImage() {
    image = null;
    profileImgPath = null;
    notifyListeners();
  }
}