import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
//import 'package:actividades_pais/objectbox.g.dart';
//import 'package:objectbox/objectbox.dart';

/**
 * See: https://www.youtube.com/watch?v=AxYbdriXKI8
 * Doc/Lib : https://pub.dev/packages/objectbox/example
 */
class ObjectBoxDbPnPais {
  /*
  late final Store _store;
  late final Box<UserModel> _userBox;

  ObjectBoxDbPnPais._init(this._store) {
    _userBox = Box<UserModel>(_store);
  }

  static Future<ObjectBoxDbPnPais> init() async {
    final store = await openStore();
    return ObjectBoxDbPnPais._init(store);
  }

  Stream<List<UserModel>> getUsers() => _userBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  UserModel? getUser(int id) => _userBox.get(id);
  int? insertUser(UserModel o) => _userBox.put(o);
  bool? removetUser(int id) => _userBox.remove(id);
*/
}

/**
  late Stream<List<UserModel>> streamUsers;
  streamUsers = ObjectBoxDbPnPais.getUsers();
 */
