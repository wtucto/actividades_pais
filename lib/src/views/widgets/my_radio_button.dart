import 'package:flutter/material.dart';

enum ProducTypeEnum { Donwloadable, Deliverable }

class MyRadioButton extends StatelessWidget {
  MyRadioButton(
      {Key? key,
      required this.title,
      required this.value,
      required this.producTypeEnum,
      required this.onChanged})
      : super(key: key);

  String title;
  ProducTypeEnum value;
  ProducTypeEnum? producTypeEnum;
  Function(ProducTypeEnum?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RadioListTile<ProducTypeEnum>(
        contentPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        value: value,
        groupValue: producTypeEnum,
        dense: true,
        tileColor: Colors.deepPurple.shade50,
        title: Text(title),
        onChanged: onChanged,
      ),
    );
  }
}
