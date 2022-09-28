import 'dart:convert';
import 'dart:io';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:actividades_pais/src/datamodels/Clases/ArchivoTramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/PartExtrangeros.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Provider/Provider.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Extrangeros/Extranjeros.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Extrangeros/ListaExtrangeros.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Funcionarios/Funcionarios.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Funcionarios/listaFuncionarios.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Intervenciones.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Participantes/Participantes.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Participantes/ListaParticipantes.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';

// ignore: must_be_immutable
class EjecucionProgramacionPage extends StatefulWidget {
  int idProgramacion;
  String descripcionEvento;
  int snip;
  String programa;
  TramaIntervencion tramaIntervencion;

  EjecucionProgramacionPage(
      {this.idProgramacion = 0,
      this.descripcionEvento = '',
      this.snip = 0,
      this.programa = '',
      required this.tramaIntervencion});

  @override
  State<EjecucionProgramacionPage> createState() =>
      _EjecucionProgramacionPageState();
}

class _EjecucionProgramacionPageState extends State<EjecucionProgramacionPage> {
  ProviderDatos provider = ProviderDatos();
  int currenIndex = 0;
  Listas listas = Listas();
  File? _imageby;
  String image64 = '';
  Util util = Util();
  var _image, _image2, _image3;
  ArchivoTramaIntervencion archivoTramaIntervencion =
      ArchivoTramaIntervencion();
  String fotonomm = 'assets/imagenatencion.png';
  String lastSelectedValue = "", nombre_2 = "", iamgen_file = "";

  @override
  void initState() {
    super.initState();
    cargarFotos();
  }


