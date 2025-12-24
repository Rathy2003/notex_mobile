import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class Helper{
  static Future<File?> pickProfileImage() async {
    var imageFile;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any, // or FileType.image, FileType.video, etc.
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      
      // print('File name: ${file.name}');
      // print('File size: ${file.size}');
      // print('File path: ${file.path}');
      // print('File extension: ${file.extension}');
      
      imageFile = File(file.path!);
      return imageFile;
    } else {
      // User canceled the picker
    }
    return imageFile;
  }
}