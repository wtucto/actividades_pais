import 'dart:convert';

final String tableNameUsers = 'listar_usuarios_app';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, isEdit, time, rol, codigo, nombres,
  ];

  static final String id = '_id';
  static final String isEdit = 'isEdit';
  static final String time = 'time';

  static final String rol = 'rol';
  static final String codigo = 'codigo';
  static final String nombres = 'nombres';
}

class UserModel {
  final int? id;
  final DateTime? createdTime;

  final bool isEdit;
  final String codigo;
  final String nombres;
  final String rol;

  const UserModel({
    required this.id,
    required this.isEdit,
    required this.rol,
    required this.codigo,
    required this.nombres,
    required this.createdTime,
  });

  UserModel copy({
    int? id,
    bool? isEdit,
    String? rol,
    String? codigo,
    String? nombres,
    DateTime? createdTime,
  }) =>
      UserModel(
        id: id ?? this.id,
        isEdit: isEdit ?? this.isEdit,
        rol: rol ?? this.rol,
        codigo: codigo ?? this.codigo,
        nombres: nombres ?? this.nombres,
        createdTime: createdTime ?? this.createdTime,
      );

  static UserModel fromJson(Map<String, Object?> json) => UserModel(
        id: json[UserFields.id] as int?,
        isEdit: json[UserFields.isEdit] == 1,
        rol: json[UserFields.rol] as String,
        codigo: json[UserFields.codigo] as String,
        nombres: json[UserFields.nombres] as String,
        createdTime: json[UserFields.time] != null
            ? DateTime.parse(json[UserFields.time] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        //UserFields.id: id,
        UserFields.isEdit: isEdit ? 1 : 0,
        //UserFields.time: createdTime.toIso8601String(),
        UserFields.codigo: codigo,
        UserFields.rol: rol,
        UserFields.nombres: nombres,
      };

  static Map<String, dynamic> toJsonObject(UserModel o) {
    return {
      UserFields.codigo: o.codigo,
      UserFields.rol: o.rol,
      UserFields.nombres: o.nombres,
    };
  }

  static List<Map<String, dynamic>> toJsonArray(List<UserModel> aUser) {
    List<Map<String, dynamic>> aList = [];
    for (var item in aUser) {
      aList.add(UserModel.toJsonObject(item));
    }
    return aList;
  }

  List<UserModel> userFromJson(String sOject) {
    final jsonData = json.decode(sOject);
    return new List<UserModel>.from(jsonData.map((x) => UserModel.fromJson(x)));
  }

  String userToJson(List<UserModel> aUser) {
    final dyn = new List<dynamic>.from(aUser.map((x) => x.toJson()));
    return json.encode(dyn);
  }
}
