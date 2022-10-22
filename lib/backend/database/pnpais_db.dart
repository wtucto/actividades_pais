import 'package:actividades_pais/backend/model/listar_registro_entidad_actividad_model.dart';
import 'package:actividades_pais/backend/model/listar_programa_intervenciones_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePnPais {
  static final DatabasePnPais instance = DatabasePnPais._init();

  static Database? _database;
  static const _version = 1;

  final createTable = 'CREATE TABLE';
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT';
  final boolType = 'BOOLEAN';
  final integerType = 'INTEGER';
  final notNull = 'NOT NULL';
  final sLimit = "LIMIT [limit]";
  final sOffset = "OFFSET [offset]";

  DatabasePnPais._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pnpais.db');
    return _database!;
  }

  Future<Database> _initDB(
    String filePath,
  ) async {
    //Directory directory = await getApplicationDocumentsDirectory();
    //String path = join(directory.path, filePath);

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: _version,
      onCreate: _insertDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _insertDB(
    Database db,
    int version,
  ) async {
    var constFields = '''
      ${TramaMonitoreoFields.id} $idType, 
      ${TramaMonitoreoFields.time} $textType,
      ${TramaMonitoreoFields.isEdit} $boolType $notNull
      ''';

    await db.execute('''
    $createTable $tableNameUsers ( 
      $constFields,

      ${UserFields.codigo} $textType $notNull,
      ${UserFields.nombres} $textType $notNull,
      ${UserFields.rol} $textType $notNull,
      ${UserFields.clave} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameTramaMonitoreos ( 
      $constFields,

      ${TramaMonitoreoFields.cui} $textType,
      ${TramaMonitoreoFields.snip} $textType $notNull,
      ${TramaMonitoreoFields.tambo} $textType,
      ${TramaMonitoreoFields.latitud} $textType,
      ${TramaMonitoreoFields.longitud} $textType,
      ${TramaMonitoreoFields.fechaTerminoEstimado} $textType,
      ${TramaMonitoreoFields.actividadPartidaEjecutada} $textType,
      ${TramaMonitoreoFields.alternativaSolucion} $textType,
      ${TramaMonitoreoFields.avanceFisicoAcumulado} $textType,
      ${TramaMonitoreoFields.avanceFisicoPartida} $textType,
      ${TramaMonitoreoFields.estadoAvance} $textType,
      ${TramaMonitoreoFields.estadoMonitoreo} $textType,
      ${TramaMonitoreoFields.fechaMonitoreo} $textType,
      ${TramaMonitoreoFields.idMonitoreo} $textType,
      ${TramaMonitoreoFields.idUsuario} $textType,
      ${TramaMonitoreoFields.imgActividad} $textType,
      ${TramaMonitoreoFields.imgActividad1} $textType,
      ${TramaMonitoreoFields.imgActividad2} $textType,
      ${TramaMonitoreoFields.imgActividad3} $textType,
      ${TramaMonitoreoFields.imgActividad4} $textType,
      ${TramaMonitoreoFields.imgProblema} $textType,
      ${TramaMonitoreoFields.imgProblema1} $textType,
      ${TramaMonitoreoFields.imgProblema2} $textType,
      ${TramaMonitoreoFields.imgProblema3} $textType,
      ${TramaMonitoreoFields.imgProblema4} $textType,
      ${TramaMonitoreoFields.imgRiesgo} $textType,
      ${TramaMonitoreoFields.imgRiesgo1} $textType,
      ${TramaMonitoreoFields.imgRiesgo2} $textType,
      ${TramaMonitoreoFields.imgRiesgo3} $textType,
      ${TramaMonitoreoFields.imgRiesgo4} $textType,
      ${TramaMonitoreoFields.observaciones} $textType,
      ${TramaMonitoreoFields.problemaIdentificado} $textType,
      ${TramaMonitoreoFields.riesgoIdentificado} $textType,
      ${TramaMonitoreoFields.nivelRiesgo} $textType,
      
      ${TramaMonitoreoFields.rol} $textType,
      ${TramaMonitoreoFields.usuario} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameTramaProyectos ( 
      $constFields,

      ${TramaProyectoFields.numSnip} $textType,
      ${TramaProyectoFields.cui} $textType,
      ${TramaProyectoFields.latitud} $textType,
      ${TramaProyectoFields.longitud} $textType,
      ${TramaProyectoFields.departamento} $textType,
      ${TramaProyectoFields.provincia} $textType,
      ${TramaProyectoFields.distrito} $textType,
      ${TramaProyectoFields.tambo} $textType,
      ${TramaProyectoFields.centroPoblado} $textType,
      ${TramaProyectoFields.estado} $textType,
      ${TramaProyectoFields.subEstado} $textType,
      ${TramaProyectoFields.estadoSaneamiento} $textType,
      ${TramaProyectoFields.modalidad} $textType,
      ${TramaProyectoFields.fechaInicio} $textType,
      ${TramaProyectoFields.fechaTerminoEstimado} $textType,
      ${TramaProyectoFields.inversion} $textType,
      ${TramaProyectoFields.costoEjecutado} $textType,
      ${TramaProyectoFields.costoEstimadoFinal} $textType,
      ${TramaProyectoFields.avanceFisico} $textType,
      ${TramaProyectoFields.residente} $textType,
      ${TramaProyectoFields.supervisor} $textType,
      ${TramaProyectoFields.crp} $textType,
      ${TramaProyectoFields.codResidente} $textType,
      ${TramaProyectoFields.codSupervisor} $textType,
      ${TramaProyectoFields.codCrp} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameProgramacionIntervenciones ( 
      $constFields,

      ${ProgramacionIntervencionesFields.idProgramacionIntervenciones} $textType,
      ${ProgramacionIntervencionesFields.adjuntarArchivo} $textType,
      ${ProgramacionIntervencionesFields.anio} $textType,
      ${ProgramacionIntervencionesFields.convenio} $textType,
      ${ProgramacionIntervencionesFields.descripcionDelEvento} $textType,
      ${ProgramacionIntervencionesFields.detalleNecesidades} $textType,
      ${ProgramacionIntervencionesFields.documentoQueAcreditaElEvento} $textType,
      ${ProgramacionIntervencionesFields.dondeSeRealizoElEvento} $textType,
      ${ProgramacionIntervencionesFields.fecha} $textType,
      ${ProgramacionIntervencionesFields.horaFin} $textType,
      ${ProgramacionIntervencionesFields.horaInicio} $textType,
      ${ProgramacionIntervencionesFields.laIntervencionRespondeAUnConvenio} $textType,
      ${ProgramacionIntervencionesFields.laIntervencionesPerteneceA} $textType,
      ${ProgramacionIntervencionesFields.ndePersonasConvocadasAParticiparEnElEvento} $textType,
      ${ProgramacionIntervencionesFields.nplanDeTrabajo} $textType,
      ${ProgramacionIntervencionesFields.perteneceAUnPlanDeTrabajo} $textType,
      ${ProgramacionIntervencionesFields.plataforma} $textType,
      ${ProgramacionIntervencionesFields.progrmacionParaOtroTambio} $textType,
      ${ProgramacionIntervencionesFields.tipoAccion} $textType,
      ${ProgramacionIntervencionesFields.tipoPlanDeTrabajo} $textType,
      ${ProgramacionIntervencionesFields.unidadTerritoria} $textType
      )
    ''');

    await db.execute('''
    $createTable $tableNameRegistroEntidadActividad ( 
      $constFields,

      ${RegistroEntidadActividadFields.idRegistroEntidadesYActividades} $textType,
      ${RegistroEntidadActividadFields.idProgramacionIntervenciones} $textType,
      ${RegistroEntidadActividadFields.categoria} $textType,
      ${RegistroEntidadActividadFields.descripcionDeLaActividadProgramada} $textType,
      ${RegistroEntidadActividadFields.programa} $textType,
      ${RegistroEntidadActividadFields.sector} $textType,
      ${RegistroEntidadActividadFields.servicio} $textType,
      ${RegistroEntidadActividadFields.subCategoria} $textType,
      ${RegistroEntidadActividadFields.tipoActividad} $textType,
      ${RegistroEntidadActividadFields.tipoDeUsuario} $textType
      )
    ''');

    /*
    var tableNames = (await db
          .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
      .map((row) => row['name'] as String)
      .toList(growable: false);*/
    /*
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });
    */
  }

  Future _upgradeDB(
    Database db,
    int oldversion,
    int newversion,
  ) async {
    if (oldversion < newversion) {
      print("Version Upgrade");
    }
  }

  /// PROYECTO
  Future<List<TramaProyectoModel>> readAllProyecto(
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaProyectoFields.numSnip} ASC';

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaProyectos,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaProyectos,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<TramaProyectoModel>((json) => TramaProyectoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaProyectoModel>> readAllProyectoByUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaProyectoFields.numSnip} ASC';

    dynamic result;

    String sWhere = '';
    if (o.rol == UserModel.sRolRES) {
      sWhere = TramaProyectoFields.codResidente;
    } else if (o.rol == UserModel.sRolSUP) {
      sWhere = TramaProyectoFields.codSupervisor;
    } else if (o.rol == UserModel.sRolCRP) {
      sWhere = TramaProyectoFields.codCrp;
    }

    if (sWhere == '') return [];

    if (limit! > 0) {
      if (search != '') {
        sWhere =
            '$sWhere = ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWhere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWhere = ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      }
    } else {
      if (search != '') {
        sWhere =
            '$sWhere = ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWhere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWhere = ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
        );
      }
    }

    if (result.length == 0) return [];
    return result
        .map<TramaProyectoModel>((json) => TramaProyectoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaProyectoModel>> readAllProyectoByNeUserSearch(
    UserModel o,
    String search,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaProyectoFields.numSnip} ASC';

    dynamic result;

    String sWhere = '';
    if (o.rol == UserModel.sRolRES) {
      sWhere = TramaProyectoFields.codResidente;
    } else if (o.rol == UserModel.sRolSUP) {
      sWhere = TramaProyectoFields.codSupervisor;
    } else if (o.rol == UserModel.sRolCRP) {
      sWhere = TramaProyectoFields.codCrp;
    }

    if (sWhere == '') return [];

    if (limit! > 0) {
      if (search != '') {
        sWhere =
            '$sWhere != ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWhere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWhere != ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      }
    } else {
      if (search != '') {
        sWhere =
            '$sWhere != ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWhere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWhere != ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
        );
      }
    }

    if (result.length == 0) return [];
    return result
        .map<TramaProyectoModel>((json) => TramaProyectoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaProyectoModel>> readAProyectoByCUI(
    String sId,
  ) async {
    final db = await instance.database;

    dynamic result = await db.query(
      tableNameTramaProyectos,
      where: '${TramaProyectoFields.cui} = ?',
      whereArgs: [sId],
    );

    if (result.length == 0) return List.empty();
    return result
        .map<TramaProyectoModel>((json) => TramaProyectoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readMonitoreoByIdMonitor(
    String sIdMonitoreo,
  ) async {
    final db = await instance.database;

    dynamic result = await db.query(
      tableNameTramaMonitoreos,
      where: '${TramaMonitoreoFields.idMonitoreo} = ?',
      whereArgs: [sIdMonitoreo],
    );

    if (result.length == 0) return List.empty();
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<TramaProyectoModel> insertProyecto(
    TramaProyectoModel o,
  ) async {
    final db = await instance.database;
    final id = await db.insert(
      tableNameTramaProyectos,
      o.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return o.copy(id: id);
  }

  /// MONITOREO
  Future<List<TramaMonitoreoModel>> readAllMonitoreoPorEnviar(
    int? limit,
    int? offset,
    TramaProyectoModel? o,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaMonitoreoFields.idMonitoreo} ASC';

    String sWhere = '${TramaMonitoreoFields.estadoMonitoreo} = ?';
    List<Object?> arg = [TramaMonitoreoModel.sEstadoPEN];
    if (o!.cui != "") {
      sWhere = '$sWhere AND ${TramaMonitoreoFields.cui} = ?';
      arg.add(o.cui);
    }

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: sWhere,
        whereArgs: arg,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: sWhere,
        whereArgs: arg,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readAllMonitoreo(
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaMonitoreoFields.idMonitoreo} ASC';

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaMonitoreos,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaMonitoreos,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readAllOtherMonitoreo(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaMonitoreoFields.idMonitoreo} ASC';

    String sWhere = '';
    if (o.rol == UserModel.sRolRES) {
      sWhere = TramaProyectoFields.codResidente;
    } else if (o.rol == UserModel.sRolSUP) {
      sWhere = TramaProyectoFields.codSupervisor;
    } else if (o.rol == UserModel.sRolCRP) {
      sWhere = TramaProyectoFields.codCrp;
    }

    String sQuery = '''
    
    SELECT 
      a.*,
      b.${TramaProyectoFields.codResidente},
      b.${TramaProyectoFields.codSupervisor},
      b.${TramaProyectoFields.codCrp}
    FROM $tableNameTramaMonitoreos AS a  
    LEFT JOIN $tableNameTramaProyectos AS b 
           ON b.${TramaProyectoFields.cui} = a.${TramaMonitoreoFields.cui}
    WHERE b.$sWhere != ?
    ORDER BY a.$orderBy

    ''';

    dynamic result;
    if (limit! > 0) {
      result = await db.rawQuery(sQuery, [o.codigo]);
    } else {
      result = await db.rawQuery(sQuery, [o.codigo]);
    }

    if (result.length == 0) return [];
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<List<TramaMonitoreoModel>> readAllMonitoreoByIdProyecto(
    int? limit,
    int? offset,
    TramaProyectoModel o,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaMonitoreoFields.idMonitoreo} ASC';

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: '${TramaMonitoreoFields.cui} = ?',
        whereArgs: [o.cui],
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: '${TramaMonitoreoFields.cui} = ?',
        whereArgs: [o.cui],
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<TramaMonitoreoModel>((json) => TramaMonitoreoModel.fromJson(json))
        .toList();
  }

  Future<TramaMonitoreoModel> insertMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    final db = await instance.database;
    if (o.id != null && o.id! > 0) {
      await updateMonitoreo(o);
      return o.copy(id: o.id);
    } else {
      final id = await db.insert(
        tableNameTramaMonitoreos,
        o.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return o.copy(id: id);
    }
  }

  Future<int> updateMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameTramaMonitoreos,
      o.toJson(),
      where: '${TramaMonitoreoFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<int> deleteMonitoreo(
    int i,
  ) async {
    final db = await instance.database;
    return await db.delete(
      tableNameTramaMonitoreos,
      where: '${TramaMonitoreoFields.id} = ?',
      whereArgs: [i],
    );
  }

  /// USUARIO APP

  Future<List<UserModel>> readAllUser(
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${UserFields.time} ASC';
    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameUsers,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameUsers,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result.map<UserModel>((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel> readUserByCode(
    String i,
  ) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNameUsers,
      columns: UserFields.values,
      where: '${UserFields.codigo} = ?',
      whereArgs: [i],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      throw Exception('Codigo $i not found');
    }
  }

  Future<UserModel> insertUser(
    UserModel o,
  ) async {
    final db = await instance.database;
    final id = await db.insert(
      tableNameUsers,
      o.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return o.copy(id: id);
  }

  Future<int> updateUser(
    UserModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameUsers,
      o.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<List<ProgramacionIntervencionesModel>> readProgramaIntervencion(
    String? id,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${ProgramacionIntervencionesFields.time} ASC';
    dynamic result;

    if (id != "") {
      result = await db.query(
        tableNameProgramacionIntervenciones,
        columns: ProgramacionIntervencionesFields.values,
        where:
            '${ProgramacionIntervencionesFields.idProgramacionIntervenciones} = ?',
        whereArgs: [id],
      );

      if (result.length >= 0) {
        var aRegAct = await db.query(
          tableNameRegistroEntidadActividad,
          columns: RegistroEntidadActividadFields.values,
          where:
              '${RegistroEntidadActividadFields.idProgramacionIntervenciones} = ?',
          whereArgs: [id],
        );

        if (aRegAct.length >= 0) {
          result.map<ProgramacionIntervencionesModel>((json) {
            json[ProgramacionIntervencionesFields.registroEntidadActividades] =
                aRegAct
                    .where(
                      (e) => (e[RegistroEntidadActividadFields
                              .idProgramacionIntervenciones] ==
                          json[ProgramacionIntervencionesFields
                              .idProgramacionIntervenciones]),
                    )
                    .toList();
          });
        }
      }
    } else if (limit! > 0) {
      result = await db.query(
        tableNameProgramacionIntervenciones,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameProgramacionIntervenciones,
        orderBy: orderBy,
      );
    }

    if (result.length == 0) return [];
    return result
        .map<ProgramacionIntervencionesModel>(
            (json) => ProgramacionIntervencionesModel.fromJson(json))
        .toList();
  }

  Future<ProgramacionIntervencionesModel> insertProgramaIntervencion(
    ProgramacionIntervencionesModel o,
  ) async {
    final db = await instance.database;
    if (o.id != null && o.id! > 0) {
      await updateProgramaIntervencion(o);
      return o.copy(id: o.id);
    } else {
      final id = await db.insert(
        tableNameProgramacionIntervenciones,
        o.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return o.copy(id: id);
    }
  }

  Future<int> updateProgramaIntervencion(
    ProgramacionIntervencionesModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameProgramacionIntervenciones,
      o.toJson(),
      where: '${ProgramacionIntervencionesFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<RegistroEntidadActividadModel> insertRegistroEntidadActividad(
    RegistroEntidadActividadModel o,
  ) async {
    final db = await instance.database;
    if (o.id != null && o.id! > 0) {
      await updateRegistroEntidadActividad(o);
      return o.copy(id: o.id);
    } else {
      final id = await db.insert(
        tableNameRegistroEntidadActividad,
        o.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return o.copy(id: id);
    }
  }

  Future<List<RegistroEntidadActividadModel>>
      insertRegistroEntidadActividadMasive(
    List<RegistroEntidadActividadModel> a,
  ) async {
    var result = await insertMasive(
        tableNameRegistroEntidadActividad, a, RegistroEntidadActividadFields);

    return result
        .map<RegistroEntidadActividadModel>(
            (json) => RegistroEntidadActividadModel.fromJson(json))
        .toList();
  }

  Future<int> updateRegistroEntidadActividad(
    RegistroEntidadActividadModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameRegistroEntidadActividad,
      o.toJson(),
      where: '${RegistroEntidadActividadFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<List<dynamic>> insertMasive(
    String table,
    List<dynamic> aObject,
    dynamic oFiel,
  ) async {
    List<dynamic> listRes = [];

    final db = await instance.database;
    await db.transaction((txn) async {
      aObject.forEach((o) async {
        if (o.id != null && o.id! > 0) {
          txn.update(
            table,
            o.toJson(),
            where: '${oFiel.id} = ?',
            whereArgs: [o.id],
          );
          var iRes = o.copy(id: o.id);
          listRes.add(iRes);
        } else {
          var iRes = await txn.insert(
            table,
            o.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          listRes.add(iRes);
        }
      });
    });

    return listRes;
  }

  Future close() async {
    /**
     extends State<NotesPage> { ...
     @override
      void dispose() {
        DatabasePnPais.instance.close();
        Get.delete<MainController>();
        super.dispose();
      }
     */
    final db = await instance.database;
    db.close();
  }
}
