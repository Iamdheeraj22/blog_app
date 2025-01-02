import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePick {
  static Future<XFile?> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return XFile(pickedFile.path);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
