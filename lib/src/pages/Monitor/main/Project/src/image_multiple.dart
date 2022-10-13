import 'dart:io';

import 'package:actividades_pais/src/pages/Monitor/main/Project/src/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyImageMultiple extends StatelessWidget {
  const MyImageMultiple({
    Key? key,
    required this.controller,
    required this.nameField,
  }) : super(key: key);

  final ImageController controller;
  final String nameField;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Obx(
            () {
              return Expanded(
                child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    // mainAxisSpacing: 2.0,
                    // crossAxisSpacing: 2.0,
                    children: List.generate(
                      controller.selectedFileCount.value,
                      (index) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: [
                              // FadeInImage(
                              //   placeholder:
                              //       const AssetImage('assets/loading_icon.gif'),
                              //   fit: BoxFit.cover,
                              //   width: double.infinity,
                              //   height: double.infinity,
                              //   image: FileImage(
                              //     File(controller.listImagePath[index]),
                              //   ),
                              // ),
                              Image.file(
                                File(controller.listImagePath[index]),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 1,
                                // top: -1,
                                child: InkWell(
                                  child: const Icon(
                                    Icons.remove_circle,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    controller.removeMultipleImage(
                                        controller.listImagePath[index],
                                        nameField);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}
