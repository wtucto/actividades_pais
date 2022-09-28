import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class utils{
  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));
  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Icon(
        Icons.settings_backup_restore_rounded,
        color: Colors.red[600],
        size: 32,
      ));

  showAlertDialog(titulo, text, BuildContext context, presse) {
    Widget okButton = TextButton(child: Text("OK"), onPressed: presse);

    AlertDialog alert = AlertDialog(
      title: Text(titulo),
      content: Text(text),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}