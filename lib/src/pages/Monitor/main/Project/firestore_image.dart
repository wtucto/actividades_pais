import 'dart:io';

import 'package:actividades_pais/src/pages/Monitor/main/Project/src/image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class MyStoreImage extends StatefulWidget {
  const MyStoreImage({super.key});

  @override
  State<MyStoreImage> createState() => _MyStoreImageState();
}

class _MyStoreImageState extends State<MyStoreImage> {
  ImageController controller = ImageController();

  String nameInputImage = "imagePartigaEjecutada";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Uplad IMage',
            style: TextStyle(
              color: Color(0xfffefefe),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: const Icon(
                  Icons.monitor,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.selectMultipleImage(nameInputImage);
                    },
                    child: const Text('Seleccionar imagen'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.uploadImage(nameInputImage);
                    },
                    child: const Text('subir imagen'),
                  ),
                ],
              ),
              Obx(
                () {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: controller.selectedFileCount.value,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16),
                      itemBuilder: ((context, index) {
                        return Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              FadeInImage(
                                placeholder:
                                    const AssetImage('assets/loading_icon.gif'),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                image: FileImage(
                                  File(controller.listImagePath[index]),
                                ),
                              ),
                              Positioned(
                                top: -1,
                                right: -1,
                                child: Container(
                                  child: ClipOval(
                                    child: InkWell(
                                      onTap: () {
                                        controller.removeMultipleImage(
                                            controller.listImagePath[index],
                                            nameInputImage);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        color: Color.fromARGB(255, 221, 22, 22),
                                        child: const Icon(Icons.remove_circle,
                                            size: 20,
                                            color: Color.fromARGB(
                                                255, 233, 224, 222)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//https://www.youtube.com/watch?v=8qV7KjWipC0
   // Image.file(
                              //   File(controller.listImagePath[index]),
                              //   width: 100,
                              //   height: 100,
                              //   fit: BoxFit.cover,
                              // )

// Text(
//                                     'Eliminar',
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         fontFamily: 'Regular'),
//                                   ),