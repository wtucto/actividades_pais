import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/util/check_connection.dart';
import 'package:get/get.dart';
import 'package:actividades_pais/backend/repository/main_repo.dart';
import 'package:logger/logger.dart';

class MainService {
  Logger _log = Logger();

  /// Returns `true` si existe conexion a internet por wifi.
  Future<bool> isOnline() async {
    bool isDeviceConnected = await CheckConnection.isOnlineWifi();
    return isDeviceConnected;
  }

  /// PROYECTO
  Future<List<TramaProyectoModel>> getAllProyectoByUser(
    UserModel o,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind =
        await Get.find<MainRepository>().getAllProyectoByUser(o);

    /*
    if (aDb.length > 0) {
      TramaProyectoModel? oDataFind;
      try {
        aDb.forEach((a) {
          bool isOk = false;
          if (o.rol == UserModel.sRolRES) {
            if (a.codResidente == o.codigo) isOk = true;
          } else if (o.rol == UserModel.sRolSUP) {
            if (a.codSupervisor == o.codigo) isOk = true;
          } else if (o.rol == UserModel.sRolCRP) {
            if (a.codCrp == o.codigo) isOk = true;
          }
          if (isOk) {
            aFind.add(a);
          }
        });
      } catch (oError) {
        _log.e(oError);
      }
    }
    */
    return aFind;
  }

  Future<List<TramaProyectoModel>> getAllProyecto() async {
    return await Get.find<MainRepository>().getAllProyectoDb();
  }

  Future<List<TramaProyectoModel>> loadAllProyecto() async {
    List<TramaProyectoModel> aNewProject = [];

    ///Verifica que tenga conexion a internet
    if (await isOnline()) {
      ///Obtiene los registros de la DB Local
      List<TramaProyectoModel> aDb =
          await Get.find<MainRepository>().getAllProyectoDb();

      ///Obtiene los registros de la nuve consumiento la API REST
      List<TramaProyectoModel> aApi =
          await Get.find<MainRepository>().getAllProyectoApi();

      /**
       * Se realiza:
       * Matach entre los dos registros (DB y API),
       * Si los registros de la API teniendo como base el ID @CUI (Código único del proyecto)
       * (1) - existe en la DB local se ignora el registro
       * (2) - caso contrario se procede a registrar a la DB local.
       */
      for (TramaProyectoModel oApi in aApi) {
        if (aDb.length > 0) {
          TramaProyectoModel? oDataFind;
          try {
            oDataFind = aDb.firstWhere((o) => o.cui == oApi.cui,
                orElse: () => TramaProyectoModel.empty());
          } catch (oError) {
            _log.e(oError);
          }

          /// (1)
          if (oDataFind != null || oDataFind!.id == 0) {
            continue;
          }
        }

        /// (2)
        TramaProyectoModel? response =
            await Get.find<MainRepository>().insertProyectoDb(oApi);
        if (response != null) {
          aNewProject.add(response!);
        } else {
          _log.e("Error al ingresar proyectos a la Base de Datos");
        }
      }
    }

    _log.i("Nuevos proyectos cargados: ${aNewProject.length}");

    /// Obtiene y retorna todos los registros almacenados en la DB local
    List<TramaProyectoModel> aDbExist =
        await Get.find<MainRepository>().getAllProyectoDb();
    return aDbExist;
  }

  /// MONITOREO
  Future<List<TramaMonitoreoModel>> loadAllMonitoreo() async {
    List<TramaMonitoreoModel> aNewProject = [];
    if (await isOnline()) {
      List<TramaMonitoreoModel> aDb =
          await Get.find<MainRepository>().getAllMonitoreoDb();
      List<TramaMonitoreoModel> aApi =
          await Get.find<MainRepository>().getAllMonitoreoApi();

      for (TramaMonitoreoModel oApi in aApi) {
        if (aDb.length > 0) {
          TramaMonitoreoModel? oDataFind;
          try {
            oDataFind = aDb.firstWhere((o) => o.idMonitoreo == oApi.idMonitoreo,
                orElse: () => TramaMonitoreoModel.empty());
          } catch (oError) {
            _log.e(oError);
          }
          if (oDataFind != null || oDataFind!.id == 0) {
            continue;
          }
        }

        TramaMonitoreoModel? response =
            await Get.find<MainRepository>().insertMonitorDb(oApi);
        if (response != null) {
          aNewProject.add(response!);
        } else {
          _log.e("Error al ingresar monitoreo a la Base de Datos");
        }
      }
    }

    _log.i("Nuevos monitoreos cargados: ${aNewProject.length}");

    List<TramaMonitoreoModel> aDbExist =
        await Get.find<MainRepository>().getAllMonitoreoDb();
    return aDbExist;
  }

