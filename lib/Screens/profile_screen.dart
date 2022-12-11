import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/object/profile_object.dart';
import 'package:game_quizz/provider/profie_provider.dart';

class Profile extends StatefulWidget {
  String email;
  Profile({Key? key, required this.email}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState(email: email);
}

class _ProfileState extends State<Profile> {
  String email;
  _ProfileState({Key? key, required this.email});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProfileObject>>(
        future: ProfileProvider.getUsers(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProfileObject> thongTin = snapshot.data!;
            final users = FirebaseAuth.instance.currentUser;
            return Scaffold(
              backgroundColor: Colors.green,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_960_720.png',
                                scale: 20),
                            radius: 40.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          thongTin[0].name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          thongTin[0].phone,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.yellow,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          thongTin[0].email,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.yellow,
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Text('');
        });
  }
}
