import 'dart:io';

import 'package:actividades_pais/src/pages/Monitor/main/Project/src/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyImageMultiple extends StatefulWidget {
  MyImageMultiple({
    Key? key,
    required this.controller,
    required this.nameField,
  }) : super(key: key);

  final ImageController controller;
  final String nameField;

  @override
  _MyImageMultipleState createState() => _MyImageMultipleState();
}

class _MyImageMultipleState extends State<MyImageMultiple> {
  @override
  Widget build(BuildContext context) {
    List<String> itemsImagePath = [];
    var selectedItemCount = 0.obs;
    widget.controller.itemsImagesAll.forEach((key, items) {
      if (key == widget.nameField) {
        items.forEach((entry) {
          itemsImagePath.add(entry);
        });
      }
    });
    return ListView(
      shrinkWrap: true,
      children: [
        Obx(() {
          selectedItemCount.value = itemsImagePath.length;
          return GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            // mainAxisSpacing: 2.0,
            // crossAxisSpacing: 2.0,
            children: List.generate(
              selectedItemCount.value,
              (index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      FadeInImage(
                        placeholder:
                            const AssetImage('assets/loading_icon.gif'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        image: FileImage(
                          File(itemsImagePath[index]),
                        ),
                      ),
                      /*Image.file(
                        File(itemsImagePath[index]),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),*/
                      Positioned(
                        right: 1,
                        // top: -1,
                        child: InkWell(
                          child: const Icon(
                            Icons.remove_circle,
                            size: 35,
                            color: Colors.red,
                          ),
                          onTap: () async {
                            await widget.controller.removeMultipleImage(
                              itemsImagePath[index],
                              widget.nameField,
                            );
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        })
      ],
    );
  }
}
