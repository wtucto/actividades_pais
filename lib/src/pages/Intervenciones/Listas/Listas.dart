import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/IncidentesNovedadesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/PartExtrangeros.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Pias/reportesPias.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/actividadesPias.dart';
import 'package:intl/intl.dart';

class Listas {
  BuildContext? get context => null;

  ListTile banTitleFuncionaros(Funcionarios band) {
    return ListTile(
      /*    leading: CircleAvatar(
        child: Text(
          '${band.nombre.substring(0, 1)}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[600],
      ), */
      title: Text('${band.nombres + ' ' + band.apellidoPaterno}',
          style: TextStyle(fontSize: 13)),
      subtitle: new Text('${band.dni}', style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.cargo}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              ' ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.telefono}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () {
        print(band.telefono);
      },
    );
  }

  ListTile banTitleParticipantes(Participantes band) {
    return ListTile(
      /*    leading: CircleAvatar(
        child: Text(
          '${band.nombre.substring(0, 1)}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[600],
      ), */
      title: Text('${band.primerNombre! + ' ' + band.segundoNombre!}',
          style: TextStyle(fontSize: 13)),
      subtitle:
          new Text('${band.fechaNacimiento}', style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.entidad}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              ' ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.dni}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () {
        //  print(band.celular);
      },
    );
  }

  ListTile banTitlePartExtrangeros(PartExtrangeros band) {
    return ListTile(
      /*    leading: CircleAvatar(
        child: Text(
          '${band.nombre.substring(0, 1)}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[600],
      ), */
      title: Text('${band.nombre + ' ' + band.nombre2}',
          style: TextStyle(fontSize: 13)),
      subtitle:
          new Text('${band.fecha_nacimiento}', style: TextStyle(fontSize: 10)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            child: Text(
              ' ${band.entidad}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: 70,
            child: Text(
              ' ',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Text(
            ' ${band.dni}',
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
      onTap: () {
        //  print(band.celular);
      },
    );
  }

  Card miCardLisPartExtrangeros(Participantes band) {
    print(band.pais);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/iconusuario.png',
              height: 35.0,
              width: 35.0,
              fit: BoxFit.contain,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.primerNombre! + ' ' + band.apellidoPaterno!}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text('${band.dni}',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    ' ${band.pais}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                Text(
                  ' ${band.tipoDocumento}',
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
            onTap: () {
              // print(band.celular);
            },
          )
        ],
      ),
    );
  }

  Card miCardLisReportPias(ReportesPias band, onpresses) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
              leading: Image.asset(
                'assets/iconusuario.png',
                height: 35.0,
                width: 35.0,
                fit: BoxFit.contain,
              ),
              contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              title: Text('${band.puntoAtencion}',
                  style: TextStyle(fontSize: 13, color: Colors.black)),
              subtitle: new Text('${band.clima}',
                  style: TextStyle(fontSize: 12, color: Colors.black)),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    child: Text(
                      '${band.fechaParteDiario}',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                  Container(
                    width: 70,
                    child: Text(
                      ' ',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                  Text(
                    ' ${band.plataforma}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
              onTap: onpresses)
        ],
      ),
    );
  }

  DateTime? nowfec = new DateTime.now();
  var formatter = new DateFormat('dd/MM/yyyy');

  Card miCardParticipantes(Participantes band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/iconusuario.png',
              height: 35.0,
              width: 35.0,
              fit: BoxFit.contain,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.primerNombre! + ' ' + band.segundoNombre!+' '+band.apellidoPaterno! +' '+band.apellidoMaterno!}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            // formatter.format(picked),

            subtitle: new Text(
                '${formatter.format(DateTime.parse(band.fechaNacimiento!))}',
                style: TextStyle(fontSize: 10)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      'Edad: ${band.edad}',
                      style: TextStyle(fontSize: 10),
                    ),
                  ]),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  width: 80,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      'Doc: ${band.dni}',
                      style: TextStyle(fontSize: 10),
                    ),
                  ]),
                ),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Card cardFuncionarios(Funcionarios band) {
    var valordocumento = '';
    if (band.dni == '') {
      valordocumento = band.numDocExtranjero;
    } else {
      valordocumento = band.dni;
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/iconusuario.png',
              height: 35.0,
              width: 35.0,
              fit: BoxFit.contain,
            )
            /* Icon(
              
              Icons.person,
              color: Colors.black,
            ) */
            ,
            //new (band.dni == '')? Text('${band.dni}', style: TextStyle(fontSize: 12, color: Colors.black)) : new Container(),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.nombres + ' ' + band.apellidoPaterno}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text('${valordocumento}',
                style: TextStyle(fontSize: 12, color: Colors.black)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    ' ${band.cargo}',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
                Text(
                  ' ${band.telefono}',
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
              ],
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card cardActividadesPias(ActividadesPias band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.document_scanner),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.descripcion}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text(''),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card cardIncidentes(ActividadesPias band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.document_scanner),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.descripcion}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text(''),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card cardIncidentesPias(IncidentesNovedadesPias band) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.document_scanner),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.incidentes}',
                style: TextStyle(fontSize: 13, color: Colors.black)),
            subtitle: new Text(''),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Card cardIntervenciones(TramaIntervencion band, callback) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.text_snippet_sharp,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.tambo} \n ${band.codigoIntervencion}',
                style: TextStyle(fontSize: 13)),
            subtitle: new Text('${band.tipoGobierno}',
                style: TextStyle(fontSize: 10)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    ' ${band.fecha}',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Text(
                  ' ${band.estado}',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            onTap: callback,
          )
        ],
      ),
    );
  }
  Card cardSincronizarPias(ReportesPias band, callback) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.text_snippet_sharp,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${band.puntoAtencion} \n ${band.codigoUbigeo}',
                style: TextStyle(fontSize: 13)),
            subtitle: new Text('${band.plataforma}',
                style: TextStyle(fontSize: 10)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  child: Text(
                    ' ${band.fechaParteDiario}',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                  width: 70,
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Text(
                  ' ${band.clima}',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            onTap: callback,
          )
        ],
      ),
    );
  }
}
