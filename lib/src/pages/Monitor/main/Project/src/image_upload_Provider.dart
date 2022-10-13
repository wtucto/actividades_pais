import 'dart:io';

import 'package:get/get_connect/connect.dart';

class ImageUploadProvider extends GetConnect {
  Future<String> uploadImage(List<String> list, var itemsImagesAll) async {
    try {
      final form = FormData({});
      print(itemsImagesAll); // aqui todas las imagenes del formulario
      for (String path in list) {
        form.files.add(MapEntry(
            "file[]",
            MultipartFile(File(path),
                filename:
                    "${DateTime.now().millisecondsSinceEpoch}.${path.split('.').last}")));
      }
      final response = await post("", form);
      if (response.status.hasError) {
        return Future.error(response.body);
      } else {
        return response.body['result'];
      }
    } catch (exeption) {
      return Future.error(exeption.toString());
    }
  }
}
