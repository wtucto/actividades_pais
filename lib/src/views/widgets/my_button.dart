import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onPress,
    required this.btnText,
  }) : super(key: key);

  final VoidCallback onPress;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(minimumSize: const Size(160, 50)),
        onPressed: onPress,
        child: Text(
          btnText.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.purple),
        ),
      ),
    );
  }
}
