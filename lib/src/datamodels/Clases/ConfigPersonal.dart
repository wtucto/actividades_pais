class ListasUsuarios {
  List<ConfigPersonal> items = [];

  ListasUsuarios();

  ListasUsuarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new ConfigPersonal.fromJsonSERICIO(item);
      items.add(_listarTrabajador);
    }
  }
}

class ConfigPersonal {
  int numeroDni = 0;
  int id = 0;
  String nombres = '';
  String apellidoPaterno = '';
  String apellidoMaterno = '';
  String contrasenia = '';
  String unidad = '';
  String codigo = '';
  String rol = '';
  String fechaNacimento = '';

  ConfigPersonal({
    this.numeroDni = 0,
    this.id = 0,
    this.nombres = '',
    this.apellidoPaterno = '',
    this.apellidoMaterno = '',
    this.unidad = '',
    this.contrasenia = '',
    this.rol = '',
    this.codigo = '',
    this.fechaNacimento = '',
  });

  Map<String, dynamic> toMap() {
    return {
      "codigo": codigo,
      "nombres": nombres,
      "rol": rol,
      "fechaNacimento": fechaNacimento,
      "numeroDni": numeroDni,
      "contrasenia": contrasenia,
      "apellidoPaterno": apellidoPaterno,
      "apellidoMaterno": apellidoMaterno,
      "unidad": unidad,
    };
  }

  ConfigPersonal.fromJsonSERICIO(Map<String, dynamic> json) {
    nombres = json['nombres'];
    codigo = json['codigo'];
    rol = json['rol'];
  }

  ConfigPersonal.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    numeroDni = map['numeroDni'];
    nombres = map['nombres'];
    apellidoPaterno = map['apellidoPaterno'];
    apellidoMaterno = map['apellidoMaterno'];
    contrasenia = map['contrasenia'];
    unidad = map['unidad'];
    codigo = map['codigo'];
    rol = map['rol'];
  }
}
