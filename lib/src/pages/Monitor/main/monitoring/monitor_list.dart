import 'package:actividades_pais/src/pages/Monitor/main/monitoring/monitoring_detail_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/monitoring/project_detail_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/monitoring/project_new_page.dart';
import 'package:flutter/material.dart';

class MonitorList extends StatelessWidget {
  MonitorList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de Monitores",
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
      ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: ListView(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, color: Colors.grey.shade300),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Chip(
                          label: Text("Cimentación"),
                          backgroundColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.white)),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Chip(
                          label: Text("Enviado"),
                          backgroundColor: Color.fromARGB(255, 7, 92, 24),
                          labelStyle: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const Text(
                    '04/04/2022',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const Text('8345'),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProjectNewPage(),
                          ));
                        },
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 38, 15, 209),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailMonitore(),
                          ));
                        },
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 148, 49, 49),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, color: Colors.grey.shade300),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Chip(
                          label: Text("Muros y Columnas"),
                          backgroundColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.white)),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Chip(
                          label: Text("Por Enviar"),
                          backgroundColor: Color.fromARGB(255, 136, 178, 43),
                          labelStyle: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const Text(
                    '15/06/2022',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const Text('8346'),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProjectNewPage(),
                          ));
                        },
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 38, 15, 209),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailMonitore(),
                          ));
                        },
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 148, 49, 49),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 148, 49, 49),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProjectDetailPage(),
                          ));
                        },
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.upload,
                          color: Color.fromARGB(255, 35, 133, 70),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, color: Colors.grey.shade300),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Chip(
                          label: Text("Techos y Acabado"),
                          backgroundColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.white)),
                      Padding(padding: EdgeInsets.all(10.0)),
                      Chip(
                          label: Text("Incompleto"),
                          backgroundColor: Color.fromARGB(255, 156, 140, 31),
                          labelStyle: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const Text(
                    '20/10/2022',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const Text('8347'),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProjectNewPage(),
                          ));
                        },
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 38, 15, 209),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailMonitore(),
                          ));
                        },
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 148, 49, 49),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(10.0)),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(primary: Colors.purple),
                        child: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 148, 49, 49),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
