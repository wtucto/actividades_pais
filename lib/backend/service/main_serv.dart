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
    bool isDeviceConnected = await CheckConnection.isOnlineWifiMobile();
    return isDeviceConnected;
  }

  /// SYNC
  Future syncAllMonitoreoByStatusPorEnviar(
    int? limit,
    int? offset,
  ) async {
    /// Obtiene todos los registros de la DB Local cuyo estado esten en: POR ENVIAR
    await getAllMonitorPorEnviar(limit, offset).then((a) async {
      await sendAllMonitoreo(a, []);
    });
  }

  /*
  Enviar los registros de monitoreo a la Base de datos central mediante el 
  API REST.

  @TramaMonitoreoModel a : Listado de Monitoreos para enviar registros a la nuve
  @TramaMonitoreoModel e : Listado de Monitoreos que fallaron al enviar
                           (Parametro solo valido para el metodo recursivo)

  CONSIDERACIONES:
  - Los estados del Monitoreo deben de tener el estado: POR ENVIAR

  SECUENCIAS:
    LOOP ... 
      (1) - Se envia el registros de monitoreo al API REST 
      (2) - Si el envio es correcto, se actualiza el registro en la DB Local al estado
        ENVIADO
      (3) - Responder con todos los registros enviados a la API REST
      (4) - Responder con todos los registros que generaron Error en la API REST
    END LOOP.
  */
  Future<List<TramaMonitoreoModel>> sendAllMonitoreo(
    List<TramaMonitoreoModel> a,
    List<TramaMonitoreoModel>? e,
  ) async {
    bool isOnlines = await isOnline();
    if (isOnlines) {
      List<TramaMonitoreoModel> aResp = [];
      List<TramaMonitoreoModel> aError = e ?? [];
      List<TramaMonitoreoModel> aNoConect = [];

      for (var oMonit in a) {
        /// (1)...
        oMonit.estadoMonitoreo = TramaMonitoreoModel.sEstadoENV;

        if (isOnlines) {
          try {
            final oResp =
                await Get.find<MainRepository>().insertarMonitoreo(oMonit);
            if (oResp.idMonitoreo != "") {
              /// (2)...
              TramaMonitoreoModel? oSend = oResp;
              oSend.id = oMonit.id;
              await Get.find<MainRepository>().updateMonitoreoDb(oSend);

              /// (3)...
              aResp.add(oSend);
            }
          } catch (oError) {
            /// (4)...
            aError.add(oMonit);

            ///Si falla volver a consultar si existe conexión
            isOnlines = await isOnline();
          }
        } else {
          /// (4)...
          aNoConect.add(oMonit);
        }
      }

      if (aNoConect.length > 0) {
        /**
         * Metodo recursivo: Solo reintentar los registros que no se enviaron
         * por perdida de conexión despues de 3 segundos
         */
        await Future.delayed(Duration(seconds: 2));
        sendAllMonitoreo(aNoConect, aError);
      }

      return aError;
    } else {
      return Future.error(
        '¡Ups! Algo salió mal, verifica tu conexión a Internet.',
      );
    }
  }

  /// PROYECTO
  Future<List<TramaProyectoModel>> getAllProyectoByUser(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind =
        await Get.find<MainRepository>().getAllProyectoByUser(o, limit, offset);

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

  Future<List<TramaProyectoModel>> getAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind = await Get.find<MainRepository>()
        .getAllProyectoByUserSearch(o, search, limit, offset);
    return aFind;
  }

  Future<List<TramaProyectoModel>> getProyectoByCUI(
    String cui,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaProyectoModel> aFind =
        await Get.find<MainRepository>().getProyectoByCUI(cui);
    return aFind;
  }

  Future<List<TramaMonitoreoModel>> getMonitoreoByIdMonitor(
    String idMonitoreo,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind =
        await Get.find<MainRepository>().getMonitoreoByIdMonitor(idMonitoreo);
    return aFind;
  }

  Future<List<TramaProyectoModel>> getAllProyecto(
    int? limit,
    int? offset,
  ) async {
    return await Get.find<MainRepository>().getAllProyectoDb(limit, offset);
  }

  Future<List<TramaProyectoModel>> loadAllProyecto(
    int? limit,
    int? offset,
  ) async {
    List<TramaProyectoModel> aNewProject = [];

    ///Verifica que tenga conexion a internet
    if (await isOnline()) {
      ///Obtiene los registros de la DB Local
      List<TramaProyectoModel> aDb =
          await Get.find<MainRepository>().getAllProyectoDb(limit, offset);

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
          _log.e('Error al ingresar proyectos a la Base de Datos');
        }
      }
    }

    _log.i('Nuevos proyectos cargados: ${aNewProject.length}');

    /// Obtiene y retorna todos los registros almacenados en la DB local
    List<TramaProyectoModel> aDbExist =
        await Get.find<MainRepository>().getAllProyectoDb(limit, offset);
    return aDbExist;
  }

  /// MONITOREO
  Future<List<TramaMonitoreoModel>> loadAllMonitoreo(
    int? limit,
    int? offset,
  ) async {
    List<TramaMonitoreoModel> aNewProject = [];
    if (await isOnline()) {
      List<TramaMonitoreoModel> aDb =
          await Get.find<MainRepository>().getAllMonitoreoDb(limit, offset);
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
            if (oDataFind.estadoMonitoreo != TramaMonitoreoModel.sEstadoENV) {
              /*
                Si el estado del monitoreo en la nuve es diferente a la data local, 
                se actualiza el registro local.
               */
              oApi.id = oDataFind.id;
              oApi.isEdit = 0;
              await Get.find<MainRepository>().updateMonitoreoDb(oApi);
            }
            continue;
          }
        }

        TramaMonitoreoModel? response =
            await Get.find<MainRepository>().insertMonitorDb(oApi);
        if (response != null) {
          aNewProject.add(response!);
        } else {
          _log.e('Error al ingresar monitoreo a la Base de Datos');
        }
      }
    }

    _log.i('Nuevos monitoreos cargados: ${aNewProject.length}');

    List<TramaMonitoreoModel> aDbExist =
        await Get.find<MainRepository>().getAllMonitoreoDb(limit, offset);
    return aDbExist;
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreo(
    int? limit,
    int? offset,
  ) async {
    //if (await isOnline()) {}
    return await Get.find<MainRepository>().getAllMonitoreoDb(limit, offset);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitorPorEnviar(
    int? limit,
    int? offset,
  ) async {
    //if (await isOnline()) {}
    return await Get.find<MainRepository>()
        .getAllMonitorPorEnviarDB(limit, offset);
  }

  Future<List<TramaMonitoreoModel>> getAllMonitoreoByProyecto(
    TramaProyectoModel o,
    int? limit,
    int? offset,
  ) async {
    ///Obtiene los registros de la DB Local
    List<TramaMonitoreoModel> aFind = await Get.find<MainRepository>()
        .getAllMonitoreoByIdProyectoDb(o, limit, offset);

    return aFind;
  }

  Future<List<TramaMonitoreoModel>> getAllSyncMonitoreo(
    int? limit,
    int? offset,
  ) async {
    List<TramaMonitoreoModel> aFilter = [];
    List<TramaMonitoreoModel> aDb =
        await Get.find<MainRepository>().getAllMonitoreoDb(limit, offset);

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

  /// USUARIO APP

  Future<UserModel> insertUserDb(UserModel o) async {
    UserModel? response = await Get.find<MainRepository>().insertUserDb(o);

    return response;
  }

  Future<List<UserModel>> loadAllUser(
    int? limit,
    int? offset,
  ) async {
    List<UserModel> aNewLoadUser = [];
    if (await isOnline()) {
      List<UserModel> aDb =
          await Get.find<MainRepository>().getAllUserDb(limit, offset);
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
          _log.e('Error al ingresar usuario a la Base de Datos');
        }
      }
    }

    _log.i('Nuevos usuarios cargados: ${aNewLoadUser.length}');

    List<UserModel> aDbExist =
        await Get.find<MainRepository>().getAllUserDb(limit, offset);
    return aDbExist;
  }

  Future<List<UserModel>> getAllUser(
    int? limit,
    int? offset,
  ) async {
    List<UserModel> aDbExist =
        await Get.find<MainRepository>().getAllUserDb(limit, offset);
    return aDbExist;
  }

  Future<UserModel> getUserByCode(
    String codigo,
  ) async {
    try {
      UserModel oUser = await Get.find<MainRepository>().readUserByCode(codigo);
      return oUser;
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
