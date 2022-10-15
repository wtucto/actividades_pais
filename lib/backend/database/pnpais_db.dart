import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePnPais {
  static final DatabasePnPais instance = DatabasePnPais._init();

  static Database? _database;
  static final _version = 1;

  final createTable = 'CREATE TABLE';
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT';
  final boolType = 'BOOLEAN';
  final integerType = 'INTEGER';
  final notNull = 'NOT NULL';
  final sLimit = "LIMIT [limit]";
  final sOffset = "OFFSET [offset]";

  /*String limitOffset = '$sLimit $sOffset';
    limitOffset = limitOffset.replaceAll("[limit]", "1");
    limitOffset = limitOffset.replaceAll("[offset]", "1");*/

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

    /*var tableNames = (await db
          .query('sqlite_master', where: 'type = ?', whereArgs: ['table']))
      .map((row) => row['name'] as String)
      .toList(growable: false);*/
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });
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

    String sWahere = '';
    if (o.rol == UserModel.sRolRES) {
      sWahere = TramaProyectoFields.codResidente;
    } else if (o.rol == UserModel.sRolSUP) {
      sWahere = TramaProyectoFields.codSupervisor;
    } else if (o.rol == UserModel.sRolCRP) {
      sWahere = TramaProyectoFields.codCrp;
    }

    if (sWahere == '') return [];

    if (limit! > 0) {
      if (search != '') {
        sWahere =
            '$sWahere = ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWahere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWahere = ?',
          whereArgs: [o.codigo],
          orderBy: orderBy,
          limit: limit,
          offset: offset,
        );
      }
    } else {
      if (search != '') {
        sWahere =
            '$sWahere = ? AND ((${TramaProyectoFields.cui} || " " || ${TramaProyectoFields.tambo})  LIKE ?)';
        result = await db.query(
          tableNameTramaProyectos,
          where: sWahere,
          whereArgs: [o.codigo, '%${search.toUpperCase()}%'],
          orderBy: orderBy,
        );
      } else {
        result = await db.query(
          tableNameTramaProyectos,
          where: '$sWahere = ?',
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

  Future<List<TramaProyectoModel>> readAllProyectoByUser(
    UserModel o,
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaProyectoFields.numSnip} ASC';

    dynamic result;

    String sWahere = '';
    if (o.rol == UserModel.sRolRES) {
      sWahere = TramaProyectoFields.codResidente;
    } else if (o.rol == UserModel.sRolSUP) {
      sWahere = TramaProyectoFields.codSupervisor;
    } else if (o.rol == UserModel.sRolCRP) {
      sWahere = TramaProyectoFields.codCrp;
    }

    if (sWahere == '') return [];

    if (limit! > 0) {
      result = await db.query(
        tableNameTramaProyectos,
        where: '$sWahere = ?',
        whereArgs: [o.codigo],
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaProyectos,
        where: '$sWahere = ?',
        whereArgs: [o.codigo],
        orderBy: orderBy,
      );
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

  Future<TramaProyectoModel> readProyectoByIdLoc(
    int i,
  ) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNameTramaProyectos,
      columns: TramaProyectoFields.values,
      where: '${TramaProyectoFields.id} = ?',
      whereArgs: [i],
    );

    if (maps.isNotEmpty) {
      return TramaProyectoModel.fromJson(maps.first);
    } else {
      throw Exception('ID $i not found');
    }
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

  Future<int> updateProyecto(
    TramaProyectoModel o,
  ) async {
    final db = await instance.database;
    return db.update(
      tableNameTramaProyectos,
      o.toJson(),
      where: '${TramaProyectoFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<int> deleteProyecto(
    int i,
  ) async {
    final db = await instance.database;
    return await db.delete(
      tableNameTramaProyectos,
      where: '${TramaProyectoFields.id} = ?',
      whereArgs: [i],
    );
  }

  /// MONITOREO
  Future<List<TramaMonitoreoModel>> readAllMonitoreoPorEnviar(
    int? limit,
    int? offset,
  ) async {
    final db = await instance.database;
    final orderBy = '${TramaMonitoreoFields.idMonitoreo} ASC';

    dynamic result;
    if (limit! > 0) {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: '${TramaMonitoreoFields.estadoMonitoreo} = ?',
        whereArgs: [TramaMonitoreoModel.sEstadoPEN],
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } else {
      result = await db.query(
        tableNameTramaMonitoreos,
        where: '${TramaMonitoreoFields.estadoMonitoreo} = ?',
        whereArgs: [TramaMonitoreoModel.sEstadoPEN],
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

  Future<TramaProyectoModel> readMonitoreo(
    int i,
  ) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNameTramaMonitoreos,
      columns: TramaMonitoreoFields.values,
      where: '${TramaMonitoreoFields.id} = ?',
      whereArgs: [i],
    );

    if (maps.isNotEmpty) {
      return TramaProyectoModel.fromJson(maps.first);
    } else {
      throw Exception('ID $i not found');
    }
  }

  Future<TramaMonitoreoModel> insertMonitoreo(
    TramaMonitoreoModel o,
  ) async {
    final db = await instance.database;
    final id = await db.insert(
      tableNameTramaMonitoreos,
      o.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return o.copy(id: id);
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

    //SELECT * FROM $tableNameUsers ORDER BY ASC
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

  Future<UserModel> readUser(
    int i,
  ) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNameUsers,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [i],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      throw Exception('ID $i not found');
    }
  }

  Future<List<UserModel>> readEditUser(
    bool b,
  ) async {
    List<UserModel> aResp = [];
    final db = await instance.database;
    final maps = await db.query(
      tableNameUsers,
      columns: UserFields.values,
      where: '${UserFields.isEdit} = ?',
      whereArgs: [b],
    );

    if (maps.isNotEmpty) {
      for (var o in maps) {
        aResp.add(UserModel.fromJson(o));
      }
    } else {
      throw Exception('ID $b not found');
    }

    return aResp;
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

  Future<int> deleteUser(
    int i,
  ) async {
    final db = await instance.database;
    return await db.delete(
      tableNameUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [i],
    );
  }

  Future close() async {
    /**
     * extends State<NotesPage> { ...
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
