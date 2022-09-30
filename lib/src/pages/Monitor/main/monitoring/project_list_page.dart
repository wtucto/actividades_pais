import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:actividades_pais/app_properties.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<dynamic> jobList = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/Monitor/jobs.json');
    final data = await json.decode(response);

    setState(() {
      jobList = data['jobs'].map((data) => Job.fromJson(data)).toList();
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
                  Icons.scatter_plot,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
          )
        ],
        title: Container(
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
        ),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: jobList.length,
          itemBuilder: (context, index) {
            return jobComponent(job: jobList[index]);
          },
        ),
      ),
    );
  }

  jobComponent({required Job job}) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(children: [
                  /*Container(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: job.companyLogo == "" ? Image.asset(job.companyLogo): null,
                      ),
                      ),*/
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(job.title,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(job.company,
                              style: TextStyle(color: Colors.grey[500])),
                        ]),
                  )
                ]),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    job.isSelect = !job.isSelect;
                  });
                },
                child: AnimatedContainer(
                    height: 35,
                    padding: EdgeInsets.all(5),
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade200),
                    child: Center(
                        child: Icon(
                      Icons.dynamic_feed,
                      color: Color.fromARGB(255, 85, 84, 84),
                    ))),
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade200),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 56, 54, 54),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(int.parse("0xff${experienceLevelColor}"))
                              .withAlpha(20)),
                      child: Center(
                        child: Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 56, 54, 54),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  job.code,
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 0, 255),
                    fontSize: 12,
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

class Job {
  final String title;
  final String company;
  //final String? companyLogo;
  final String code;
  final String? type;

  bool isSelect;

  Job(
    this.title,
    this.company,
    this.code,
    //this.companyLogo,
    this.type,
    this.isSelect,
  );

  factory Job.fromJson(Map<String, dynamic> json) {
    return new Job(
        json['title'],
        json['company'],
        json['code'],
        //json['companyLogo'],
        json['type'],
        json['isSelect']);
  }
}
