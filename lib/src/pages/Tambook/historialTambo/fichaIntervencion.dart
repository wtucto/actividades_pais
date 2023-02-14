import 'dart:io';

import 'package:actividades_pais/util/app-config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FichaIntervencion extends StatelessWidget {
  int idIntervencion = 0;
  var file = File('');

  FichaIntervencion(this.idIntervencion);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppConfig.primaryColor,
            title: Text("REPORTE DE ACTIVIDADES"),
            actions: [
              InkWell(
                child: Icon(Icons.download),
                onTap: () async {
                  const downloadsFolderPath = '/storage/emulated/0/Download/';
                  Directory dir = Directory(downloadsFolderPath);
                  file = File('${dir.path}/$idIntervencion');
                  var status = await Permission.storage.status;
                  if (status != PermissionStatus.granted) {
                    status = await Permission.storage.request();
                  }
                  if (status.isGranted) {
                    try {
                      await Dio().download(
                          'https://www.pais.gob.pe/backendsismonitor/public/reportesintervenciones/exportar-ficha-pdf?data=$idIntervencion',
                          '/storage/emulated/0/Download/$idIntervencion.pdf',
                          onReceiveProgress: (received, total) {
                        if (total != -1) {
                          print((received / total * 100).toStringAsFixed(0) +
                              "%");
                          //you can build progressbar feature too
                        }
                      });
                      print("File is saved to download folder.");
                    } on DioError catch (e) {
                      print(e.message);
                    }
                  }
                },
              )
            ]),
        /*  try {
                                          await Dio().download(
                                              fileurl,
                                              savePath,
                                              onReceiveProgress: (received, total) {
                                                  if (total != -1) {
                                                      print((received / total * 100).toStringAsFixed(0) + "%");
                                                      //you can build progressbar feature too
                                                  }
                                                });
                                           print("File is saved to download folder.");
                                     } on DioError catch (e) {
                                       print(e.message);
                                     }*/
        body: Center(
            child: PDF(
              preventLinkNavigation: true,
          fitEachPage: true,
           pageSnap: true,
          enableSwipe: true,
          autoSpacing: false,
          pageFling: false,
          swipeHorizontal: true,
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onLinkHandler: (uri) {
            print(uri);
          },
        ).cachedFromUrl(
          'https://www.pais.gob.pe/backendsismonitor/public/reportesintervenciones/exportar-ficha-pdf?data=$idIntervencion',
          maxAgeCacheObject: Duration(days: 30), //duration of cache
          placeholder: (progress) => Center(child: Text('$progress %')),
          errorWidget: (error) => Center(child: Text(error.toString())),
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),),
        )));
  }

  Future<void> saveFile(String fileName) async {
    var file = File('');

    // Platform.isIOS comes from dart:io
    if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$fileName');
    }
    if (Platform.isAndroid) {
      const downloadsFolderPath = '/storage/emulated/0/Download/';
      Directory dir = Directory(downloadsFolderPath);
      file = File('${dir.path}/$fileName');

      /*   var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {

      }*/
    }
  }
}
//  body: const PDF().cachedFromUrl(
//         url,
//         placeholder: (double progress) => Center(child: Text('$progress %')),
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),
//       ),
