import 'package:flutter/material.dart';

class MyCheckBox extends StatelessWidget {
  MyCheckBox({
    Key? key,
    required this.fieldName,
    required this.checkBoxValue,
    required this.onChange,
  }) : super(key: key);
  String fieldName;
  bool? checkBoxValue;
  Function(bool? val)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.deepPurple.shade50,
          ),
          child: Row(
            children: [
              Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.deepPurple,
                tristate: true,
                value: checkBoxValue,
                onChanged: onChange,
              ),
              Text(
                'To Producto',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
