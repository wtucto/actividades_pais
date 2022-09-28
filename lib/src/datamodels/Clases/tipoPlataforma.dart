
class TipoPlataformas {
  List<TipoPlataforma> items = [];
  TipoPlataformas();
  TipoPlataformas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new TipoPlataforma.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}


class TipoPlataforma{
int? id;
String? cod;
String? descripcion;

TipoPlataforma({this.id,this.cod, this.descripcion});
TipoPlataforma.fromJson(Map<String, dynamic> json) {

  id = json['id'];
  cod = json['cod'];
  descripcion = json['descripcion'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['cod'] = this.cod;
  data['descripcion'] = this.descripcion;
  return data;
}

factory TipoPlataforma.fromMap(Map<String, dynamic> json) => TipoPlataforma(
  id: json['id'],
  cod: json['cod'],
  descripcion: json['descripcion'],
);
Map<String, dynamic> toMap() {
  return {
    "cod": cod,
    "descripcion": descripcion,
  };
}}