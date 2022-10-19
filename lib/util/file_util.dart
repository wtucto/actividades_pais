import 'dart:convert';
import 'dart:io';

class FileUtil {
  File? jsonFile;
  Directory? dir;
  String fileName = "my]SONFile.json";
  bool fileExists = false;
  Map<String, String> fileContent = {};

  void createFile(Map<String, String> content, Directory dir, String fileName) {
    File file = new File(dir.path + "/" + fileName);

    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value) {
    Map<String, String> content = {key: value};
    if (fileExists) {
      Map<String, String> jsonFileContent =
          json.decode(jsonFile!.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile!.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      createFile(content, dir!, fileName);
    }

    //this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
  }
}