  cargarFotos() async {

   var rws= await DatabasePr.db.listarImagenesDB(widget.idProgramacion);
  if(rws.length==1){
    _image = File.fromUri(Uri.parse(rws[0].file.toString()));
  }else if(rws.length==2){
    _image = File.fromUri(Uri.parse(rws[0].file.toString()));
    _image2 = File.fromUri(Uri.parse(rws[1].file.toString()));
  } else if(rws.length==3){
    _image = File.fromUri(Uri.parse(rws[0].file.toString()));
    _image2 = File.fromUri(Uri.parse(rws[1].file.toString()));
    _image3 = File.fromUri(Uri.parse(rws[2].file.toString()));
  }

 setState(() {});
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  // ignore: non_constant_identifier_names
  Future<Null> listaFuniconario() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      DatabasePr.db.listarFuncionarios(widget.idProgramacion);
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
    await DatabasePr.db.listarFuncionarios(widget.idProgramacion);

    await DatabasePr.db.listarPartExtrangeros(widget.idProgramacion);
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: (Colors.red[600]!)),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  @override
  Widget build(BuildContext context) {

    List listPages = [
      Container(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          body: Container(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    miCard('Programa: ${widget.tramaIntervencion.programa}'
                        "\n"
                        "\n"
                        'Hora Inicio: ${widget.tramaIntervencion.horaInicio} - '
                        'Hora Fin: ${widget.tramaIntervencion.horaFin}'
                        '\n'
                        '${widget.tramaIntervencion.tipoIntervencion}'),
                    SizedBox(
                      height: 0,
                    ),
                    miCard(widget.descripcionEvento),
                    SizedBox(
                      height: 3,
                    ),
                    Text("Adjuntar Imagenes"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        _tomarImagen(),
                        _tomarImagen2()
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        _tomarImagen3()
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ListaFuncionariosVw(widget.tramaIntervencion),
      ListaParticipantesVw(widget.idProgramacion, widget.snip),
      ListaExtrangeros(widget.idProgramacion)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("Ejecucion Programacion \n${widget.idProgramacion}", style: TextStyle(fontSize: 17),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          InkWell(
            child: Icon(Icons.save),
            onTap: () {
              Util().showAlertDialogokno('Ejecucion Programacion', context,
                  () async {
                DatabasePr.db
                    .insertTramaIntervencionesUs(widget.tramaIntervencion);
                /*  await
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) => Intervenciones(    int.parse(
                    widget.tramaIntervencion.snip!))));*/
                /* await  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>  Intervenciones(    int.parse(
                widget.tramaIntervencion.snip!))));*/
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => Intervenciones(
                          int.parse(widget.tramaIntervencion.snip!), '') ),
                );
              }, () {
                Navigator.pop(context);
              }, '¿Estas seguro de guardar los datos para sincronizarlos?');
            },
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: listPages[currenIndex],
      bottomNavigationBar: BottomNavyBar(
        //   items: items,
        selectedIndex: currenIndex,

        onItemSelected: (index) {
          setState(() {
            currenIndex = index;
          });
        },

        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text("Inicio"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.engineering),
              title: Text("Funcionarios"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.people_alt),
              title: Text("Participantes"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.person_sharp),
              title: Text("Extranjeros"),
              activeColor: (Colors.blue[800])!,
              inactiveColor: Colors.black),
        ],
      ),
    );
  }

  _tomarImagen() {
    return Center(
      child: Stack(
        alignment: Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.only(right: 10.0, left: 10.2),
            child: Material(
              elevation: 4.0,
              //    borderRadius: BorderRadius.circular(100.0),
              // ignore: unnecessary_new
              child: new ClipRRect(
                  //     borderRadius: new BorderRadius.circular(100.0),
                  child: _image == null
                      ? new GestureDetector(
                          onTap: () {
                            selectCamera();
                          },
                          child: new Container(
                              height: 80.0,
                              width: 80.0,
                              // color: primaryColor,
                              child: new FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image: '')))
                      : new GestureDetector(
                          onTap: () {
                            selectCamera();
                          },
                          child: new Container(
                            height: 80.0,
                            width: 80.0,
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              height: 800.0,
                              width: 80.0,
                            ),
                          ))),
            ),
          ),
        ],
      ),
    );
  }

  _tomarImagen2() {
    return Center(
      child: Stack(
        alignment: Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.only(right: 10.0, left: 10.2),
            child: Material(
              elevation: 4.0,
              //    borderRadius: BorderRadius.circular(100.0),
              // ignore: unnecessary_new
              child: new ClipRRect(
                  //     borderRadius: new BorderRadius.circular(100.0),
                  child: _image2 == null
                      ? new GestureDetector(
                          onTap: () {
                            selectCamera2();
                          },
                          child: new Container(
                              height: 80.0,
                              width: 80.0,
                              // color: primaryColor,
                              child: new FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image: '')))
                      : new GestureDetector(
                          onTap: () {
                            selectCamera2();
                          },
                          child: new Container(
                            height: 80.0,
                            width: 80.0,
                            child: Image.file(
                              _image2!,
                              fit: BoxFit.cover,
                              height: 800.0,
                              width: 80.0,
                            ),
                          ))),
            ),
          ),
        ],
      ),
    );
  }

  _tomarImagen3() {
    return Center(
      child: Stack(
        alignment: Alignment(0.9, 1.1),
        children: <Widget>[
          Container(
            height: 150,
            width: 150,
            margin: EdgeInsets.only(right: 10.0, left: 10.2),
            child: Material(
              elevation: 4.0,
              //    borderRadius: BorderRadius.circular(100.0),
              // ignore: unnecessary_new
              child: new ClipRRect(
                  //     borderRadius: new BorderRadius.circular(100.0),
                  child: _image3 == null
                      ? new GestureDetector(
                          onTap: () {
                            selectCamera3();
                          },
                          child: new Container(
                              height: 80.0,
                              width: 80.0,
                              // color: primaryColor,
                              child: new FadeInImage.assetNetwork(
                                  placeholder: fotonomm,
                                  imageErrorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(fotonomm);
                                  },
                                  image: '')))
                      : new GestureDetector(
                          onTap: () {
                            selectCamera3();
                          },
                          child: new Container(
                            height: 80.0,
                            width: 80.0,
                            child: Image.file(
                              _image3!,
                              fit: BoxFit.cover,
                              height: 800.0,
                              width: 80.0,
                            ),
                          ))),
            ),
          ),
        ],
      ),
    );
  }

  // Widget get _tomarImagen {}

  selectCamera() {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Seleccionar Camara'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Camara'),
              onPressed: () {
                Navigator.pop(context, 'Camara');
                cameraImage();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Galeria'),
              onPressed: () {
                Navigator.pop(context, 'Galeria');
                getImageLibrary();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancelar'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
          )),
    );
  }

  selectCamera2() {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Seleccionar Camara'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Camara'),
              onPressed: () {
                Navigator.pop(context, 'Camara');
                cameraImage2();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Galeria'),
              onPressed: () {
                Navigator.pop(context, 'Galeria');
                getImageLibrary2();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancelar'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
          )),
    );
  }

  selectCamera3() {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
          title: const Text('Seleccionar Camara'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('Camara'),
              onPressed: () {
                Navigator.pop(context, 'Camara');
                cameraImage3();
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Galeria'),
              onPressed: () {
                Navigator.pop(context, 'Galeria');
                getImageLibrary3();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancelar'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
          )),
    );
  }

  void showDemoActionSheet({BuildContext? context, Widget? child}) {
    showCupertinoModalPopup<String>(
      context: context!,
      builder: (BuildContext context) => child!,
    ).then((String? value) {
      if (value != null) {
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  Future getImageLibrary() async {
    var gallery =
        await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      _image = gallery;
    });
    List<int> bytes = await new File(gallery!.path).readAsBytesSync();

    ///image64 = base64Encode(bytes);
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = gallery.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 1;
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 1);
    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Future cameraImage() async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      _image = File(image!.path);
    });
    List<int> bytes = File(image!.path).readAsBytesSync();
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 1);
    print('aquii $image64');
    //image64 = base64Encode(bytes);
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = image.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 1;

    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
    print(image64);
  }

  Future getImageLibrary2() async {
    var gallery =
        await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      // _imageby = File(gallery.path);
      _image2 = gallery;
    });
    List<int> bytes = await new File(gallery!.path).readAsBytesSync();
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 2);

    /// image64 = base64Encode(bytes);
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = gallery.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 2;

    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Future cameraImage2() async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      ///  _imageby = File(image.path);
      _image2 = File(image!.path);
    });
    List<int> bytes = File(image!.path).readAsBytesSync();

    //image64 = base64Encode(bytes);
    archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = image.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 2;
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 2);
    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  ///
  Future getImageLibrary3() async {
    var gallery =
        await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      _image3 = gallery;
    });
    List<int> bytes = await new File(gallery!.path).readAsBytesSync();
     archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = gallery.path.toString();
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 3;
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 3);
    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Future cameraImage3() async {
    final image =
        await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
       _image3 = File(image!.path);
    });
    List<int> bytes = File(image!.path).readAsBytesSync();
     archivoTramaIntervencion.codigoIntervencion =
        widget.tramaIntervencion.codigoIntervencion;
    archivoTramaIntervencion.file = image.path;
    archivoTramaIntervencion.fileEncode = base64Encode(bytes);
    archivoTramaIntervencion.nmero = 3;
    await DatabasePr.db.deleteArchivoIntervenciones(
        widget.tramaIntervencion.codigoIntervencion, 3);
    await DatabasePr.db
        .insertArchivoTramaIntervencion(archivoTramaIntervencion);
  }

  Card miCard(texto) {
    return Card(
      // Con esta propiedad modificamos la forma de nuestro card
      // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      // Con esta propiedad agregamos margen a nuestro Card
      // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
      margin: EdgeInsets.all(15),

      // Con esta propiedad agregamos elevación a nuestro card
      // La sombra que tiene el Card aumentará
      elevation: 10,

      // La propiedad child anida un widget en su interior
      // Usamos columna para ordenar un ListTile y una fila con botones
      child: Column(
        children: <Widget>[
          // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            // title: Text('Titulo'),
            subtitle: Text(texto),
          ),
          SizedBox(
            height: 5,
          )
          // Usamos una fila para ordenar los botones del card
          /* Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(onPressed: () => {}, child: Text('Aceptar')),
              FlatButton(onPressed: () => {}, child: Text('Cancelar'))
            ],
          ) */
        ],
      ),
    );
  }
}
