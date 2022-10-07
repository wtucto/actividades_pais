import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePnPais {
  static final DatabasePnPais instance = DatabasePnPais._init();

  static Database? _database;
  static final _version = 1;

  final insertTable = 'CREATE TABLE';
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT';
  final boolType = 'BOOLEAN';
  final integerType = 'INTEGER';
  final notNull = 'NOT NULL';

  DatabasePnPais._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pnpais.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
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

  Future _insertDB(Database db, int version) async {
    var constFields = '''
      ${TramaMonitoreoFields.id} $idType, 
      ${TramaMonitoreoFields.time} $textType,
      ${TramaMonitoreoFields.isEdit} $boolType $notNull
      ''';

    await db.execute('''
    $insertTable $tableNameUsers ( 
      $constFields,

      ${UserFields.codigo} $textType $notNull,
      ${UserFields.nombres} $textType $notNull,
      ${UserFields.rol} $textType $notNull,
      ${UserFields.clave} $textType
      )
    ''');

    await db.execute('''
    $insertTable $tableNameTramaMonitoreos ( 
      $constFields,

      ${TramaMonitoreoFields.snip} $textType $notNull,
      ${TramaMonitoreoFields.cui} $textType,
      ${TramaMonitoreoFields.latitud} $textType,
      ${TramaMonitoreoFields.longitud} $textType,
      ${TramaMonitoreoFields.tambo} $textType,
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
      ${TramaMonitoreoFields.imgProblema} $textType,
      ${TramaMonitoreoFields.imgRiesgo} $textType,
      ${TramaMonitoreoFields.observaciones} $textType,
      ${TramaMonitoreoFields.problemaIdentificado} $textType,
      ${TramaMonitoreoFields.riesgoIdentificado} $textType,
      ${TramaMonitoreoFields.rol} $textType,
      ${TramaMonitoreoFields.usuario} $textType
      )
    ''');

    await db.execute('''
    $insertTable $tableNameTramaProyectos ( 
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

  Future _upgradeDB(Database db, int oldversion, int newversion) async {
    if (oldversion < newversion) {
      print("Version Upgrade");
    }
  }

  /**
   * TRAMA PROYECTO
   */
  Future<List<TramaProyectoModel>> readAllProyecto() async {
    final db = await instance.database;
    //SELECT * FROM $tableNameTramaProyectos ORDER BY ASC
    final orderBy = '${TramaProyectoFields.numSnip} ASC';
    final result = await db.query(tableNameTramaProyectos, orderBy: orderBy);
    return result.map((json) => TramaProyectoModel.fromJson(json)).toList();
  }

  Future<TramaProyectoModel> readProyecto(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNameTramaProyectos,
      columns: TramaProyectoFields.values,
      where: '${TramaProyectoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TramaProyectoModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<TramaProyectoModel> insertProyecto(TramaProyectoModel o) async {
    final db = await instance.database;
    //INSERT INTO table_name ($columns) VALUES ($values)
    final id = await db.insert(
      tableNameTramaProyectos,
      o.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return o.copy(id: id);
  }

  Future<int> updateProyecto(TramaProyectoModel o) async {
    final db = await instance.database;
    return db.update(
      tableNameTramaProyectos,
      o.toJson(),
      where: '${TramaProyectoFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<int> deleteProyecto(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableNameTramaProyectos,
      where: '${TramaProyectoFields.id} = ?',
      whereArgs: [id],
    );
  }

  /**
   * TRAMA MONITOREO
   */
  Future<List<TramaMonitoreoModel>> readAllMonitoreo() async {
    final db = await instance.database;
    final orderBy = '${TramaMonitoreoFields.snip} ASC';
    final result = await db.query(tableNameTramaMonitoreos, orderBy: orderBy);
    return result.map((json) => TramaMonitoreoModel.fromJson(json)).toList();
  }

  Future<TramaProyectoModel> readMonitoreo(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableNameTramaMonitoreos,
      columns: TramaMonitoreoFields.values,
      where: '${TramaMonitoreoFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TramaProyectoModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<TramaMonitoreoModel> insertMonitoreo(TramaMonitoreoModel o) async {
    final db = await instance.database;
    //INSERT INTO table_name ($columns) VALUES ($values)
    final id = await db.insert(
      tableNameTramaMonitoreos,
      o.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return o.copy(id: id);
  }

  Future<int> updateMonitoreo(TramaMonitoreoModel o) async {
    final db = await instance.database;
    return db.update(
      tableNameTramaMonitoreos,
      o.toJson(),
      where: '${TramaMonitoreoFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<int> deleteMonitoreo(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableNameTramaMonitoreos,
      where: '${TramaMonitoreoFields.id} = ?',
      whereArgs: [id],
    );
  }

  /**
   * USUARIO APP
   */

  Future<List<UserModel>> readAllUser() async {
    final db = await instance.database;

    //SELECT * FROM $tableNameUsers ORDER BY ASC
    final orderBy = '${UserFields.time} ASC';
    final result = await db.query(tableNameUsers, orderBy: orderBy);
    return result.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel> readUser(int id) async {
    //USER => this.user = await DatabasePnPais.instance.readUser(widget.userId);
    final db = await instance.database;
    final maps = await db.query(
      tableNameUsers,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<UserModel>> readEditUser(bool isEdit) async {
    List<UserModel> aResp = [];
    //USER => this.user = await DatabasePnPais.instance.readUser(widget.userId);
    final db = await instance.database;
    final maps = await db.query(
      tableNameUsers,
      columns: UserFields.values,
      where: '${UserFields.isEdit} = ?',
      whereArgs: [isEdit],
    );

    if (maps.isNotEmpty) {
      for (var o in maps) {
        aResp.add(UserModel.fromJson(o));
      }
    } else {
      throw Exception('ID $isEdit not found');
    }

    return aResp;
  }

  Future<UserModel> insertUser(UserModel o) async {
    final db = await instance.database;
    //INSERT INTO table_name ($columns) VALUES ($values)
    final id = await db.insert(
      tableNameUsers,
      o.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return o.copy(id: id);
  }

  Future<int> updateUser(UserModel o) async {
    final db = await instance.database;
    return db.update(
      tableNameUsers,
      o.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [o.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableNameUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    /**
     * extends State<NotesPage> { ...
     @override
      void dispose() {
        DatabasePnPais.instance.close();
        super.dispose();
      }
     */
    final db = await instance.database;
    db.close();
  }
}

/*
late List<Note> users;
bool isLoading = false;
Future refreshNotes() async {
  setState(() => isLoading = true);
  this.users = await DatabasePnPais.instance.readAllUsers();
  setState(() => isLoading = false);
}


void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.user != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final user = widget.user!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await DatabasePnPais.instance.update(user);
  }

  Future addNote() async {
    final user = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      insertdTime: DateTime.now(),
    );

    await DatabasePnPais.instance.insert(user);
  }
  */
