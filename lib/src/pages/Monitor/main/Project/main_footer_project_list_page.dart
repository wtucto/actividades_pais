import 'dart:async';

import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_list_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/project_detail_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_detail_new_edit_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MainFooterProjectPage extends StatefulWidget {
  const MainFooterProjectPage({Key? key}) : super(key: key);

  @override
  _MainFooterProjectPageState createState() => _MainFooterProjectPageState();
}

class _MainFooterProjectPageState extends State<MainFooterProjectPage> {
  late final ScrollController _horizontal;
  late final ScrollController _vertical;
  List<TramaProyectoModel> jobList = [];
  MainController mainController = MainController();

  Future<void> readJson() async {
    final List<TramaProyectoModel> response =
        await mainController.getAllProyecto();
    setState(() {
      jobList = response;
    });
  }

  @override
  void initState() {
    super.initState();
    _horizontal = ScrollController();
    _vertical = ScrollController();
    readJson();
  }

  @override
  void dispose() {
    _horizontal.dispose();
    _vertical.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _horizontal,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Center(
            child: Text(
              'ProjectListTitle'.tr,
              style: const TextStyle(
                color: Color(0xfffefefe),
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 18.0,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearch(jobList),
                );
              },
            ),
          ],
        ),
        body: Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: jobList.length,
            itemBuilder: (context, index) {
              //return jobList;
              return ListaProyectos(
                  context: context, listProyecto: jobList[index]);
            },
          ),
        ),
      ),
    );
  }
}

class ListaProyectos extends StatelessWidget {
  const ListaProyectos({
    Key? key,
    required this.context,
    required this.listProyecto,
  }) : super(key: key);

  final BuildContext context;
  final TramaProyectoModel listProyecto;

  @override
  Widget build(BuildContext context) {
    String experienceLevelColor = "4495FF";
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Icon(
                        Icons.content_paste_go_sharp,
                        size: 20.0,
                        color: Colors.brown[900],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listProyecto.tambo,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Text(listProyecto.estado,
                              style: TextStyle(color: Colors.grey[500])),
                        ]),
                  )
                ]),
              ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   // job.isSelect = !job.isSelect;
                  // });
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MonitorList(),
                  ));
                },
                child: AnimatedContainer(
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 179, 177, 177),
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200),
                  child: const Center(
                    child: Icon(
                      Icons.dynamic_feed,
                      color: Color.fromARGB(255, 85, 84, 84),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const MonitoringDetailNewEditPage(),
                        ));
                      },
                      child: AnimatedContainer(
                        height: 35,
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xff${experienceLevelColor}"))
                                    .withAlpha(20)),
                        child: const Center(
                          child: Icon(
                            Icons.add_box,
                            color: Color.fromARGB(255, 56, 54, 54),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProjectDetailPage(),
                        ));
                      },
                      child: AnimatedContainer(
                        height: 35,
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xff${experienceLevelColor}"))
                                    .withAlpha(20)),
                        child: const Center(
                          child: Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 56, 54, 54),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: AnimatedContainer(
                        height: 35,
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 15),
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xff${experienceLevelColor}"))
                                    .withAlpha(20)),
                        child: const Center(
                          child: Icon(
                            Icons.upload,
                            color: Color.fromARGB(255, 38, 173, 108),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  listProyecto.cui,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 13, 0, 255),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomSearch extends SearchDelegate<String> {
  List<TramaProyectoModel> searchJobList;
  CustomSearch(this.searchJobList);
  final List<int> _data =
      List<int>.generate(100001, (int i) => i).reversed.toList();

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
    for (var item in searchJobList) {
      if ((item.cui).contains(query.toLowerCase()) ||
          (item.tambo).toLowerCase().contains(query.toLowerCase())) {
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
      for (var item in searchJobList) {
        if (item.cui == splitted[0]) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListaProyectos(context: context, listProyecto: item);
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
              // 2. Close Search & Return Result
              // close(context, suggestion);
              // 3. Navigate to Result Page
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ResultPage(suggestion),
              //   ),
              // );
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
