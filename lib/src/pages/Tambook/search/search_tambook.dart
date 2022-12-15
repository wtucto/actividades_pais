import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/backend/model/listar_usuarios_app_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/ListView/list_view_Projectos.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _prefs;

class SearchTambookDelegate extends SearchDelegate<String> {
  SearchTambookDelegate();
  MainController mainController = MainController();

  List<TramaProyectoModel> aProyecto = [];
  Future<List<TramaProyectoModel>> getProyectos(String search) async {
    _prefs = await SharedPreferences.getInstance();
    UserModel oUser = UserModel(
      nombres: _prefs!.getString('nombres') ?? '',
      codigo: _prefs!.getString('codigo') ?? '',
      rol: _prefs!.getString('rol') ?? '',
    );
    aProyecto = await mainController.getAllProyectoByUserSearch(
      oUser,
      search,
      0,
      0,
    );

    return aProyecto;
  }

  @override
  String get searchFieldLabel => 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, '');
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return buildNoSuggestions();
    } else {
      return FutureBuilder(
        future: getProyectos(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (query.isEmpty || aProyecto.isEmpty) {
              return buildNoSuggestions();
            } else {
              return buildSuggestionsSuccess(aProyecto);
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty || aProyecto.isNotEmpty) {
      for (var item in aProyecto) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListViewProjet(context: context, oProyecto: item);
          },
        );
      }
    }
    return buildNoSuggestions();
  }

  Widget buildNoSuggestions() => const Center(
        child: Text(
          '¡No hay sugerencias!',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );

  Widget buildSuggestionsSuccess(List<TramaProyectoModel> suggestions) =>
      ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index].tambo.toString();
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Colors.black12,
            ),
            width: double.infinity,
            // height: 120,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    margin: const EdgeInsets.only(right: 15),
                    child: Image.network(
                        'https://www.pais.gob.pe/sismonitor/FILES/usuarios/6234/perfil/thumbnail/6234_200x200.jpg'),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Tambo: SOLEDAD",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Gestor: JULIO CÉSAR TAMINCHE LLAMO",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Departamento: AMAZONAS",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
          // return ListTile(
          //   onTap: () {
          //     query = suggestion;
          //     showResults(context);
          //   },
          //   leading: const Icon(Icons.search),
          //   title: RichText(
          //     text: TextSpan(
          //       text: suggestion,
          //       style: const TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 18,
          //       ),
          //     ),
          //   ),
          // );
        },
      );
}
