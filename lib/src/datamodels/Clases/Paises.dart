class ListarPaises {
  List<Paises> items = [];
  ListarPaises();
  ListarPaises.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Paises.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class Paises {
  int idPais;
  String paisNombre;

  Paises({this.idPais = 0, this.paisNombre = ''});

  factory Paises.fromJson(Map<String, dynamic> json) {
    return Paises(idPais: json['id_pais']??0, paisNombre: json['pais_nombre']??'');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pais'] = this.idPais;
    data['pais_nombre'] = this.paisNombre;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "id_pais": idPais,
      "pais_nombre": paisNombre,
    };
  }
}
