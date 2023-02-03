class TramaIntervenciones {
  List<TramaIntervencion> items = [];
  TramaIntervenciones();
  TramaIntervenciones.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new TramaIntervencion.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class TramaIntervencion {
  String? codigoIntervencion;
  String? codigoInterno;
  String? snip;
  String? idDepartamento;
  String? departamento;
  String? provincia;
  String? distrito;
  String? tambo;
  String? tipoIntervencion;
  String? identificacionIntervencion;
  String? fecha;
  String? horaInicio;
  String? horaFin;
  String? lugarIntervencion;
  String? tipoGobierno;
  String? sector;
  String? programa;
  String? categoria;
  String? subCategoria;
  String? poblacion;
  String? atencion;
  String? estado;
  String? fechaRegistro;
  String? tipoActividad;
  String? servicio;
  String? beneficiario;
  String? descripcionEvento;
  int? estadoAppMovil;
  String? idTipoIntervencion;

  TramaIntervencion(
      {this.codigoIntervencion,
      this.codigoInterno,
      this.snip,
      this.idDepartamento,
      this.departamento,
      this.provincia,
      this.distrito,
      this.tambo,
      this.tipoIntervencion,
      this.identificacionIntervencion,
      this.fecha,
      this.horaInicio,
      this.horaFin,
      this.lugarIntervencion,
      this.tipoGobierno,
      this.sector,
      this.programa,
      this.categoria,
      this.subCategoria,
      this.poblacion,
      this.atencion,
      this.estado,
      this.fechaRegistro,
      this.tipoActividad,
      this.servicio,
      this.beneficiario,
      this.descripcionEvento,
        this.estadoAppMovil=0,
        this.idTipoIntervencion=""
      });

  TramaIntervencion.fromJson(Map<String, dynamic> json) {
    codigoIntervencion = json['codigoIntervencion'] ;
    codigoInterno = json['codigoInterno'];
    snip = json['snip'];
    idDepartamento = json['id_departamento'];
    departamento = json['departamento'];
    provincia = json['provincia'];
    distrito = json['distrito'];
    tambo = json['tambo'];
    tipoIntervencion = json['tipoIntervencion'];
    identificacionIntervencion = json['identificacionIntervencion'];
    fecha = json['fecha'];
    horaInicio = json['horaInicio'];
    horaFin = json['horaFin'];
    lugarIntervencion = json['lugarIntervencion'];
    tipoGobierno = json['tipoGobierno'];
    sector = json['sector'];
    programa = json['programa'];
    categoria = json['categoria'];
    subCategoria = json['subCategoria'];
    poblacion = json['poblacion'];
    atencion = json['atencion'];
    estado = json['estado'];
    fechaRegistro = json['fechaRegistro'];
    tipoActividad = json['tipoActividad'];
    servicio = json['servicio'];
    beneficiario = json['beneficiario'];
    descripcionEvento = json['descripcion_evento'];
    estadoAppMovil = json['estadoAppMovil'];
    idTipoIntervencion = json['idTipoIntervencion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['codigoIntervencion'] = this.codigoIntervencion;
    data['codigoInterno'] = this.codigoInterno;
    data['snip'] = this.snip;
    data['id_departamento'] = this.idDepartamento;
    data['departamento'] = this.departamento;
    data['provincia'] = this.provincia;
    data['distrito'] = this.distrito;
    data['tambo'] = this.tambo;
    data['tipoIntervencion'] = this.tipoIntervencion;
    data['identificacionIntervencion'] = this.identificacionIntervencion;
    data['fecha'] = this.fecha;
    data['horaInicio'] = this.horaInicio;
    data['horaFin'] = this.horaFin;
    data['lugarIntervencion'] = this.lugarIntervencion;
    data['tipoGobierno'] = this.tipoGobierno;
    data['sector'] = this.sector;
    data['programa'] = this.programa;
    data['categoria'] = this.categoria;
    data['subCategoria'] = this.subCategoria;
    data['poblacion'] = this.poblacion;
    data['atencion'] = this.atencion;
    data['estado'] = this.estado;
    data['fechaRegistro'] = this.fechaRegistro;
    data['tipoActividad'] = this.tipoActividad;
    data['servicio'] = this.servicio;
    data['beneficiario'] = this.beneficiario;
    data['descripcion_evento'] = this.descripcionEvento;
    data['estadoAppMovil'] = this.estadoAppMovil;
    data['idTipoIntervencion'] = this.idTipoIntervencion;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "codigoIntervencion": codigoIntervencion,
      "codigoInterno": codigoInterno,
      "snip": snip,
      "id_departamento": idDepartamento,
      "departamento": departamento,
      "provincia": provincia,
      "distrito": distrito,
      "tambo": tambo,
      "tipoIntervencion": tipoIntervencion,
      "identificacionIntervencion": identificacionIntervencion,
      "fecha": fecha,
      "horaInicio": horaInicio,
      "horaFin": horaFin,
      "lugarIntervencion": lugarIntervencion,
      "tipoGobierno": tipoGobierno,
      "sector": sector,
      "servicio": servicio,
      "programa": programa,
      "categoria": categoria,
      "subCategoria": subCategoria,
      "poblacion": poblacion,
      "atencion": atencion,
      "estado": estado,
      "fechaRegistro": fechaRegistro,
      "tipoActividad": tipoActividad,
      "beneficiario": beneficiario,
      "descripcion_evento": descripcionEvento,
      "estadoAppMovil": estadoAppMovil,
      "idTipoIntervencion": idTipoIntervencion,
    };
  }

  factory TramaIntervencion.fromMap(Map<String, dynamic> json) =>
      TramaIntervencion(
        codigoIntervencion: json['codigoIntervencion'],
        codigoInterno: json['codigoInterno'],
        snip: json['snip'],
        idDepartamento: json['id_departamento'],
        departamento: json['departamento'],
        provincia: json['provincia'],
        distrito: json['distrito'],
        tambo: json['tambo'],
        tipoIntervencion: json['tipoIntervencion'],
        identificacionIntervencion: json['identificacionIntervencion'],
        fecha: json['fecha'],
        horaInicio: json['horaInicio'],
        horaFin: json['horaFin'],
        lugarIntervencion: json['lugarIntervencion'],
        tipoGobierno: json['tipoGobierno'],
        sector: json['sector'],
        programa: json['programa'],
        categoria: json['categoria'],
        subCategoria: json['subCategoria'],
        poblacion: json['poblacion'],
        atencion: json['atencion'],
        estado: json['estado'],
        fechaRegistro: json['fechaRegistro'],
        tipoActividad: json['tipoActividad'],
        servicio: json['servicio'],
        beneficiario: json['beneficiario'],
        descripcionEvento: json['descripcion_evento'],
        estadoAppMovil: json['estadoAppMovil'],
        idTipoIntervencion: json['idTipoIntervencion'],
      );
}
