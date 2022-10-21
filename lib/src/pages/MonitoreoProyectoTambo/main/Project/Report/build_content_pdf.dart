import 'dart:typed_data';

import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/report_dto.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdf(ReportDto oDataPdf) async {
  final pdf = Document();
  final imageLogo = MemoryImage(
    (await rootBundle.load('assets/imagenatencion.png')).buffer.asUint8List(),
  );

  /*pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Reporte"),
                    Text("PAIS"),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(imageLogo),
                )
              ],
            )
          ],
        );
      },
    ),
  ); */
  pdf.addPage(
    MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Reporte"),
                      Text("PAIS"),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image(imageLogo),
                  )
                ],
              ),
              Container(height: 50),
              Table(
                border: TableBorder.all(color: PdfColors.black),
                children: [
                  TableRow(
                    children: [
                      centerText('N°'),
                      centerText('CUI'),
                      centerText('DEPARTAMENTO'),
                      centerText('PROVINCIA'),
                      centerText('DISTRITO'),
                      centerText('CC.PP'),
                      centerText('AVANCE FÍSICO'),
                      centerText('ESTADO'),
                    ],
                  ),
                  ...oDataPdf.items.map(
                    (e) => TableRow(
                      children: [
                        Expanded(
                          child: leftText(e.cui!),
                          flex: 1,
                        ),
                        Expanded(
                          child: leftText(e.cui!),
                          flex: 1,
                        ),
                        Expanded(
                          child: leftText(e.cui!),
                          flex: 1,
                        ),
                        Expanded(
                          child: leftText(e.cui!),
                          flex: 1,
                        ),
                        Expanded(
                          child: leftText(e.cui!),
                          flex: 1,
                        ),
                        Expanded(
                          child: leftText(e.cui!),
                          flex: 1,
                        ),
                        Expanded(
                          child: leftText(e.cui!),
                          flex: 1,
                        ),
                        Expanded(
                          child: leftText(e.cui!),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Reporte generado solo para pruebas.',
                  style: Theme.of(context).header3.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
        ];
      },
    ),
  );
  return pdf.save();
}

Widget leftText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        text,
        textAlign: align,
      ),
    );

Widget centerText(
  final String text, {
  final TextAlign align = TextAlign.center,
}) =>
    Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
