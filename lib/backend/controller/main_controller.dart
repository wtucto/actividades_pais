import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/backend/service/main_serv.dart';
import 'package:actividades_pais/util/check_geolocator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class MainController extends GetxController {
  Logger _log = Logger();

  final loading = false.obs;
  final users = <UserModel>[].obs;
  final moniteos = <TramaMonitoreoModel>[].obs;
  final proyectos = <TramaProyectoModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await loadInitialData();
  }

  /*
   Carga todos los registros inicial del sistema de la API REST a la DB local
   */
  Future<void> loadInitialData() async {
    loading.value = true;
    /*final serv = Get.put(MainService());
    users.value = await serv.loadAllUser();*/
    proyectos.value = await Get.find<MainService>().loadAllProyecto(0, 0);
    moniteos.value = await Get.find<MainService>().loadAllMonitoreo(0, 0);
    users.value = await Get.find<MainService>().loadAllUser(0, 0);
    loading.value = false;
  }

  /*
   Obtiene la lista de Usuarios en general
   */
  Future<void> getAllUser(
    int? limit,
    int? offset,
  ) async {
    if (loading.isTrue) return;
    loading.value = true;
    final newUser = await Get.find<MainService>().getAllUser(limit, offset);
    loading.value = false;
  }

  /*
   Obtiene los datos del usuario
   @String codigo
   @String clave (Opcional)
   */
  Future<UserModel> getUserLogin(
    String codigo,
    String clave,
  ) async {
    UserModel oUserLogin = await Get.find<MainService>().getUserByCode(codigo);

    if (clave != "") {
      if (oUserLogin.clave == clave) {
        return oUserLogin;
      }
    } else {
      return oUserLogin;
    }

    return Future.error(
      "Usuario y/o Clave incorrecto, vuelve a intentarlo mas tarde.",
    );
  }

  /*
   Actualiza datos del Usuario
   @UserModel o
   */
  Future<UserModel> insertUser(UserModel o) async {
    try {
      UserModel oUserLogin = await Get.find<MainService>().insertUserDb(o);
      return oUserLogin;
    } catch (oError) {
      return Future.error(
        oError.toString(),
      );
    }
  }

  /*
   Obtiene la lista de Proyectos en general
   */
  Future<List<TramaProyectoModel>> getAllProyecto(
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>().getAllProyecto(limit, offset);
  }

  /*
   Obtiene la lista de proyectos segun el ROL del Usuario
   @UserModel o
   */
  Future<List<TramaProyectoModel>> getAllProyectoByUser(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>().getAllProyectoByUser(o, limit, offset);
  }

  /*
   Obtiene la lista de proyectos segun el ROL del Usuario y busqueda según la coincidencia
   @UserModel o
   @String search
   */
  Future<List<TramaProyectoModel>> getAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>()
        .getAllProyectoByUserSearch(o, search, limit, offset);
  }

  /*
   Obtiene los datos de generales del proyecto
   @String CUI
   */
  Future<List<TramaProyectoModel>> getProyectoById(
    String cui,
  ) async {
    return await Get.find<MainService>().getProyectoByCUI(cui);
  }

  /*
   Obtiene la lista de Monitoreos en general
   */
  Future<List<TramaMonitoreoModel>> getAllMonitor(
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>().getAllMonitoreo(limit, offset);
  }

  /*
   Obtiene la lista de Monitoreos cuyo estado sea POR ENVIAR
   */
  Future<List<TramaMonitoreoModel>> getAllMonitorPorEnviar(
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>().getAllMonitorPorEnviar(limit, offset);
  }

  /*
   Obtiene la lista de Monitoreos segun el Proyecto seleccionado
   @TramaProyectoModel o
   */
  Future<List<TramaMonitoreoModel>> getAllMonitoreoByProyecto(
    TramaProyectoModel o,
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainService>()
        .getAllMonitoreoByProyecto(o, limit, offset);
  }

  /*
   Obtiene los datos de generales del Monitoreo por el idMonitoreo
   @String idMonitoreo
   */
  Future<List<TramaMonitoreoModel>> getMonitoreoById(
    String sIdMonitoreo,
  ) async {
    return await Get.find<MainService>().getMonitoreoByIdMonitor(sIdMonitoreo);
  }

  /*
   Guardar/Actualizar nuevo Monitoreo y valida campos requeridos
   @TramaProyectoModel o
   */
  Future<TramaMonitoreoModel> saveMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    DateFormat oDFormat = DateFormat('yyyy-MM-dd');
    DateFormat oDFormat2 = DateFormat('HHmmss');
    DateTime _now = DateTime.now();

    if (loading.isTrue) {
      return Future.error(
        'Ya hay un proceso en ejecución, espere a que finalice.',
      );
    }

    loading.value = true;

    if (o.estadoMonitoreo!.trim().toUpperCase() ==
        TramaMonitoreoModel.sEstadoENV) {
      loading.value = false;
      return Future.error(
        'Imposible modificar un Monitoreo con el estado: ${TramaMonitoreoModel.sEstadoENV}',
      );
    }

    if (o.cui!.trim() == '') {
      loading.value = false;
      return Future.error(
        'Error al procesar el Monitoreo, verifique los siguientes campos: CUI.',
      );
    }

    if (o.fechaMonitoreo!.trim() == '') {
      o.fechaMonitoreo = oDFormat.format(_now);
    }

    String idBuild = '<CUI>_<IDE>_<FECHA_MONITOREO>';
    idBuild = idBuild.replaceAll('<IDE>', oDFormat2.format(_now));
    idBuild = idBuild.replaceAll('<CUI>', o.cui!);
    idBuild = idBuild.replaceAll('<FECHA_MONITOREO>', o.fechaMonitoreo!);
    o.idMonitoreo = idBuild;

    /*
      Autocompletar campos con datos del Proyecto
      - cui -> cui
      - snip -> numSnip
      - tambo -> tambo
      - fechaTerminoEstimado -> fechaTerminoEstimado
      - avanceFisicoAcumulado -> avanceFisico
    */
    try {
      List<TramaProyectoModel> aSearh =
          await Get.find<MainService>().getProyectoByCUI(o.cui!);
      if (aSearh != null && aSearh.length > 0) {
        TramaProyectoModel oProyecto = aSearh[0];
        if (o.snip!.trim() == '') {
          o.snip = oProyecto.numSnip;
        }
        if (o.tambo!.trim() == '') {
          o.tambo = oProyecto.tambo;
        }
        if (o.fechaTerminoEstimado!.trim() == '') {
          o.fechaTerminoEstimado = oProyecto.fechaTerminoEstimado;
        }
        if (o.avanceFisicoAcumulado! == 0) {
          o.avanceFisicoAcumulado = isNumeric(oProyecto.avanceFisico)
              ? double.parse(oProyecto.avanceFisico.toString())
              : 0;
        }
      }
    } catch (oError) {
      _log.e(
        oError.toString(),
      );
    }

    bool isComplete = await validateMonitor(o);

    if (isComplete) {
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoPEN;
    } else {
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoINC;
    }

    final oResp = await Get.find<MainService>().insertMonitorDb(o);
    loading.value = false;

    return oResp;
  }

  /*
    Enviar registros a la nuve
    - Validar que todos los campos requeridos esten completos
    - Validar que el estado esta en: POR ENVIAR
    - Validar que se encuentre con conexion a internet
  */
  Future<List<TramaMonitoreoModel>> sendMonitoreo(
    List<TramaMonitoreoModel> a,
  ) async {
    try {
      if (loading.isTrue) {
        return Future.error(
          'Ya hay un proceso en ejecución, espere a que finalice.',
        );
      }

      loading.value = true;

      /// Evaluar que todos los monitoreos de la lista tengan el estado
      /// POR ENVIAR
      bool isOk = true;
      a.forEach((o) {
        if (o.estadoMonitoreo != TramaMonitoreoModel.sEstadoPEN) {
          //isOk = false;
        }
      });

      if (isOk == true) {
        final aResp = await Get.find<MainService>().sendAllMonitoreo(a, []);
        /*if (aResp.length > 0) {
        return Future.error(
          'Hay registros que no se pudieron enviar al servidor porque generaron un error: ${aResp.length}',
        );
      }*/
        /// Retornar registros que generar error al enviarse al servidor
        loading.value = false;
        return aResp;
      }

      throw Exception(
        'Imposible enviar documentos al servidor debido a que tienen estados diferentes a : ${TramaMonitoreoModel.sEstadoPEN}',
      );
    } catch (oError) {
      loading.value = false;
      return Future.error(
        oError.toString(),
      );
    }
  }

  Future<bool> validateMonitor(
    TramaMonitoreoModel o,
  ) async {
/*
      Validar campos OBLIGATORIOS
      - ID: <cui>_IDE_<fechaMonitoreo>
      - latitud
      - longitud
      - fechaTerminoEstimado
      - actividadPartidaEjecutada
      - alternativaSolucion
      - avanceFisicoAcumulado
      - estadoAvance
      - fechaMonitoreo
      - imgActividad
      - problemaIdentificado
    */

    bool isComplete = true;
    if (o.latitud!.trim() == '') {
      isComplete = false;
    } else if (o.longitud!.trim() == '') {
      isComplete = false;
    } else if (o.fechaTerminoEstimado!.trim() == '') {
      isComplete = false;
    } else if (o.actividadPartidaEjecutada!.trim() == '') {
      isComplete = false;
    } else if (o.alternativaSolucion!.trim() == '') {
      isComplete = false;
    } else if (o.avanceFisicoAcumulado! == 0) {
      isComplete = false;
    } else if (o.estadoAvance!.trim() == '') {
      isComplete = false;
    } else if (o.imgActividad!.trim() == '') {
      isComplete = false;
    } else if (o.problemaIdentificado!.trim() == '') {
      isComplete = false;
    }

    return isComplete;
  }

  Future<TramaMonitoreoModel> buildNewMonitor(
    String cui,
  ) async {
    DateFormat oDFormat = DateFormat('yyyy-MM-dd');
    DateFormat oDFormat2 = DateFormat('HHmmss');
    DateTime _now = DateTime.now();
    TramaMonitoreoModel o = TramaMonitoreoModel.empty();

    /*
      Autocompletar campos con datos del Proyecto
      - cui -> cui
      - snip -> numSnip
      - tambo -> tambo
      - fechaTerminoEstimado -> fechaTerminoEstimado
      - avanceFisicoAcumulado -> avanceFisico
    */
    try {
      if (o.fechaMonitoreo!.trim() == '') {
        o.fechaMonitoreo = oDFormat.format(DateTime.now());
      }

      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoINC;

      List<TramaProyectoModel> aSearh =
          await Get.find<MainService>().getProyectoByCUI(cui);
      if (aSearh != null && aSearh.length > 0) {
        TramaProyectoModel oProyecto = aSearh[0];

        String idBuild = '<CUI>_<IDE>_<FECHA_MONITOREO>';
        idBuild = idBuild.replaceAll('<CUI>', oProyecto.cui!);
        idBuild = idBuild.replaceAll('<IDE>', oDFormat2.format(_now));
        idBuild = idBuild.replaceAll('<FECHA_MONITOREO>', o.fechaMonitoreo!);
        o.idMonitoreo = idBuild;

        if (o.cui!.trim() == '') {
          o.cui = oProyecto.cui;
        }
        if (o.snip!.trim() == '') {
          o.snip = oProyecto.numSnip;
        }
        if (o.tambo!.trim() == '') {
          o.tambo = oProyecto.tambo;
        }
        if (o.fechaTerminoEstimado!.trim() == '') {
          o.fechaTerminoEstimado = oProyecto.fechaTerminoEstimado;
        }
        if (o.avanceFisicoAcumulado! == 0) {
          o.avanceFisicoAcumulado = isNumeric(oProyecto.avanceFisico)
              ? double.parse(oProyecto.avanceFisico.toString())
              : 0;
        }
        try {
          List<Position> aPosition = await CheckGeolocator().check();
          o.latitud = aPosition[0].latitude.toString();
          o.longitud = aPosition[0].longitude.toString();
        } catch (oError) {
          _log.e(
            oError.toString(),
          );
        }
      } else {
        String idBuild = '<CUI>_<IDE>_<FECHA_MONITOREO>';
        idBuild = idBuild.replaceAll('<CUI>', cui);
        idBuild = idBuild.replaceAll('<IDE>', oDFormat2.format(_now));
        idBuild = idBuild.replaceAll('<FECHA_MONITOREO>', o.fechaMonitoreo!);
        o.idMonitoreo = idBuild;
        o.cui = cui;
      }
    } catch (oError) {
      _log.e(
        oError.toString(),
      );
      return Future.error(oError.toString());
    }

    bool isComplete = await validateMonitor(o);

    if (isComplete) {
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoPEN;
    } else {
      o.estadoMonitoreo = TramaMonitoreoModel.sEstadoINC;
    }

    return o;
  }

  bool isNumeric(dynamic s) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(s);
  }
}
/**
 * @override
  Widget build(BuildContext context) {
    ...
  final controller = Get.put(MainController()); // Se ejecuta loadInitialData();

  return Scaffold(...

 */
