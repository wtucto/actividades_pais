import 'package:actividades_pais/src/datamodels/Clases/Uti/ListaEquipoInformatico.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderSeguimientoParqueInformatico.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

//import 'dart:js' as js;
import 'package:http/http.dart' as http;

class DetalleEquipo extends StatefulWidget {
  ListaEquipoInformatico listaEquipoInformatico;

  DetalleEquipo(this.listaEquipoInformatico);

  @override
  State<DetalleEquipo> createState() => _DetalleEquipoState();
}

class _DetalleEquipoState extends State<DetalleEquipo> {
  bool _loaded = false;
  var img = Image.network(
      'https://www.pais.gob.pe/backendsismonitor/public/storage/null');
  var placeholder = AssetImage('assets/paislogo.png');
  var respuetaImgen = '0';
  Dio dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargaImagen();
  }

  cargaImagen() async {
    respuetaImgen = await ProviderSeguimientoParqueInformatico()
        .consultaEquipo(widget.listaEquipoInformatico.idEquipoInformatico);

    setState(() {});
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 20, top: 10),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if (respuetaImgen != '0') ...[
                  Image.network(
                      'https://www.pais.gob.pe/backendsismonitor/public/storage/' +
                          respuetaImgen)
                ],
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "ESTADO :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 102),
                    Text("ACTIVO")
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "CODIGO PATRIMONIAL :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text("${widget.listaEquipoInformatico.codigoPatrimonial}")
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "FECHA DE INGRESO :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 28),
                    Text("21${widget.listaEquipoInformatico.fecIngreso}")
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "MARCA :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 105),
                    Text("${widget.listaEquipoInformatico.descripcionMarca}")
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "COLOR :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 110),
                    Text("${widget.listaEquipoInformatico.color}")
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "DENOMINACION :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 50),
                    Container(
                        width: 170,
                        child: Text(
                          "${widget.listaEquipoInformatico.descripcionEquipoInformatico}",
                        ))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "TIPO EQUIPO :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 70),
                    Container(
                        width: 170,
                        child: Text(
                          "${widget.listaEquipoInformatico.descripcionTipoEquipoInformatico}",
                        ))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "MODELO :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 97),
                    Container(
                        width: 170,
                        child: Text(
                          "${widget.listaEquipoInformatico.descripcionModelo}",
                        ))
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "NRO SERIE :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 83),
                    Container(
                        width: 170,
                        child: Text(
                          "${widget.listaEquipoInformatico.serie}",
                        ))
                  ],
                ),
                SizedBox(height: 15),
              /*  Container(
                    decoration: Servicios().myBoxDecoration(),
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[600],
                      ),
                      onPressed: () async {
                        print(AppConfig.backendsismonitor +
                            '/seguimientoequipo/exportarExcelFichaTecnica?id_equipo=${widget.listaEquipoInformatico.idEquipoInformatico}');
                        var response = await dio.download(
                            AppConfig.backendsismonitor +
                                '/seguimientoequipo/exportarExcelFichaTecnica?id_equipo=${widget.listaEquipoInformatico.idEquipoInformatico}',
                            'path-to-save-to');

                        //     http.get(Uri.parse(AppConfig.backendsismonitor+'seguimientoequipo/exportarExcelFichaTecnica?id_equipo=${widget.listaEquipoInformatico.idEquipoInformatico}'));
                        //.open(AppConfig.backendsismonitor+'seguimientoequipo/exportarExcelFichaTecnica?id_equipo=${widget.listaEquipoInformatico.idEquipoInformatico}', 'PlaceholderName');

                        //                        js.context.callMethod('open', [AppConfig.backendsismonitor+'seguimientoequipo/exportarExcelFichaTecnica?id_equipo=${widget.listaEquipoInformatico.idEquipoInformatico}']);

                        //    html.window.open('https://stackoverflow.com/questions/ask', 'new tab');

                        setState(() {
                          // isLoading = true;
                        });
                        // await traerPaguinado(10, 1);
                        //   Navigator.of(context).pop();

                        setState(() {
                          //isLoading = false;
                        });
                      },
                      child: const Text("DESCARGAR FICHA TECNICA"),
                    ))*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
