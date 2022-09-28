
class ListasCampanias {
  List<Campania> items = [];
  ListasCampanias();
  ListasCampanias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Campania.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class Campania{
  int id=0;
  String cod='';
  String descripcion='';

  Campania({
    this.id = 0,
    this.cod='',
    this.descripcion='',
  });

  Campania.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cod = json['cod'];
    descripcion = json['descripcion'];}

  Campania.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cod = map['cod'];
    descripcion = map['descripcion'];
  }

  Map<String, dynamic> toMap() {
    return {
      "cod": cod,
      "descripcion": descripcion,
    };
  }
}