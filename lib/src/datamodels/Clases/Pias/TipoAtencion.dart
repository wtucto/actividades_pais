class ListaTipoAtencion {
  List<TipoAtencion> items = [];
  ListaTipoAtencion();
  ListaTipoAtencion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new TipoAtencion.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class TipoAtencion {
  int? id;
  String? cod;
  String? descripcion;

  TipoAtencion({this.id,this.cod, this.descripcion});

  TipoAtencion.fromJson(Map<String, dynamic> json) {
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
  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "descripcion": descripcion,
    };
  }
}