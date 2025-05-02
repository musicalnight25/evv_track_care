// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'common_toast.dart';
import 'devlog.dart';

class ImageUtils {
  ImageUtils._();

  static Future<Uint8List> getImageData(String url) async {
    Uri uri = Uri.parse(url);

    final response = await http.get(uri);

    devlog("IMAGE_DATA_DOWNLOADED_FOR : $url");
    return response.bodyBytes;
  }

  static Future<String?> pickImage({required ImageSource source}) async {
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 80, maxWidth: 800, maxHeight: 800);
      if (image == null) return null;
      final imagePath = image.path;
      return imagePath;
    } catch (e) {
      devlogError("error in category image upload");
      showSnackbar("Trouble to pick image..try again later.!");
      return null;
    }
  }
}
