import 'dart:convert';

import 'package:actividades_pais/src/datamodels/Clases/NumeroTelefono.dart';
import 'package:actividades_pais/src/datamodels/Clases/Participantes.dart';
import 'package:actividades_pais/src/datamodels/Clases/Provincia.dart';
import 'package:actividades_pais/src/datamodels/Clases/Sexo.dart';
import 'package:actividades_pais/src/datamodels/Clases/TipoDocumento.dart';
import 'package:actividades_pais/src/datamodels/Clases/Unidad.dart';
import 'package:actividades_pais/src/datamodels/Clases/tipoPlataforma.dart';
import 'package:actividades_pais/src/datamodels/Servicios/Servicios.dart';
import 'package:actividades_pais/src/datamodels/Clases/LugarPrestacion.dart';
import 'package:actividades_pais/src/datamodels/Clases/Puesto.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesOrganicas.dart';
import 'package:actividades_pais/src/datamodels/Clases/UnidadesTerritoriales.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';

class ProviderServicios {
  Servicios servicios = new Servicios();

  Future requestSqlData() async {
    await serv();
  }

  serv() async {
    await DatabasePr.db.initDB();
    await DatabasePr.db.deleteTabla();
    await getSaveTipoPlataforma();
    await getUnidadesTerr();
    // await getUnidadesTablaPlataforma();
    await getLugarPrestacion();
    await getPuesto();
    await getUnidadesOrg();
    await getNumeroTelefono();
    await getProvincias();
    await getTipoDocumento();
    await getSexo();
  }

  Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
    };
  }

  Future<List<UnidadesOrganicas>> getUnidadesOrg() async {
    String jsonString = await servicios.loadunidadesOrganicas();
    final jsonResponse = json.decode(jsonString);

    final listadoDepart =
        new ListarUnidadesOrganicas.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = UnidadesOrganicas(
          IDUO: listadoDepart.items[i].IDUO,
          UNIDAD_ORGANICA: listadoDepart.items[i].UNIDAD_ORGANICA);
      DatabasePr.db.insertUnidadesOrganicas(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<UnidadesTerritoriales>> getUnidadesTerr() async {
    String jsonString = await servicios.loadunidadesTerritoriales();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart =
        new ListarUnidadesTerritoriales.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = UnidadesTerritoriales(
          id_UnidadesTerritoriales:
              listadoDepart.items[i].id_UnidadesTerritoriales,
          unidadTerritorial: listadoDepart.items[i].unidadTerritorial);
      DatabasePr.db.insertUnidadesTerritoriales(rspt);
    }
    return listadoDepart.items;
  }

/*  Future<List<UnidadesTablaPlataforma>> getUnidadesTablaPlataforma() async {
    String jsonString = await servicios.loadUnidadesTablaPlataforma();

    final jsonResponse = json.decode(jsonString);
    final listadoDepart =
        new ListarUnidadesTablaPlataforma.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = UnidadesTablaPlataforma(
        ALTITUD: listadoDepart.items[i].ALTITUD,
        CCPP: listadoDepart.items[i].CCPP,
        DEPARTAMENTO: listadoDepart.items[i].DEPARTAMENTO,
        DISTRITO: listadoDepart.items[i].DISTRITO,
        ID_UNIDAD_TERRITORIAL: listadoDepart.items[i].ID_UNIDAD_TERRITORIAL,
        LATITUD: listadoDepart.items[i].LATITUD,
        LONGITUD: listadoDepart.items[i].LONGITUD,
        PROVINCIA: listadoDepart.items[i].PROVINCIA,
        SNIP: listadoDepart.items[i].SNIP,
        TAMBO: listadoDepart.items[i].TAMBO,
        UBIGEO_CCPP: listadoDepart.items[i].UBIGEO_CCPP,
        UBIGEO_TAMBO: listadoDepart.items[i].UBIGEO_TAMBO,
      );
      DatabasePr.db.insertUnidadesTablaPlataforma(rspt);
    }
    return listadoDepart.items;
  }*/

  Future<List<LugarPrestacion>> getLugarPrestacion() async {
    String jsonString = await servicios.loadunidadesLugarPrestacion();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = new ListarLugarPrestacion.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = LugarPrestacion(
        idLugarPrestacion: listadoDepart.items[i].idLugarPrestacion,
        nombreLugarPrestacion: listadoDepart.items[i].nombreLugarPrestacion,
      );
      DatabasePr.db.insertLugarPrestacion(rspt);
      //DatLugarPrestacion.db.insert(rspt);
    }
    return listadoDepart.items;
  }

  //loadPuesto

  Future<List<Puesto>> getPuesto() async {
    String jsonString = await servicios.loadPuesto();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = new ListarPuesto.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Puesto(
        idPuesto: listadoDepart.items[i].idPuesto,
        nombrePuesto: listadoDepart.items[i].nombrePuesto,
      );
      DatabasePr.db.insertPuesto(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<NumerosTelef>> getNumeroTelefono() async {
    String jsonString = await servicios.loadNumeroTelefono();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = new ListarNumerosTelef.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = NumerosTelef(
        idNumeroTelefono: listadoDepart.items[i].idNumeroTelefono,
        numeroTelefono: listadoDepart.items[i].numeroTelefono,
      );
      DatabasePr.db.insertNmTelef(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<Provincia>> getProvincias() async {
    String jsonString = await servicios.loadprovincias();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = new Provincias.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Provincia(
        provinciaDescripcion: listadoDepart.items[i].provinciaDescripcion,
        provinciaUbigeo: listadoDepart.items[i].provinciaUbigeo,
      );
      DatabasePr.db.insertProvincia(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<TipoDocumento>> getTipoDocumento() async {
    await DatabasePr.db.deleteTipoDocumento();
    String jsonString = await servicios.loadTipoDocumento();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = new ListarTipoDocumento.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = TipoDocumento(
        idTipoDocumento: listadoDepart.items[i].idTipoDocumento,
        descripcion: listadoDepart.items[i].descripcion,
      );
      await DatabasePr.db.insertTipoDocumento(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<Sexo>> getSexo() async {
    await DatabasePr.db.deletesexo();

    String jsonString = await servicios.loadSexo();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = new ListarSexo.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Sexo(
        id: listadoDepart.items[i].id,
        cod: listadoDepart.items[i].cod,
        descripcion: listadoDepart.items[i].descripcion,
      );
      await DatabasePr.db.insertSexo(rspt);
    }

    return listadoDepart.items;
  }

  Future<List<Provincia>> getSaveIntervenciones() async {
    String jsonString = await servicios.loadprovincias();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = new Provincias.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = Provincia(
        provinciaDescripcion: listadoDepart.items[i].provinciaDescripcion,
        provinciaUbigeo: listadoDepart.items[i].provinciaUbigeo,
      );
      DatabasePr.db.insertProvincia(rspt);
    }
    return listadoDepart.items;
  }

  Future<List<TipoPlataforma>> getSaveTipoPlataforma() async {
    await DatabasePr.db.initDB();
    await DatabasePr.db.eliminarTodoAsTipoPlataforma();
    String jsonString = await servicios.loadTipoPlataforma();
    final jsonResponse = json.decode(jsonString);
    final listadoDepart = new TipoPlataformas.fromJsonList(jsonResponse);

    for (var i = 0; i < listadoDepart.items.length; i++) {
      final rspt = TipoPlataforma(
        cod: listadoDepart.items[i].cod,
        descripcion: listadoDepart.items[i].descripcion,
        id: listadoDepart.items[i].id,
      );
      await DatabasePr.db.insertTipoPlataforma(rspt);
    }
    return listadoDepart.items;
  }

  Future<Participantes> getBuscarParticipante(dni) async {
    String jsonString = await servicios.loadParticipantes();

    final jsonResponse = json.decode(jsonString);
    final listadoDepart =
        new ListaParticipantesSer.fromJsonList(jsonResponse["response"]);
    for (var i = 0; i < listadoDepart.items.length; i++) {
      if (listadoDepart.items[i].dni == dni) {
        return listadoDepart.items[i];
      }
    }

    return new Participantes();
  }

  Future<List<Unidad>> getUnidad() async {
    await DatabasePr.db.deletesexo();

    String jsonString = await servicios.loadUnidad();
    final jsonResponse = json.decode(jsonString);
    final listado = new ListarUnidad.fromJsonList(jsonResponse);
    return listado.items;
  }
}
