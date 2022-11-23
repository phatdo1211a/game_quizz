import 'package:flutter/material.dart';

Widget text_quizz(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 40),
      children: const <TextSpan>[
        TextSpan(
          text: 'Quizz',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
        ),
        TextSpan(text: 'Game',
        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.blue),),
      ], 
    ),
  );
}