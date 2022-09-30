import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Archivos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/Nacimiento.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePias.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:intl/intl.dart';

class EditarNacimiento extends StatefulWidget {
  String idUnicoReporte, detalle, file1, file2;
  int id;

  EditarNacimiento(
      {this.idUnicoReporte = '',
      this.detalle = '',
      this.file1 = '',
      this.file2 = '',
      this.id = 0});

  @override
  State<EditarNacimiento> createState() => _AgregarNacimientoState();
}

class _AgregarNacimientoState extends State<EditarNacimiento> {
  Nacimiento nacimiento = Nacimiento();
  TextEditingController controllerDetalle = TextEditingController();

  var _image, _image2;
  String fotonomm1 = 'assets/imgBb1.png';
  String fotonomm2 = 'assets/imgbb2.jpg';
  String lastSelectedValue = "", nombre_2 = "", iamgen_file = "";
  List<Archivos> listArc = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nacimiento.id = widget.id;
    nacimiento.detalle = widget.detalle;
    controllerDetalle.text = widget.detalle;
    //  = widget.file1;
    if (widget.file1 != 'null') {
      _image = File.fromUri(Uri.parse(widget.file1));
    }

    if (widget.file2 != 'null') {
      _image2 = File.fromUri(Uri.parse(widget.file2));
    }
    taerArchivos();
  }

  taerArchivos() async {
    listArc = await DatabasePias.db.listarArchivos(widget.id);
    print("ddsdd");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Util().iconbuton(() => Navigator.of(context).pop()),
        backgroundColor: Colors.indigo,
        title: Text("Agregar Detalle Nacimiento"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  width: 350,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    child: Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (nacimiento.detalle == null) {
                        Util().showAlertDialog(
                            'Nacimientos', 'Ingresar el detalle', context, () {
                          Navigator.pop(context);
                        });
                      } else {
                        nacimiento.idUnicoReporte = widget.idUnicoReporte;
                        //   nacimiento.imagen2 = listArchivo[0].toString();
                        var aed =
                            await DatabasePias.db.updateNacimiento(nacimiento);
                        if (aed > 0) {
                          /*    for (var i = 0; i < listArchivo.length; i++) {

                              ar.file = listArchivo[i].toString();
                              ar.idNacimiento = aed;
                              ar.idUnicoReporte = widget.idUnicoReporte;
                              await DatabasePias.db.insertArchivos(ar);
                            }*/
                          Navigator.pop(context, "nacimiento");
                        }
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Card(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controllerDetalle,
                          textCapitalization: TextCapitalization.sentences,
                          onChanged: (value) {
                            nacimiento.detalle = value;
                          },
                          maxLines: 5, //or null
                          decoration: InputDecoration.collapsed(
                              hintText: "Agregar Detalle"),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 350,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        selectCamera();
                      },
                      child: Text(
                        'Agregar Imagen',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                for (var i in listArc) _tomarImagen(i.file),

                SizedBox(
                  height: 10,
                ),
                // _tomarImagen2(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _tomarImagen(i) {
    var i2 = i;
    i = File.fromUri(Uri.parse(i));
    return Container(
      child: Center(
        child: Stack(
          alignment: Alignment(0.9, 1.1),
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                color: Colors.black87,
                child: GestureDetector(
                  onTap: () async {
                    await DatabasePias.db.eliminarArchivoPorId(i2);
                    await taerArchivos();

                    /// print('delete image from List ${listArchivo.length } $i2');
                    setState(() {
                      print('set new state of images');
                    });
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              width: 300,
              margin: EdgeInsets.only(right: 10.0, top: 30, left: 10.2),
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(100.0),
                // ignore: unnecessary_new
                child: new ClipRRect(
                    //  borderRadius: new BorderRadius.circular(100.0),
                    child: i == null
                        ? new GestureDetector(
                            onTap: () {
                              //  selectCamera();
                            },
                            child: new Container(
                                height: 80.0,
                                width: 80.0,
                                // color: primaryColor,
                                child: new FadeInImage.assetNetwork(
                                    placeholder: fotonomm1,
                                    imageErrorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(fotonomm1);
                                    },
                                    image: '')))
                        : new GestureDetector(
                            onTap: () {
                              //  selectCamera();
                            },
                            child: new Container(
                              height: 80.0,
                              width: 80.0,
                              child: Image.file(
                                i!,
                                fit: BoxFit.cover,
                                height: 800.0,
                                width: 80.0,
                              ),
                            ))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

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

  Future cameraImage() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 700);
    setState(() {
      _image = File(image!.path);
      // nacimiento.imagen1 = image.path;
    });
    List<int> bytes = File(image!.path).readAsBytesSync();
    Archivos ar = Archivos();
    ar.file = image.path;
    ar.idNacimiento = widget.id;
    ar.idUnicoReporte = widget.idUnicoReporte;
    await DatabasePias.db.insertArchivos(ar);
    await taerArchivos();
  }

  Future getImageLibrary() async {
    var gallery = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 700);
    setState(() {
      _image = gallery!.path;
      // nacimiento.imagen1 = _image;
    });
    List<int> bytes = await new File(gallery!.path).readAsBytesSync();
    Archivos ar = Archivos();
    ar.file = _image.toString();
    ar.idNacimiento = widget.id;
    ar.idUnicoReporte = widget.idUnicoReporte;
    await DatabasePias.db.insertArchivos(ar);
    await taerArchivos();
  }
}
