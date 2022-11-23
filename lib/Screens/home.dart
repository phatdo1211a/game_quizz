import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/screens/Start_Screens.dart';
import 'package:game_quizz/play/views/questions_page.dart';
import 'package:game_quizz/provider/google_sign_in.dart';
import 'package:game_quizz/screens/leader.dart';
import 'package:game_quizz/screens/leaderboard_screen.dart';
import 'package:game_quizz/screens/nextpage.dart';
import 'package:game_quizz/screens/widgets.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Item {
  final String? img;
  final IconData? icon;
  final String? title;
  Item({required this.img, required this.icon, required this.title});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Item> listItem = [
    Item(
        img: "assets/khoahoc.jpg",
        icon: Icons.science_outlined,
        title: "Khoa Học"),
    Item(
        img: "assets/lichsu.jpg",
        icon: Icons.history_rounded,
        title: "Lịch Sử"),
    Item(img: "assets/dialy.png",
         icon: Icons.sunny_snowing, 
         title: "Địa Lí"),
    Item(
        img: "assets/tunhien.png",
        icon: Icons.nature_outlined,
        title: "Tự Nhiên"),
    Item(
        img: "assets/vanhoa.png",
        icon: Icons.other_houses_rounded,
        title: "Văn Hoá"),
    Item(
        img: "assets/thethao.jpg",
        icon: Icons.sports_soccer_outlined,
        title: "Thể Thao")
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 100, 0),
          title: Center(child: Text('Home'),),
          elevation: 4.0,
          actions: const <Widget>[
            Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            )),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: HeaderBuild(context),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 100, 0),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_outline,
                ),
                title: const Text('Trang cá nhân'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Bảng xếp hạng'),
                leading: const Icon(
                  Icons.dashboard_outlined,
                ),
                onTap: () {
                  nextpage(context, LeaderboardScreen());
                },
              ),
              ListTile(
                title: const Text('Cài đặt'),
                leading: const Icon(
                  Icons.settings,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Đăng xuất'),
                leading: const Icon(
                  Icons.logout,
                ),
                onTap: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogout(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginApp()));
                },
              ),
            ],
          ),
        ),
        body: cardItem(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          onTap: ((value) {
            nextpage(context, LeaderboardScreen());
          }),
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: '',
              activeIcon: Leader(),
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget HeaderBuild(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    return user != null? UserAccountsDrawerHeader(
            decoration: BoxDecoration(
               color: Color.fromARGB(255, 28, 100, 0),
            ),
            accountName: Text('${user.displayName!}',),
            accountEmail: Text('${user.email!}'),
            currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL!, scale: 20),
            backgroundColor: Color.fromARGB(255, 28, 100, 0),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget cardItem(int i) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: listItem.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionsPage(),
                  ),
                );
              }
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(child: Image.asset(listItem[index].img!)),
                    Icon(listItem[index].icon),
                    Text(listItem[index].title!),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
