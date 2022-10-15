import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  Map<String, List> itemsImagesAll = {};

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectMultipleImage(String nameInputImage) async {
    images = await _picker.pickMultiImage();
    listImagePath = [];
    if (images != null) {
      itemsImagesAll.forEach((key, items) {
        if (key == nameInputImage) {
          items.forEach((entry) {
            listImagePath.add(entry);
          });
        }
      });
      for (XFile file in images!) {
        listImagePath.add(file.path);
        itemsImagesAll.addAll({nameInputImage: listImagePath});
      }
    } else {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    itemsImagesAll[nameInputImage] = listImagePath;
  }

  void removeMultipleImage(String index, String nameInputImage) {
    listImagePath = [];
    itemsImagesAll.forEach((key, items) {
      if (key == nameInputImage) {
        items.remove(index);
        items.forEach((entry) {
          listImagePath.add(entry);
        });
      }
    });
    itemsImagesAll[nameInputImage] = listImagePath;
    if (listImagePath.length <= 0) {
      Get.snackbar('Error', 'No Existe Imagenes',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // void uploadImage(String nameInputImage) {
  //   if (selectedFileCount.value > 0) {
  //     Get.dialog(
  //         const Center(
  //           child: CircularProgressIndicator(),
  //         ),
  //         barrierDismissible: false);

  //     ImageUploadProvider()
  //         .uploadImage(listImagePath, itemsImagesAll)
  //         .then((resp) {
  //       Get.back();
  //       if (resp == "success") {
  //         Get.snackbar('Error', 'Imagen Enviado Correctamente',
  //             snackPosition: SnackPosition.BOTTOM,
  //             backgroundColor: Colors.green,
  //             colorText: Colors.white);
  //         images = [];
  //         listImagePath = [];
  //         itemsImagesAll = {};
  //         selectedFileCount.value = listImagePath.length;
  //       }
  //     }).onError((error, stackTrace) {
  //       Get.back();
  //       Get.snackbar('Error', 'Error en subir la imagen',
  //           snackPosition: SnackPosition.BOTTOM,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     });
  //   } else {
  //     Get.snackbar('Error', 'Imagen no selecionada',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white);
  //   }
  // }
}
