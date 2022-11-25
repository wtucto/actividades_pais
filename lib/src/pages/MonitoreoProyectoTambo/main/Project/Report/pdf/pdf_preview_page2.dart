import 'dart:io';

import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/util_pdf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage2 extends StatelessWidget {
  final Uint8List dataPdf;
  const PdfPreviewPage2({Key? key, required this.dataPdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(
          icon: Icon(Icons.save),
          onPressed: saveAsFile,
        )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MANUAL DE USUARIO'),
      ),
      body: PdfPreview(
        maxPageWidth: 708,
        //actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: (context) => (dataPdf),
      ),
    );
  }
}
