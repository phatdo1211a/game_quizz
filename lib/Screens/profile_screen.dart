import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/object/profile_object.dart';
import 'package:game_quizz/provider/profile_provider.dart';
import 'package:particles_flutter/particles_flutter.dart';

class Profile extends StatefulWidget {
  String email;
  Profile({super.key, required this.email});

  @override
  State<Profile> createState() => _ProfileState(email: email);
}

class _ProfileState extends State<Profile> {
  String email;
  _ProfileState({required this.email});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return FutureBuilder<List<ProfileObject>>(
        future: ProfileProvider.getUsers(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<ProfileObject> thongTin = snapshot.data!;
            return Scaffold(
              backgroundColor: Colors.green,
              body: Stack(
                children: [
                  CircularParticle(
                    width: w,
                    height: h,
                    awayRadius: w / 5,
                    numberOfParticles: 150,
                    speedOfParticles: 1.5,
                    maxParticleSize: 7,
                    particleColor: Colors.white.withOpacity(.7),
                    awayAnimationDuration: const Duration(milliseconds: 600),
                    awayAnimationCurve: Curves.easeInOutBack,
                    isRandSize: true,
                    isRandomColor: false,
                    connectDots: true,
                    // randColorList: [
                    // Colors.red.withAlpha(210),
                    // Colors.white.withAlpha(210),
                    // Colors.yellow.withAlpha(210),
                    // Colors.green.withAlpha(210),
                    // ],
                    enableHover: true,
                    hoverColor: Colors.black,
                    hoverRadius: 90,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Center(
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/image.png'),
                                radius: 40.0,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              thongTin[0].name,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              thongTin[0].phone,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.yellow,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              thongTin[0].email,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Text('');
        });
  }
}
