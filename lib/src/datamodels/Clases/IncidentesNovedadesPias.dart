class ListarIncidentesNovedadesPias {
  List<IncidentesNovedadesPias> items = [];

  ListarIncidentesNovedadesPias();

  ListarIncidentesNovedadesPias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new IncidentesNovedadesPias.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class IncidentesNovedadesPias {
  int? id;
  int? tipo;
  String? incidentes = '';
  String? novedades = '';
  String? idUnicoReporte;

  int? idUsuario;
  int? idParteDiario;

  IncidentesNovedadesPias(
      {this.id,
      this.tipo,
      this.incidentes = '',
      this.novedades = '',
      this.idUnicoReporte,
      this.idParteDiario,
      this.idUsuario});

  IncidentesNovedadesPias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tipo = json['tipo'];
    incidentes = json['incidentes'];
    novedades = json['Novedades'];
    idUnicoReporte = json['idUnicoReporte'];
    idUsuario = json['idUsuario'];
    idParteDiario = json['idParteDiario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['incidentes'] = this.incidentes;
    data['novedades'] = this.novedades;
    data['idUnicoReporte'] = this.idUnicoReporte;
    data['idUsuario'] = this.idUsuario;
    data['idParteDiario'] = this.idParteDiario;
    return data;
  }

  factory IncidentesNovedadesPias.fromMap(Map<String, dynamic> json) =>
      IncidentesNovedadesPias(
        id: json['id'],
        tipo: json['tipo'],
        incidentes: json['incidentes'],
        novedades: json['novedades'],
        idUnicoReporte: json['idUnicoReporte'],
        idUsuario: json['idUsuario'],
        idParteDiario: json['idParteDiario'],
      );

  Map<String, dynamic> toMap() {
    return {
      "incidentes": incidentes,
      "novedades": novedades,
      "idUnicoReporte": idUnicoReporte,
      "tipo": tipo,
    };
  }
}
