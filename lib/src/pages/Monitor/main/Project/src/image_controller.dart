import 'package:actividades_pais/src/pages/Monitor/main/Project/src/image_upload_Provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  var selectedFileCount = 0.obs;

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

  void selectMultipleImage() async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images!) {
        listImagePath.add(file.path);
      }
    } else {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }

    selectedFileCount.value = listImagePath.length;
  }

  void removeMultipleImage(String index) {
    if (selectedFileCount.value > 0) {
      listImagePath.remove(index);
      selectedFileCount.value = listImagePath.length;
    } else {
      Get.snackbar('Error', 'No Existe Imagenes',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void uploadImage() {
    if (selectedFileCount.value > 0) {
      Get.dialog(
          const Center(
            child: CircularProgressIndicator(),
          ),
          barrierDismissible: false);

      ImageUploadProvider().uploadImage(listImagePath).then((resp) {
        Get.back();
        if (resp == "success") {
          Get.snackbar('Error', 'Image Uploaded',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          images = [];
          listImagePath = [];
          selectedFileCount.value = listImagePath.length;
        }
      }).onError((error, stackTrace) {
        Get.back();
        Get.snackbar('Error', 'Error en subir la imagen',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      });
    } else {
      Get.snackbar('Error', 'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
