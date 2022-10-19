import 'package:actividades_pais/src/pages/Monitor/main/Project/report/build_content_pdf.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/report/pdf/util_pdf.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/report/report_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final ReportDto dataPdf;
  const PdfPreviewPage({Key? key, required this.dataPdf}) : super(key: key);

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
        title: const Text('PDF TEST'),
      ),
      body: PdfPreview(
        maxPageWidth: 708,
        //actions: actions,
        onPrinted: showPrintedToast,
        onShared: showSharedToast,
        build: (context) => makePdf(dataPdf),
      ),
    );
  }
}
