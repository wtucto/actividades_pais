import 'dart:async';
import 'dart:ffi';
import 'dart:isolate';

import 'package:actividades_pais/src/datamodels/Provider/ProviderServicios.dart';
import 'package:geolocator/geolocator.dart';
import 'package:actividades_pais/src/datamodels/Clases/ActividadesTambo.dart';
import 'package:actividades_pais/src/datamodels/Clases/ArchivoTramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Ccpp.dart';
import 'package:actividades_pais/src/datamodels/Clases/CentroPoblado.dart';
import 'package:actividades_pais/src/datamodels/Clases/CierreUsuario.dart';
import 'package:actividades_pais/src/datamodels/Clases/Distritos.dart';
import 'package:actividades_pais/src/datamodels/Clases/Funcionarios.dart';
import 'package:actividades_pais/src/datamodels/Clases/ListarEntidadFuncionario.dart';
import 'package:actividades_pais/src/datamodels/Clases/Paises.dart';
import 'package:actividades_pais/src/datamodels/Clases/PartExtrangeros.dart';
import 'package:actividades_pais/src/datamodels/Clases/ParticipanteEjecucion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Posision.dart';
import 'package:actividades_pais/src/datamodels/Clases/Provincia.dart';
import 'package:actividades_pais/src/datamodels/Clases/Reportehistorial.dart';
import 'package:actividades_pais/src/datamodels/Clases/Tambos/ParticipantesIntervenciones.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumento.dart';
import 'package:actividades_pais/src/datamodels/Clases/TramaIntervencion.dart';
import 'package:actividades_pais/src/datamodels/Clases/UbicacionUsuario.dart';
import 'package:actividades_pais/src/datamodels/database/DatabaseParticipantes.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/util/app-config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:objectbox/objectbox.dart';

class ProviderDatos {
  AppConfig appConfig = AppConfig();
  bool fileExists = false;
  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
    };
  }

  bool _isOnline = false;

  Future<bool> _checkInternetConnection() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      final result = await InternetAddress.lookup('www.google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isOnline = true;
        return _isOnline;
      } else {
        _isOnline = false;
        return _isOnline;
      }
    } on SocketException catch (_) {
      _isOnline = false;
    }
    return _isOnline;
  }

  Future<List<ReporteHistorial>> getLista({String dni = ''}) async {
    http.Response response = await http.post(
        Uri.parse(
            'https://www.pais.gob.pe/backendsismonitor/public/gestionempleado/reportehistorial'),
        headers: headers,
        body: '{"dni":"$dni"}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      final listadostraba = new ReporteHistorials.fromJsonList(jsonResponse);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<String> guardarCierre(CierreUsuario cierreUsuario) async {
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            'backendsismonitor/public/tracking/registroCierreActividad'),
        headers: headers,
        body: '{  "descripcion":"${cierreUsuario.descripcion}",'
            '"dni" :"${cierreUsuario.dni}",'
            '"snip":"${cierreUsuario.snip}",'
            '"latitud":"${cierreUsuario.latitud}",'
            '"longitud":"${cierreUsuario.longitud}",'
            '"fechaHora":"${cierreUsuario.fechaHora}",'
            '"idLugarDeprestacion":"${cierreUsuario.idLugarDeprestacion}",'
            '"idUnidTerritoriales":"${cierreUsuario.idUnidTerritoriales}",'
            '"idUnidadesOrganicas":"${cierreUsuario.idUnidadesOrganicas}",'
            '"idPlataforma":"${cierreUsuario.idPlataforma}",'
            '"imagen" :"${cierreUsuario.imagen}"'
            '}');
    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
    return response.statusCode.toString();
  }

  Future<String> registroUbicacionUsuario(
      UbicacionUsuario ubicacionUsuario) async {
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackendMovil +
            'backendsismonitor/public/tracking/registroUbicacionUsuario'),
        headers: headers,
        body: '{'
            ' "actividad": "${ubicacionUsuario.actividad}",'
            '"dni": "${ubicacionUsuario.dni}",'
            '"idLugarDeprestacion":"${ubicacionUsuario.idLugarDeprestacion}",'
            '"idUnidTerritoriales":"${ubicacionUsuario.idUnidTerritoriales}",'
            '"idUnidadesOrganicas":"${ubicacionUsuario.idUnidadesOrganicas}",'
            '"idPlataforma":"${ubicacionUsuario.idPlataforma}",'
            '"snip":  "${ubicacionUsuario.snip}",'
            '"latitud": "${ubicacionUsuario.latitud}",'
            '"longitud":  "${ubicacionUsuario.longitud}",'
            '"fechaHora":  "${ubicacionUsuario.fechaHora}",'
            '"tipo":  "${ubicacionUsuario.tipo}" }');

    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
    return '';
  }

  Future gettiempo() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil +
            'backendsismonitor/public/tracking/tiempo'),
        headers: headers);

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400) {}
    return 0;
  }

  Future<List<ActividadesTambo>> getactividades() async {
    http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackendMovil +
            'backendsismonitor/public/tracking/actividades'),
        headers: headers);

    if (response.statusCode == 200) {
      final vias =
          new ActividadesTambos.fromJsonList(json.decode(response.body));
      return vias.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future showMyDialog(texto, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta!'),
          content: Text(texto),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Posicion>> verificacionpesmiso() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        //print("'Location permissions are permanently denied");
      } else {
        getLocation();
        //  print("GPS Location service is granted");
      }
    } else {
      var art = await getLocation();

      return art;
      //  print("GPS Location permission granted.");
    }
    return List.empty();
  }

  Future<List<Posicion>> getLocation() async {
    Posicion posicion = Posicion();
    List<Posicion> pst = [];
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    pst = [];
    posicion.latitude = position.latitude;
    posicion.longitude = position.longitude;

    pst.add(posicion);

    return pst;
  }

