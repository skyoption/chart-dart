import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mwidgets/mwidgets.dart';

class PickFile {
  static final picker = ImagePicker();

  static Future<File?> media() async {
    final media = await picker.pickMedia();
    if (media != null) return File(media.path);
    return null;
  }

  static Future<File?> image() async {
    final media = await picker.pickImage(source: ImageSource.gallery);
    if (media != null) return File(media.path);
    return null;
  }

  static Future<File?> video() async {
    final media = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 30),
    );
    if (media != null) return File(media.path);
    return null;
  }

  static Future<File?> pickFile({FileType type = FileType.any}) async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: type,
    );
    if (result != null) {
      kPrint(result.paths[0]!);
      File file = File(result.paths[0]!);
      return file;
    }
    return null;
  }
}
