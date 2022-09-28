class ListaAtencion {
  List<Atencion> items = [];

  ListaAtencion();

  ListaAtencion.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Atencion.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class Atencion {
  int? id;
  int? atendidos;
  int? atenciones;
  int? idParteDiario;
  int? idUsuario;
  String? tipo;
  String? tipoDescripcion;
  String? idUnicoReporte;

  Atencion(
      {this.id,
      this.tipo,
      this.idUsuario,
      this.tipoDescripcion,
      this.atenciones,
      this.idParteDiario,
      this.atendidos,
      this.idUnicoReporte});

  Atencion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    idUsuario = json['idUsuario'];
    idParteDiario = json['idParteDiario'];
    tipoDescripcion = json['tipoDescripcion'];
    idUnicoReporte = json['idUnicoReporte'];
    atenciones = json['atenciones'];
    atendidos = json['atendidos'];
  }

  factory Atencion.fromMap(Map<String, dynamic> json) => Atencion(
        id: json['id'],
        tipo: json['tipo'],
    idUsuario: json['idUsuario'],
    idParteDiario: json['idParteDiario'],
        tipoDescripcion: json['tipoDescripcion'],
        idUnicoReporte: json['idUnicoReporte'],
        atenciones: json['atenciones'],
        atendidos: json['atendidos'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['idUsuario'] = this.idUsuario;
    data['idParteDiario'] = this.idParteDiario;
    data['tipoDescripcion'] = this.tipoDescripcion;
    data['idUnicoReporte'] = this.idUnicoReporte;
    data['atenciones'] = this.atenciones;
    data['atendidos'] = this.atendidos;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "tipo": tipo,
      "tipoDescripcion": tipoDescripcion,
      "idUnicoReporte": idUnicoReporte,
      "atenciones": atenciones,
      "atendidos": atendidos,
    };
  }
}
