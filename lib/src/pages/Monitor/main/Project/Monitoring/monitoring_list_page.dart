import 'dart:convert';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_list_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/project_detail_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_detail_new_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:actividades_pais/util/Constants.dart';
import 'package:get/get.dart';

class MonitorList extends StatefulWidget {
  const MonitorList({Key? key}) : super(key: key);

  @override
  _MonitorListState createState() => _MonitorListState();
}

class _MonitorListState extends State<MonitorList> {
  List<dynamic> jobList = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/Monitor/jobs.json');
    final data = await json.decode(response);

    setState(() {
      jobList = data['jobs'].map((data) => ProjectInfo.fromJson(data)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 12, 124, 205),
        elevation: 0,
        leadingWidth: 20,
        /*
        -- Navigation button
        leading: IconButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade600,
          ),
        ),
        */
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
          )
        ],
        title: Center(
          child: Text(
            'MonitoringListTitle'.tr,
            style: const TextStyle(
              color: const Color(0xfffefefe),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20.0,
            ),
          ),
        ) /*Container(
          height: 45,
          child: TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              filled: true,
              fillColor: Colors.grey.shade200,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              hintText: "Buscar",
              hintStyle: TextStyle(fontSize: 14),
            ),
          ),
        )*/
        ,
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: jobList.length,
          itemBuilder: (context, index) {
            return jobComponent(oProjectInfo: jobList[index]);
          },
        ),
      ),
    );
  }

  jobComponent({required ProjectInfo oProjectInfo}) {
    String experienceLevelColor = "4495FF";
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Chip(
                  label: Text('Cimentación'),
                  backgroundColor: Colors.green,
                  labelStyle: TextStyle(color: Colors.white)),
              Padding(padding: EdgeInsets.all(10.0)),
              Chip(
                  label: Text('Send'.tr),
                  backgroundColor: Color.fromARGB(255, 7, 92, 24),
                  labelStyle: TextStyle(color: Colors.white)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(oProjectInfo.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(oProjectInfo.subTitle,
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
                    builder: (context) => MonitorList(),
                  ));
                },
                child: AnimatedContainer(
                  height: 35,
                  padding: EdgeInsets.all(5),
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      border: new Border.all(
                          color: Color.fromARGB(255, 179, 177, 177),
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200),
                  child: Center(
                    child: Icon(
                      Icons.upload,
                      color: Color.fromARGB(255, 38, 173, 108),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MonitoringDetailNewEditPage(),
                        ));
                      },
                      child: AnimatedContainer(
                        height: 35,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            border: new Border.all(
                                color: Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xff${experienceLevelColor}"))
                                    .withAlpha(20)),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 56, 54, 54),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MonitoringDetailNewEditPage(),
                        ));
                      },
                      child: AnimatedContainer(
                        height: 35,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            border: new Border.all(
                                color: Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xff${experienceLevelColor}"))
                                    .withAlpha(20)),
                        child: Center(
                          child: Icon(
                            Icons.visibility,
                            color: Color.fromARGB(255, 56, 54, 54),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: AnimatedContainer(
                        height: 35,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            border: new Border.all(
                                color: Color.fromARGB(255, 179, 177, 177),
                                width: 1.0,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Color(int.parse("0xff${experienceLevelColor}"))
                                    .withAlpha(20)),
                        child: Center(
                          child: Icon(
                            Icons.recycling,
                            color: Color.fromARGB(255, 173, 52, 48),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Text(
                  oProjectInfo.code,
                  style: TextStyle(
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

class ProjectInfo {
  final String title;
  final String subTitle;
  final String? imageIcon;
  final String code;
  final String? type;

  bool isSelect;

  ProjectInfo(
    this.title,
    this.subTitle,
    this.code,
    this.imageIcon,
    this.type,
    this.isSelect,
  );

  factory ProjectInfo.fromJson(Map<String, dynamic> oProjectInfo) {
    return new ProjectInfo(
      oProjectInfo['title'],
      oProjectInfo['subTitle'],
      oProjectInfo['code'],
      oProjectInfo['imageIcon'],
      oProjectInfo['type'],
      oProjectInfo['isSelect'],
    );
  }
}
