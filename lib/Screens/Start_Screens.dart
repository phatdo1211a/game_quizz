import 'package:flutter/material.dart';
import 'package:game_quizz/screens/login.dart';
import 'package:game_quizz/screens/widgets.dart';
import 'package:game_quizz/main.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../play/components/customStartButton.dart';

const edgeInsets = EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0);

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 136, 0),
        child: Stack(
          children: [
             CircularParticle(
              width: w,
              height: h,
              particleColor: Colors.white.withOpacity(0.8),
              numberOfParticles: 150,
              speedOfParticles: 1.5,
              maxParticleSize: 7,
              awayRadius: 0,
              onTapAnimation: false,
              isRandSize: true,
              isRandomColor: false,
              connectDots: false,
              enableHover: false,
            ),
            Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: text_quizz(context),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    'assets/image.png',
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  customStartButton(context: context),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
