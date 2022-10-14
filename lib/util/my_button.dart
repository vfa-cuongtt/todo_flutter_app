import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final color;
  VoidCallback onPressed;
  MyButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: Text(text),
    );
  }
}
