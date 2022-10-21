import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/pdf/pdf_preview_page.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/Report/report_dto.dart';
import 'package:flutter/material.dart';

class ReportProjectPage extends StatelessWidget {
  final ReportDto dataPdf;
  const ReportProjectPage({
    Key? key,
    required this.dataPdf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dataPdf.name),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _createDataTable(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfPreviewPage(dataPdf: dataPdf),
            ),
          );
          // rootBundle.
        },
        child: Icon(Icons.picture_as_pdf),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Text(
          'N°',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'CUI',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'DEPARTAMENTO',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'PROVINCIA',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'DISTRITO',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'CC.PP',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'AVANCE FÍSICO',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'ESTADO',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  List<DataRow> _createRows() {
    return dataPdf.items
        .map(
          (o) => DataRow(
            cells: [
              DataCell(Text('1')),
              DataCell(Text('cui')),
              DataCell(Text('dep')),
              DataCell(Text('prov')),
              DataCell(Text('dist')),
              DataCell(Text('ccpp')),
              DataCell(Text('avan')),
              DataCell(Text('estado')),
            ],
          ),
        )
        .toList();
  }
}
