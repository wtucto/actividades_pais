import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  Future<String> imgBase64Encode(XFile file) async {
    File? _imageby;
    _imageby = File(file.path);
    Uint8List bytes = File(_imageby!.path).readAsBytesSync();
    String image64 = base64Encode(bytes);
    return image64;
  }
}
