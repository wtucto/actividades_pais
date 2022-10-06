import 'package:actividades_pais/backend/model/listar_trama_monitoreo_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabasePnPais {
  static final DatabasePnPais instance = DatabasePnPais._init();

  static Database? _database;
  static final _version = 1;
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
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableNameUsers ( 
      ${UserFields.id} $idType, 
      ${UserFields.time} $textType,
      ${UserFields.isEdit} $boolType $notNull,

      ${UserFields.codigo} $textType $notNull,
      ${UserFields.nombres} $textType $notNull,
      ${UserFields.rol} $textType $notNull
      )
    ''');

    await db.execute('''
    CREATE TABLE $tableNameMonitoreo ( 
      ${TramaMonitoreoFields.id} $idType, 
      ${TramaMonitoreoFields.isEdit} $boolType $notNull,
      ${TramaMonitoreoFields.time} $textType,

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
   * TRAMA MONITOREO
   */
  Future<List<TramaMonitoreoModel>> readAllMonitoreo() async {
    final db = await instance.database;
    //SELECT * FROM $tableNameMonitoreo ORDER BY ASC
    final orderBy = '${TramaMonitoreoFields.snip} ASC';
    final result = await db.query(tableNameMonitoreo, orderBy: orderBy);
    return result.map((json) => TramaMonitoreoModel.fromJson(json)).toList();
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
    //USER => this.user = await NotesDatabase.instance.readUser(widget.userId);
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

  Future<UserModel> createUser(UserModel user) async {
    final db = await instance.database;
    //INSERT INTO table_name ($columns) VALUES ($values)
    final id = await db.insert(
      tableNameUsers,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user.copy(id: id);
  }

  Future<int> updateUser(UserModel user) async {
    final db = await instance.database;
    return db.update(
      tableNameUsers,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
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
        NotesDatabase.instance.close();
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

    await NotesDatabase.instance.update(user);
  }

  Future addNote() async {
    final user = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(user);
  }
  */