  Future<List<TramaMonitoreoModel>> fetchAllTramaMonitoreoModel() async {
    List<TramaMonitoreoModel> aTramaMonitoreoModel = [];
    aTramaMonitoreoModel = await Get.find<MainRepository>().getAllMonitoreoDb();
    return aTramaMonitoreoModel;
  }

  Future<List<TramaMonitoreoModel>> mergeAllTramaMonitoreoModel(
      List<TramaMonitoreoModel> a) async {
    List<TramaMonitoreoModel> aTramaMonitoreoModel = [];
    aTramaMonitoreoModel =
        await Get.find<MainRepository>().saveAllMonitoreo(aTramaMonitoreoModel);
    return aTramaMonitoreoModel;
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreo() async {
    //if (await isOnline()) {}
    return await Get.find<MainRepository>().getAllMonitoreoDb();
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoByProyecto(
    TramaProyectoModel o,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind =
        await Get.find<MainRepository>().getAllMonitoreoByIdProyectoDb(o);

    return aFind;
  }

  Future<List<TramaMonitoreoModel>> getAllSyncMonitoreo() async {
    List<TramaMonitoreoModel> aFilter = [];
    List<TramaMonitoreoModel> aDb =
        await Get.find<MainRepository>().getAllMonitoreoDb();

    for (TramaMonitoreoModel oDb in aDb) {
      if (aDb.length > 0) {
        TramaMonitoreoModel? oFilter;
        try {
          oFilter = aDb.firstWhere(
              (o) => o.estadoMonitoreo == TramaMonitoreoModel.sEstadoPEN,
              orElse: () => TramaMonitoreoModel.empty());
        } catch (oError) {
          _log.e(oError);
        }
        if (oFilter != null || oFilter!.id == 0) {
          continue;
        }
      }
    }
    return aFilter;
  }

  Future<TramaMonitoreoModel> insertMonitorDb(
    TramaMonitoreoModel o,
  ) async {
    return await Get.find<MainRepository>().insertMonitorDb(o);
  }

  Future<List<TramaMonitoreoModel>> sendMonitoreo(
    List<TramaMonitoreoModel> a,
  ) async {
    if (await isOnline()) {
      return await Get.find<MainRepository>().saveAllMonitoreo(a);
    }
    return [];
  }

  Future syncAllTramaMonitoreoModel() async {
    await fetchAllTramaMonitoreoModel().then((a) async {
      await mergeAllTramaMonitoreoModel(a);
    });
  }

  /// USUARIO APP
  Future<List<UserModel>> loadAllUser() async {
    List<UserModel> aNewLoadUser = [];
    if (await isOnline()) {
      List<UserModel> aDb = await Get.find<MainRepository>().getAllUserDb();
      List<UserModel> aApi = await Get.find<MainRepository>().getAllUserApi();

      for (UserModel oApi in aApi) {
        if (aDb.length > 0) {
          UserModel oUserFind = aDb.firstWhere((o) => o.codigo == oApi.codigo);
          if (oUserFind != null) {
            continue;
          }
        }

        UserModel? response =
            await Get.find<MainRepository>().insertUserDb(oApi);
        if (response != null) {
          aNewLoadUser.add(response!);
        } else {
          _log.e("Error al ingresar usuario a la Base de Datos");
        }
      }
    }

    _log.i("Nuevos usuarios cargados: ${aNewLoadUser.length}");

    List<UserModel> aDbExist = await Get.find<MainRepository>().getAllUserDb();
    return aDbExist;
  }

  Future<List<UserModel>> getAllUser() async {
    List<UserModel> aDbExist = await Get.find<MainRepository>().getAllUserDb();
    return aDbExist;
  }

  Future<UserModel> getUser(
    String codigo,
  ) async {
    try {
      List<UserModel> oUserLogin =
          await Get.find<MainRepository>().readUser(codigo);
      return oUserLogin[0];
    } catch (oError) {
      _log.e(oError);
    }
    return Future.error(
      'Usuario incorrecto, vuelve a intentarlo mas tarde.',
    );
  }

  Future<UserModel> getUserLogin(
    String codigo,
    String clave,
  ) async {
    try {
      List<UserModel> oUserLogin =
          await Get.find<MainRepository>().readEditUser(codigo, clave);
      return oUserLogin[0];
    } catch (oError) {
      _log.e(oError);
    }
    return Future.error(
      'Usuario y/o Clave incorrecto, vuelve a intentarlo mas tarde.',
    );
  }
}
