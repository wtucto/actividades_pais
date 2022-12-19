import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  /*
   * Encode Image to Base64
   */
  Future<String> imgBase64Encode(XFile file) async {
    File? _imageby;
    _imageby = File(file.path);
    Uint8List bytes = File(_imageby!.path).readAsBytesSync();
    String image64 = base64Encode(bytes);
    return image64;
  }

  /*
   * Decode Base64 to Image 
   */
  Future<File> imgBase64Decode(String b64) async {
    //Image.memory(base64Decode(b64));
    Uint8List decodedBytes = base64Decode(b64);
    var file = File("decodedBase64.png");
    file.writeAsBytesSync(decodedBytes);
    return file;
  }
}
