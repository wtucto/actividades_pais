import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntervencionCreate extends StatefulWidget {
  const IntervencionCreate({super.key});

  @override
  State<IntervencionCreate> createState() => _IntervencionCreateState();
}

class _IntervencionCreateState extends State<IntervencionCreate> {
  final _formKey = GlobalKey<FormState>();
  bool? _chekIPOtambo = false;
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "INTERVENCION",
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
          padding: const EdgeInsets.all(10.0),
          children: [
            CheckboxListTile(
              value: _chekIPOtambo,
              title: const Text("PROGRAMA PARA OTRO TAMBO"),
              onChanged: (val) {
                setState(() {
                  _chekIPOtambo = val!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }
}
