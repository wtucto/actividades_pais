import 'dart:ui';

//TokenUsuario token;

class AppConfig {
  static var style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//Vulcano
  // static String urlBackndServicioSeguro = 'http://vulcano.pais.gob.pe:8075';

  static String backendsismonitor =
      'https://www.pais.gob.pe/backendsismonitor/public';

  static String urlBackndServicioSeguro = 'https://backend.pais.gob.pe:8075';

  //static String urlBackndServicioSeguro = 'http://192.168.1.45:8075';
  // static String backendsismonitor =
  //  'http://192.168.1.45/backendsismonitor/public';

  static String urlBackendMovil = 'https://www.pais.gob.pe/';

  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
      // TODO: TOKEN DEL SQLITE
    };
  }
}
