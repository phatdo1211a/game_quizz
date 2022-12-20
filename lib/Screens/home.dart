import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/object/chu_de_object.dart';
import 'package:game_quizz/object/profile_object.dart';
import 'package:game_quizz/provider/chu_de_provider.dart';
import 'package:game_quizz/provider/profile_provider.dart';
import 'package:game_quizz/screens/leaderboard_screen.dart';
import 'package:game_quizz/screens/nextpage.dart';
import 'package:game_quizz/screens/play_screen.dart';
import 'package:game_quizz/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import 'package:game_quizz/provider/google_sign_in.dart';
import 'package:game_quizz/screens/lich_su_screen.dart';
import 'package:game_quizz/screens/login.dart';

class Item {
  final String? img;
  final IconData? icon;
  final String? title;
  Item({required this.img, required this.icon, required this.title});
}

class HomeScreen extends StatefulWidget {
  String email;
  HomeScreen({super.key, required this.email});

  @override
  _HomeScreenState createState() => _HomeScreenState(email: email);
}

class _HomeScreenState extends State<HomeScreen> {
  String email;

  _HomeScreenState({required this.email});
  int _currentIndex = 0;
  List<ChuDeObject> chuDe = [];
  Future<void> loadChuDe() async {
    final data = await ChuDeProvider.getDataById();
    setState(() {
      chuDe = data;
    });
  }

  @override
  void initState() {
    loadChuDe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 28, 100, 0),
            title: const Center(
              child: Align(
                child: Text('Chủ đề'),
              ),
            ),
            actions: const [Icon(Icons.home_sharp)],
            elevation: 12.0,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 28, 100, 0),
                    ),
                    child: _HeaderBuild(context)),
                ListTile(
                  leading: const Icon(
                    Icons.person_outline,
                  ),
                  title: const Text('Trang cá nhân'),
                  onTap: () {
                    nextpage(context, Profile(email: email));
                  },
                ),
                ListTile(
                  title: const Text('Bảng xếp hạng'),
                  leading: const Icon(
                    Icons.dashboard_outlined,
                  ),
                  onTap: () {
                    nextpage(context, const LeaderboardScreen());
                  },
                ),
                ListTile(
                  title: const Text('Lịch sử chơi'),
                  leading: const Icon(
                    Icons.history_sharp,
                  ),
                  onTap: () {
                    nextpage(context, const LichSuScreen());
                  },
                ),
                ListTile(
                  title: const Text('Đăng xuất'),
                  leading: const Icon(
                    Icons.logout,
                  ),
                  onTap: () {
                    setState(() {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogout(context);
                      nextpage(context, const LoginApp());
                    });
                  },
                ),
              ],
            ),
          ),
          body: cardItem(_currentIndex),
          bottomNavigationBar: Container(
            width: 70,
            height: 90,
            padding: const EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              color: const Color.fromARGB(255, 28, 100, 0),
              child: ElevatedButton(
                onPressed: () => nextpage(context, const LeaderboardScreen()),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  backgroundColor: const Color.fromARGB(255, 28, 100, 0),
                ),
                child: const Text(
                  'Bảng xếp hạng',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ),
      );

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  FutureBuilder<List<ProfileObject>> _HeaderBuild(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return FutureBuilder<List<ProfileObject>>(
        future: ProfileProvider.getUsers(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<ProfileObject> thongTin = snapshot.data!;
            return Scaffold(
              body: user != null
                  ? UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 28, 100, 0),
                      ),
                      accountName: user.displayName == null
                          ? Text(thongTin[0].name)
                          : Text(user.displayName!),
                      accountEmail: Text(user.email!),
                      currentAccountPicture: CircleAvatar(
                        radius: 50,
                        backgroundImage: user.photoURL == null
                            ? const NetworkImage(
                                'https://w7.pngwing.com/pngs/716/486/png-transparent-100-pics-quiz-guess-the-trivia-games-history-quiz-game-quiz-guess-word-quiz-up-2k17-trivia-history-quiz-game-logo-circle-thumbnail.png',
                                scale: 20)
                            : NetworkImage(user.photoURL!),
                        backgroundColor: const Color.fromARGB(255, 28, 100, 0),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          }
          return const Text('');
        });
  }

  Widget cardItem(int i) => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: chuDe.length,
      itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              nextpage(context, PlayScreen(email: email, id: chuDe[index].id));
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Image.network(chuDe[index].image.toString())),
                    Text(
                      chuDe[index].chude,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ));
}