/*  Future<List<Posicion>> latlong() async{
    Posicion posicion =Posicion();
    List<Posicion> pst = [];
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    // ignore: cancel_subscriptions
   // StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.latitude);
      print(position.longitude);
      posicion.latitude = position.latitude;
      posicion.longitude = position.longitude;

    });

    pst.add(posicion);

    return pst;

  }*/

  Future<List<TramaIntervencion>> getListaTramaIntervencion(snip) async {
    await DatabasePr.db.eliminarTodoEntidadFuncionario();
    await DatabasePr.db.eliminarTodoParticipanteEjecucion();
    await DatabasePr.db.deleteIntervenciones();

    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarTramaIntervencion/$snip'),
    );
    if (response.statusCode == 200) {
      await getlistarCcpp(snip);
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new TramaIntervenciones.fromJsonList(jsonResponse["response"]);

      for (var i = 0; i < listadostraba.items.length; i++) {
        final rspt = TramaIntervencion(
          atencion: listadostraba.items[i].atencion,
          beneficiario: listadostraba.items[i].beneficiario,
          categoria: listadostraba.items[i].categoria,
          codigoInterno: listadostraba.items[i].codigoInterno,
          codigoIntervencion: listadostraba.items[i].codigoIntervencion,
          departamento: listadostraba.items[i].departamento,
          distrito: listadostraba.items[i].distrito,
          estado: listadostraba.items[i].estado,
          fecha: listadostraba.items[i].fecha,
          fechaRegistro: listadostraba.items[i].fechaRegistro,
          descripcionEvento: listadostraba.items[i].descripcionEvento,
          horaFin: listadostraba.items[i].horaFin,
          horaInicio: listadostraba.items[i].horaInicio,
          idDepartamento: listadostraba.items[i].idDepartamento,
          identificacionIntervencion:
              listadostraba.items[i].identificacionIntervencion,
          lugarIntervencion: listadostraba.items[i].lugarIntervencion,
          poblacion: listadostraba.items[i].poblacion,
          programa: listadostraba.items[i].programa,
          provincia: listadostraba.items[i].provincia,
          sector: listadostraba.items[i].sector,
          servicio: listadostraba.items[i].servicio,
          snip: listadostraba.items[i].snip,
          subCategoria: listadostraba.items[i].subCategoria,
          tambo: listadostraba.items[i].tambo,
          tipoActividad: listadostraba.items[i].tipoActividad,
          tipoGobierno: listadostraba.items[i].tipoGobierno,
          tipoIntervencion: listadostraba.items[i].tipoIntervencion,
          idTipoIntervencion: listadostraba.items[i].idTipoIntervencion,
        );
        await DatabasePr.db.insertTramaIntervenciones(rspt);
        await listarEntidadFuncionario(rspt.codigoIntervencion);
      }
      /*consulta por snip idRegion */
      final listardb = DatabasePr.db.listarInterciones(snip);
      return listardb;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<TramaIntervencion>> getListaIntervencion(snip) async {
    /*consulta por snip idRegion */
    final listardb = DatabasePr.db.listarInterciones(snip);
    return listardb;
  }

  Future<List<TipoDocumento>> getTipoDocumento() async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarTramaIntervencion/0s'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListarTipoDocumento.fromJsonList(jsonResponse["response"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<Funcionarios?> getUsuarioDni(dni) async {
    // await TraerToken().mostrarDatos();
    var cnt = await _checkInternetConnection();
    if (cnt == false) {
      return null;
    }

    http.Response responseReniec = await http.get(
      Uri.parse(
          AppConfig.backendsismonitor + '/programaciongit/validar-dni/$dni'),
    );
    if (responseReniec.statusCode == 200) {
      final jsonResponse = json.decode(responseReniec.body);
      final listadostraba = new Funcionarios.fromJsonReniec(jsonResponse);
      return listadostraba;
    } else {
      http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/validarfuncionario/$dni'),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse["total"] == 0) {
          return null;
        } else {
          final listadostraba =
              new Funcionarios.fromJson(jsonResponse["response"][0]);
          return listadostraba;
        }
      } else if (response.statusCode == 400) {
        return null;
      }
    }
    return null;
  }

  Future<Participantes?> getUsuarioParticipanteDni(dni) async {
    var cnt = await _checkInternetConnection();
    if (cnt == false) {
      print("Sin red ");
      var resdb =
         // await DatabaseParticipantes.db.getUsuarioParticipanteDniSQLites(dni);
      await ProviderServicios().getBuscarParticipante(dni);

      if (resdb.length > 0) {
        print("2....");
        return resdb[0];
      } else {
        print("resdb.length:: ${resdb.length}");
        return null;
      }
    } else {
      print("con red ");

      var resdb =
       //   await DatabaseParticipantes.db.getUsuarioParticipanteDniSQLites(dni);
      await ProviderServicios().getBuscarParticipante(dni);
      if (resdb.length > 0) {
        print("3....");
        return resdb[0];
      } else {
        http.Response responseReniec = await http.get(
          Uri.parse(AppConfig.backendsismonitor +
              '/programaciongit/validar-dni/$dni'),
        );
        if (responseReniec.statusCode == 200) {
          print("4....");
          final jsonResponse = json.decode(responseReniec.body);

          final listadostraba = new Participantes.fromJsonReniec(jsonResponse);
          print(listadostraba.apellidoPaterno);
          return listadostraba;
        } else {
          return null;
        }
      }
    }
/*    else if (responseReniec.statusCode != 200) {
      http.Response response = await http.get(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/validarParticipantes/$dni'),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse["total"] == 0) {
          return null;
        } else {
          final listadostraba =
              new Participantes.fromJson(jsonResponse["response"][0]);
          return listadostraba;
        }
      } else if (response.statusCode == 400) {
        return null;
      }
    }*/

    return null;
  }

  // await TraerToken().mostrarDatos();

  /*http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/validarParticipantes/$dni'),
    );
    print(response);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse["total"] == 0) {
        return null;
      } else {
        final listadostraba =
            new Participantes.fromJson(jsonResponse["response"][0]);
        return listadostraba;
      }
    } else if (response.statusCode == 400) {
      return null;
    }*/

  Future<List<ListarCcpp>> getlistarCcpp(snip) async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarCcpp/$snip'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListarCcppes.fromJsonList(jsonResponse["response"]);

      for (var i = 0; i < listadostraba.items.length; i++) {
        final rspt = ListarCcpp(
          nombreCcpp: listadostraba.items[i].nombreCcpp,
          ubigeoCcpp: listadostraba.items[i].ubigeoCcpp,
          snip: listadostraba.items[i].snip,
        );
        await DatabasePr.db.insertlistarCcpp(rspt);
      }

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<Provincia>> getProvincias(snip) async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listaProvinciaporSnp/$snip'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new Provincias.fromJsonList(jsonResponse["response"]);
      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<Distrito>> getDistritos(ubigeo) async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarDistritosporUbigeo/$ubigeo'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new Distritos.fromJsonList(jsonResponse["response"]);
      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<CentroPoblado>> getCentroPoblado(ubigeo) async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarCentroPobladoporUbigeo/$ubigeo'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new CentroPobladoes.fromJsonList(jsonResponse["response"]);
      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future guardarFuncionario(Funcionarios funcionarios) async {}

