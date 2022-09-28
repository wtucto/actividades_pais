class ConfigPersonal {
  int numeroDni = 0;
  String nombres = '';
  String apellidoPaterno = '';
  String apellidoMaterno = '';

  String cargo = '';

  ConfigPersonal(
      {this.numeroDni = 0,
      this.nombres = '',
      this.apellidoPaterno = '',
      this.apellidoMaterno = '',
      this.cargo = ''});

  Map<String, dynamic> toMap() {
    return {
      "numeroDni": numeroDni,
      "nombres": nombres,
      "apellidoPaterno": apellidoPaterno,
      "apellidoMaterno": apellidoMaterno,
      "cargo": cargo
    };
  }

  ConfigPersonal.fromMap(Map<String, dynamic> map) {
    numeroDni = map['numeroDni'];
    nombres = map['nombres'];
    apellidoPaterno = map['apellidoPaterno'];
    apellidoMaterno = map['apellidoMaterno'];

    cargo = map['cargo'];
  }
}
