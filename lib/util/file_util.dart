import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtil {
  File? jsonFile;
  bool fileExists = false;
  Directory? dir;

  /*
    Crear un nuevo archivo
    @Map data : Registros para almacenar
    @Directory dir: Ubicación del archivo
    @String fileName: Nombre del archivo
   */
  void createFile(
    Map<String, String> data,
    Directory dir,
    String fileName,
  ) {
    File file = File("${dir.path}/$fileName");
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(data));
  }

  /*
    Añadir nuevos registros al archivo
    @String storage : Nombre de la tienda
    @String key : Clave
    @String value: Valor
   */
  void writeToDataFile(
    String storage,
    String key,
    String value,
  ) async {
    String fileName = "$storage.json";
    Map<String, String> content = {key: value};
    bool fileExists = await getDocuments(fileName);
    if (fileExists) {
      Map<String, String> oContent = json.decode(jsonFile!.readAsStringSync());
      oContent.addAll(content);
      jsonFile!.writeAsStringSync(json.encode(oContent));
    } else {
      createFile(content, dir!, fileName);
    }
  }

  /*
    Obtener todos los registros del archivo LocalStorage
    @String storage : Nombre de la tienda
    @T: Callback para el retorno de la data y parseo 
   */
  Future<T?> getDataFile<T>(
    String storage,
    T Function(dynamic data)? parser,
  ) async {
    String fileName = "$storage.json";
    bool fileExists = await getDocuments(fileName);
    if (fileExists) {
      String fileEncode = jsonFile!.readAsStringSync();
      return parser!(fileEncode);
    } else {
      createFile(json.decode("[]"), dir!, fileName);
    }

    return parser!(null);
  }

  /*
    Cargar y Obtener todos los registros del archivo LocalStorage
    @String storage : Nombre de la tienda
    @dynamic data: registros para almacenar en el LocalStorage
    @T: Callback para el retorno de la data y parseo 
   */
  Future<T> loadDataFile<T>(
    String storage,
    dynamic data,
    T Function(dynamic data)? parser,
  ) async {
    String fileName = "$storage.json";
    bool fileExists = await getDocuments(fileName);
    if (fileExists) {
      Map<String, String> jsonFileContent = json.decode(data);
      jsonFile!.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      createFile(json.decode(data), dir!, fileName);
    }
    return parser!(data);
  }

  Future<bool> getDocuments(
    String storage,
  ) async {
    String fileName = "$storage.json";
    fileExists = false;
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = File("${dir!.path}/$fileName");
      fileExists = jsonFile!.existsSync();
    });

    return fileExists;
  }
}
