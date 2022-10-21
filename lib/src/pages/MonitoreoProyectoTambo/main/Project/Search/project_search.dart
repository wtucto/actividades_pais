import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/MonitoreoProyectoTambo/main/Project/ListView/list_view_Projectos.dart';
import 'package:flutter/material.dart';

class ProjectSearchDelegate extends SearchDelegate<String> {
  List<TramaProyectoModel> searchaProyecto;
  ProjectSearchDelegate(this.searchaProyecto);
  final List<int> _data =
      List<int>.generate(100001, (int i) => i).reversed.toList();

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
    List<String> matchQuery = [];
    for (var item in searchaProyecto) {
      if ((item.cui!).contains(query.toLowerCase()) ||
          (item.tambo!).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add('${item.cui} - ${item.tambo}');
      }
    }
    if (query.isEmpty || matchQuery.isEmpty) {
      return buildNoSuggestions();
    } else {
      return buildSuggestionsSuccess(matchQuery);
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    final String searched = query;

    if (searched == null || !_data.contains(searched)) {
      final splitted = searched.split(' - ');
      for (var item in searchaProyecto) {
        if (item.cui == splitted[0]) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListViewProjet(context: context, oProyecto: item);
            },
          );
        }
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

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            onTap: () {
              query = suggestion;
              showResults(context);
            },
            leading: const Icon(Icons.search),
            title: RichText(
              text: TextSpan(
                text: suggestion,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      );
}
