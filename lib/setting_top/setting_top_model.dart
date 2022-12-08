import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fake_icon_practice/utils.dart';
import 'package:provider/provider.dart';

class SettingTopModel extends ChangeNotifier {
  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    Utils.backgroundImageFile = File(pickedFile!.path);
    notifyListeners();
  }
}
