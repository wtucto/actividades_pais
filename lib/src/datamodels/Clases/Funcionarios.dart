class ListaFuncionarios {
  List<Funcionarios> items = [];

  ListaFuncionarios();

  ListaFuncionarios.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final _listarTrabajador = new Funcionarios.fromJson(item);
      items.add(_listarTrabajador);
    }
  }
}

class Funcionarios {
  int idProgramacion;
  String cargo;
  String telefono;
  String nombres;
  String apellidoPaterno;
  String apellidoMaterno;
  String  dni;
  String ubigeoCcpp;
  int idActividad;
  int idEntidad;
  String numDocExtranjero;
  int idPais;
  int idTipoDocumento;
  String tipoDocumento;
  String nombreCargo;
  int idUsuario;
  String txtIpmaq;

  int id;
  String flgReniec;
  String tipo; //funcionario EX o peruano
  // String documento; //doc funcionario ex
  //String dni;
  String pais;

  // String nombre;
  // String apePaterno;
  // String apellidoMaterno;
  String datos;
  String entidad;

  //String cargo;
  int estado;
  String estado_registro="";
  Funcionarios(
      {this.id = 0,
      this.flgReniec = '',
      this.tipo = '',
      this.dni = '',
      this.pais = '',
      this.datos = '',
      this.entidad = '',
      this.nombreCargo = '',
      this.telefono = '',
      this.apellidoMaterno = '',
      this.nombres = '',
      this.apellidoPaterno = '',
      this.idProgramacion = 0,
      this.cargo = '',
      this.estado = 0,
      this.idActividad = 0,
      this.idEntidad = 0,
      this.idPais = 0,
      this.idTipoDocumento = 0,
      this.idUsuario = 0,
      this.numDocExtranjero = '',
      this.txtIpmaq = '',
      this.ubigeoCcpp = '',
      this.tipoDocumento = '', this.estado_registro =""});

  factory Funcionarios.fromJson(Map<String, dynamic> json) {
    return Funcionarios(
        estado: json['estado']??0,
        id: json['id']??0,
        flgReniec: json['flgReniec']??'',
        tipo: json['tipo']??'',
        dni: json['dni']??'',
        pais: json['pais']??'',
        datos: json['datos']??'',
        entidad: json['entidad']??'',
        nombreCargo: json['nombreCargo']??'',
        telefono: json['telefono']??'',
        apellidoPaterno: json['apellidoPaterno']??'',
        nombres: json['nombres']??'',
        apellidoMaterno: json['apellidoMaterno']??'',
        idProgramacion: json['idProgramacion']??0,
        cargo: json['cargo']??'',
        idActividad: json['idActividad']??0,
        idEntidad: json['idEntidad']??0,
        idPais: json['idPais']??0,
        idTipoDocumento: json['idTipoDocumento']??0,
        tipoDocumento: json['tipoDocumento']??'',
        idUsuario: json['idUsuario']??0,
        numDocExtranjero: json['numDocExtranjero']??'',
        txtIpmaq: json['txtIpmaq']??'',
        ubigeoCcpp: json['ubigeoCcpp']??'');
  }

  factory Funcionarios.fromJsonReniec(Map<String, dynamic> json) {
    return Funcionarios(
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      nombres: json['nombres'],
      dni: json['dni'],
    );
  }

  factory Funcionarios.fromMap(Map<String, dynamic> json) {
    return Funcionarios(
      id: json['id'],
      estado: json['estado'],
      flgReniec: json['flgReniec'],
      tipo: json['tipo'],
      dni: json['dni'],
      pais: json['pais'],
      datos: json['datos'],
      entidad: json['entidad'],
      nombreCargo: json['nombreCargo'],
      telefono: json['telefono'],
      apellidoPaterno: json['apellidoPaterno'],
      nombres: json['nombres'],
      apellidoMaterno: json['apellidoMaterno'],
      idProgramacion: json['idProgramacion'],
      cargo: json['cargo'],
      idActividad: json['idActividad'],
      idEntidad: json['idEntidad'],
      idPais: json['idPais'],
      idTipoDocumento: json['idTipoDocumento'],
      tipoDocumento: json['tipoDocumento'],
      idUsuario: json['idUsuario'],
      numDocExtranjero: json['numDocExtranjero'],
      txtIpmaq: json['txtIpmaq'],
      ubigeoCcpp: json['ubigeoCcpp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flgReniec'] = this.flgReniec;
    data['tipo'] = this.tipo;
    data['dni'] = this.dni;
    data['pais'] = this.pais;
    data['datos'] = this.datos;
    data['entidad'] = this.entidad;
    data['nombreCargo'] = this.nombreCargo;
    data['telefono'] = this.telefono;
    data['apellidoPaterno'] = this.apellidoPaterno;
    data['apellidoMaterno'] = this.apellidoMaterno;
    data['nombres'] = this.nombres;
    data['idProgramacion'] = this.idProgramacion;
    data['idProgramacion'] = idProgramacion;
    data['cargo'] = cargo;
    data['idActividad'] = idActividad;
    data['idEntidad'] = idEntidad;
    data['idPais'] = idPais;
    data['idTipoDocumento'] = idTipoDocumento;
    data['tipoDocumento'] = tipoDocumento;
    data['idUsuario'] = idUsuario;
    data['numDocExtranjero'] = numDocExtranjero;
    data['txtIpmaq'] = txtIpmaq;
    data['ubigeoCcpp'] = ubigeoCcpp;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      ///  "id": id,
      "estado": estado,
      "flgReniec": flgReniec,
      "tipo": tipo,
      "dni": dni,
      "pais": pais,
      "datos": datos,
      "entidad": entidad,
      "nombreCargo": nombreCargo,
      "telefono": telefono,
      "apellidoPaterno": apellidoPaterno,
      "nombres": nombres,
      "apellidoMaterno": apellidoMaterno,
      "idProgramacion": idProgramacion,
      "cargo": cargo,
      "idActividad": idActividad,
      "idEntidad": idEntidad,
      "idPais": idPais,
      "idTipoDocumento": idTipoDocumento,
      "tipoDocumento": tipoDocumento,
      "idUsuario": idUsuario,
      "numDocExtranjero": numDocExtranjero,
      "txtIpmaq": txtIpmaq,
      "ubigeoCcpp": ubigeoCcpp,
    };
  }
}
