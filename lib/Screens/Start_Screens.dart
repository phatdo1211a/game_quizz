import 'package:flutter/material.dart';
import 'package:game_quizz/screens/login.dart';
import 'package:game_quizz/screens/widgets.dart';
import 'package:game_quizz/main.dart';

import '../play/components/customStartButton.dart';

const edgeInsets = EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0);

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: text_quizz(context),
                ),
                SizedBox(height: 60,),
                // Logo image
                Image.asset(
                  'assets/image.png',
                  width: 300,
                  height: 300,
                ),
                 SizedBox(height: 60,),
                // Start button
                customStartButton(context: context),
              ],
            ),
          ),
        ));
  }
}