/*  var cnt =  await _checkInternetConnection();
  print(cnt);
  if(cnt==false){
  return null;
  }*/
  // ignore: non_constant_identifier_names
  Future<List<ListarEntidadFuncionario>> listarEntidadFuncionario(
      idProgramacion) async {
    await DatabasePr.db.eliminarTodoEntidadFuncionario();

    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarEntidadesFuncionarios/$idProgramacion'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListarEntidadFuncionarios.fromJsonList(jsonResponse["response"]);

      for (var i = 0; i < listadostraba.items.length; i++) {
        final rspt = ListarEntidadFuncionario(
          id_accion_programacion: listadostraba.items[i].id_accion_programacion,
          id_entidad: listadostraba.items[i].id_entidad,
          id_tipo_actividad: listadostraba.items[i].id_tipo_actividad,
          nombre_programa: listadostraba.items[i].nombre_programa,
          id_programacion: listadostraba.items[i].id_programacion,
          nombre_tipo_actividad: listadostraba.items[i].nombre_tipo_actividad,
        );

        await DatabasePr.db.insertEntidadFuncionario(rspt);
        await participanteEjecucion(rspt.id_programacion, rspt.id_entidad);
      }

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  // ignore: non_constant_identifier_names
  Future<List<ParticipanteEjecucion>> participanteEjecucion(
      idProgramacion, idEntidad) async {
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/participanteEjecucion/$idProgramacion/$idEntidad'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ParticipanteEjecucions.fromJsonList(jsonResponse["response"]);

      for (var i = 0; i < listadostraba.items.length; i++) {
        final rspt = ParticipanteEjecucion(
            id_programacion: listadostraba.items[i].id_programacion,
            id_entidad: listadostraba.items[i].id_entidad,
            id_servicio: listadostraba.items[i].id_servicio,
            nombre_servicio: listadostraba.items[i].nombre_servicio);
        await DatabasePr.db.insertParticipanteEjecucion(rspt);
      }
      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<ParticipantesIntervenciones>>
      getInsertParticipantesIntervencionesMovil1(UNIDAD_TERRITORIAL) async {
    print("dsadsad");
    await DatabaseParticipantes.db.DeleteAllParticitantesInterv();
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarParticipantesIntervencionesMovil/$UNIDAD_TERRITORIAL'),
    );
    print(response.body);
    if (response.statusCode == 200) {
      //final store = await openStore();
      //final box = store.box<ParticipantesIntervenciones>();

    //  var person = ParticipantesIntervenciones(firstName: 'Joe', lastName: 'Green');



      final jsonResponse = json.decode(response.body);
      final listadostraba = new ListarParticipantesIntervenciones.fromJsonList(
          jsonResponse["response"]);
      for (var i = 0; i < listadostraba.items.length; i++) {
        final rspt = ParticipantesIntervenciones(
          aPELLIDOMATERNO: listadostraba.items[i].aPELLIDOMATERNO,
          aPELLIDOPATERNO: listadostraba.items[i].aPELLIDOPATERNO,
          dNI: listadostraba.items[i].dNI,
          fECHANACIMIENTO: listadostraba.items[i].fECHANACIMIENTO,
          idParticipante: listadostraba.items[i].idParticipante,
          pRIMERNOMBRE: listadostraba.items[i].pRIMERNOMBRE,
          sEGUNDONOMBRE: listadostraba.items[i].sEGUNDONOMBRE,
          sEXO: listadostraba.items[i].sEXO,
          uNIDADTERRITORIAL: listadostraba.items[i].uNIDADTERRITORIAL,
        );
     //   final id = box.put(rspt);  // Create
       await DatabaseParticipantes.db
            .insertParticipantesIntervencionesMovil(rspt);
      }

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  Future<List<ParticipantesIntervenciones>>
  getInsertParticipantesIntervencionesMovil(UNIDAD_TERRITORIAL) async {

    late File jsonFile;
    late Directory dir;
    String fileName = "myJSONFile.json";
    bool fileExists = false;
    late Map<String, String> fileContent;
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
    });


    print("dsadsad");
    await DatabaseParticipantes.db.DeleteAllParticitantesInterv();
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/listarParticipantesIntervencionesMovil/$UNIDAD_TERRITORIAL'),
    );
    if (fileExists) {
      print("File exists");
      Map<String, String> jsonFileContent = json.decode(response.body);

      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(json.
      decode(response.body), dir, fileName);
    }

    if (response.statusCode == 200) {

      final jsonResponse = json.decode(response.body);

      final listadostraba = new ListarParticipantesIntervenciones.fromJsonList(
          jsonResponse["response"]);

      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<List<Paises>> listaPaises() async {
    http.Response response = await http.get(
      Uri.parse(
          AppConfig.urlBackndServicioSeguro + '/api-pnpais/app/listarPaises'),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final listadostraba =
          new ListarPaises.fromJsonList(jsonResponse["response"]);
      return listadostraba.items;
    } else if (response.statusCode == 400) {}
    return List.empty();
  }

  Future<PartExtrangeros?> pintarExtranjerosBD(numDocExtrangero) async {
    var cnt = await _checkInternetConnection();
    if (cnt == false) {
      return null;
    }
    http.Response response = await http.get(
      Uri.parse(AppConfig.urlBackndServicioSeguro +
          '/api-pnpais/app/validarExtranjeros/$numDocExtrangero'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse["codResultado"] == 2) {
        return null;
      } else {
        http.Response response2 = await http.get(
          Uri.parse(AppConfig.urlBackndServicioSeguro +
              '/api-pnpais/app/pintarExtranjerosBD/${jsonResponse["response"][0]["id_participante"]}'),
        );
        final jsonResponse2 = json.decode(response2.body);
        final listadostraba =
            new PartExtrangeros.fromJson(jsonResponse2["response"][0]);
        return listadostraba;
      }
    }
    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
    return null;
  }

  Dio dio = new Dio();

  Future<int> subirArchivos(ArchivoTramaIntervencion funcionarios) async {
    var respuesta = 0;
    try {
      String fileName = funcionarios.file!.split('/').last;
      FormData formdata = new FormData.fromMap({
        'codigoIntervencion': funcionarios.codigoIntervencion,
        'file':
            await MultipartFile.fromFile(funcionarios.file!, filename: fileName)
      });

      await dio
          .post(
              AppConfig.urlBackndServicioSeguro +
                  '/api-pnpais/app/registrarArchivoTramaIntervencion',
              data: formdata)
          .then((value) {
        respuesta = value.statusCode!;
      });
    } catch (e) {}

    return respuesta;
  }

  Future<int> subirFuncionarios(Funcionarios funcionarios) async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    http.Response usuariodb = await http.get(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/consultaIdUsuarioxDni/${abc[0].numeroDni}'),
        headers: headers);

    final jsonResponse = json.decode(usuariodb.body);

    funcionarios.idUsuario = jsonResponse["response"][0]["id_usuario"];

    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/registrarFuncionariosMovil'),
        body: jsonEncode(funcionarios),
        headers: headers);
    if (response.statusCode == 200) {
      return response.statusCode;
    }
    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
    return response.statusCode;
/**/
    return 0;
  }

  Future<int> subirParticipantes(Participantes participantes) async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    http.Response usuariodb = await http.get(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/consultaIdUsuarioxDni/${abc[0].numeroDni}'),
        headers: headers);
    final jsonResponse = json.decode(usuariodb.body);
    participantes.idUsuario = jsonResponse["response"][0]["id_usuario"];
    print(jsonEncode(participantes));
    http.Response response = await http.post(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/registrarParticipanteMovil'),
        body: jsonEncode(participantes),
        headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse2 = json.decode(response.body);

      var resserv =
          await DatabasePr.db.buscarServicioParticipante(participantes.id);
      for (var i = 0; i < resserv.length; i++) {
        print(response.body);
        resserv[i].idProgramacionesParticipante =
            int.parse(jsonResponse2["response"]);
        print(resserv[i].idProgramacionesParticipante);
        http.Response response1 = await http.post(
            Uri.parse(AppConfig.urlBackndServicioSeguro +
                '/api-pnpais/app/registrarParticipanteServicioMovil'),
            body: jsonEncode(resserv[i]),
            headers: headers);
        print("la respouesta es ${response1.body}");
      }
      // return response.statusCode;
    }
    if (response.statusCode == 200) {
    } else if (response.statusCode == 400) {}
    return response.statusCode;
  }

  Future<int> subirCierre(TramaIntervencion participantes) async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    http.Response usuariodb = await http.get(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/consultaIdUsuarioxDni/${abc[0].numeroDni}'),
        headers: headers);
    final jsonResponse = json.decode(usuariodb.body);

    var respuesta = 0;
    try {
      FormData formdata = new FormData.fromMap({
        'idUsuario': jsonResponse["response"][0]["id_usuario"],
        'codigoIntervencion': participantes.codigoIntervencion,
        'descripcion_evento': participantes.descripcionEvento,
        'idTipoIntervencion': participantes.idTipoIntervencion,
      });

      await dio
          .post(
              AppConfig.urlBackndServicioSeguro +
                  '/api-pnpais/app/registrarEjecucionIntervencionMovil',
              data: formdata)
          .then((value) {
        respuesta = value.statusCode!;
      });
    } catch (e) {}

    return respuesta;
  }

  Future subirArchissvsos(
      ArchivoTramaIntervencion archivoTramaIntervencion) async {
    DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    http.Response usuariodb = await http.get(
        Uri.parse(AppConfig.urlBackndServicioSeguro +
            '/api-pnpais/app/consultaIdUsuarioxDni/${abc[0].numeroDni}'),
        headers: headers);

    final jsonResponseusu = json.decode(usuariodb.body);

    var respuesta = 0;
    var request = http.MultipartRequest(
        'POST', Uri.parse(AppConfig.backendsismonitor + '/upload/*'));

    request.fields.addAll({'storage': 'programaciones-git'});
    request.files.add(await http.MultipartFile.fromPath(
        'file', archivoTramaIntervencion.file!));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse;

      await response.stream.bytesToString().then((value) {
        jsonResponse = json.decode(value.toString());
      });

      FormData formdata = new FormData.fromMap({
        'file': jsonResponse["path"],
        'url': jsonResponse["url"],
        'nombreArchivo': jsonResponse["name"],
        'extension': jsonResponse["extension"],
        'codigoIntervencion': archivoTramaIntervencion.codigoIntervencion,
        'idUsuario': jsonResponseusu["response"][0]["id_usuario"],
        // 'id': 0,
        'txtIpmaq': '',
      });
      await dio
          .post(
              AppConfig.urlBackndServicioSeguro +
                  '/api-pnpais/app/registrarArchivoTramaIntervencion',
              data: formdata)
          .then((value) {
        respuesta = value.statusCode!;
      });
    } else {}
    return respuesta;
  }
}
