import 'package:actividades_pais/src/pages/Monitor/main/Project/report/build_report_pdf.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/report/report_dto.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final ReportDto dataPdf;
  const PdfPreviewPage({Key? key, required this.dataPdf}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vista previa en PDF'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(dataPdf),
      ),
    );
  }
}
