import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class MonitoreoSupervicion extends StatefulWidget {
  const MonitoreoSupervicion({super.key});

  @override
  State<MonitoreoSupervicion> createState() => _MonitoreoSupervicionState();
}

class _MonitoreoSupervicionState extends State<MonitoreoSupervicion> {
  final _formKey = GlobalKey<FormState>();
  final _dateFecha = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "MONITOREO Y SUPER",
            style: TextStyle(
              color: Color(0xfffefefe),
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(
                Icons.integration_instructions_outlined,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
          children: [
            TextFormField(
              controller: _dateFecha,
              validator: (v) => v!.isEmpty ? 'Required'.tr : null,
              decoration: const InputDecoration(
                  labelText: 'Fecha de Monitoreo y Supervición'),
              enabled: true,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  print(formattedDate);

                  setState(() {
                    _dateFecha.text = formattedDate;
                  });
                }
              },
            ),
            /**
             * Tablas
             */
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "REGISTRO DE ACTIVIDADES:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_to_queue),
                  color: const Color.fromARGB(255, 69, 90, 210),
                  onPressed: () async {
                    // await _showMyDialog(
                    //   context,
                    //   "REGISTRO DE ACTIVIDADES",
                    // );
                  },
                  // color: Colors.pink,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  sortColumnIndex: 2,
                  sortAscending: true,
                  headingRowColor: MaterialStateProperty.all(Colors.green[100]),
                  columnSpacing: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  columns: const [
                    DataColumn(label: Text("Tambo")),
                    DataColumn(label: Text("Ubicación")),
                    DataColumn(label: Text("Fecha")),
                    DataColumn(label: Text("Horario")),
                    DataColumn(label: Text("Descripción")),
                  ],
                  rows: const [
                    DataRow(selected: true, cells: [
                      DataCell(Text("Admin")),
                      DataCell(Text("Publico")),
                      DataCell(Text("Alta")),
                      DataCell(Text("Alta")),
                      DataCell(Text("Alta")),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
