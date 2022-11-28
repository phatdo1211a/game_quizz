import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/Screens/leaderboard_screen.dart';
import 'package:game_quizz/Screens/nextpage.dart';
import 'package:game_quizz/play/views/questions_page.dart';
import 'package:game_quizz/provider/google_sign_in.dart';
import 'package:game_quizz/screens/quizz_screen.dart';
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
    Item(img: "assets/dialy.png", icon: Icons.sunny_snowing, title: "Địa Lí"),
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 100, 0),
          title: Center(
            child: Text('Home'),
          ),
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
                child:  HeaderBuild(context), //Text('chưa có dữ liệu'),
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
                  setState(() {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogout(context);
                    nextpage(context, LoginApp());
                  });
                },
              ),
            ],
          ),
        ),
        body: cardItem(_currentIndex),
        bottomNavigationBar: Container(
          width: 300,
          height: 200,
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            color: Color.fromARGB(255, 28, 100, 0),
            child: ElevatedButton(
              child: Text(
                'Bảng xếp hạng',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () => nextpage(context, LeaderboardScreen()),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
                backgroundColor: Color.fromARGB(255, 28, 100, 0),
              ),
            ),
          ),
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
    var user = FirebaseAuth.instance.currentUser;
    return user != null
        ? Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 28, 100, 0),
                  ),
                  accountName: Text(user.displayName!),
                  accountEmail: Text(user.email!),
                  currentAccountPicture: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user
                        .photoURL!), //'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_960_720.png', scale: 20),
                    backgroundColor: Color.fromARGB(255, 28, 100, 0),
                  ),
                ),
              ],
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
                    builder: (context) => QuizScreen(),
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
