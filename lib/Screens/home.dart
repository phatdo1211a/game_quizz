import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/object/chu_de_object.dart';
import 'package:game_quizz/object/profile_object.dart';
import 'package:game_quizz/provider/chu_de_provider.dart';
import 'package:game_quizz/provider/google_sign_in.dart';
import 'package:game_quizz/screens/leaderboard_screen.dart';
import 'package:game_quizz/screens/nextpage.dart';
import 'package:game_quizz/screens/play_screen.dart';
import 'package:game_quizz/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../provider/profie_provider.dart';
import 'login.dart';

class Item {
  final String? img;
  final IconData? icon;
  final String? title;
  Item({required this.img, required this.icon, required this.title});
}

class HomeScreen extends StatefulWidget {
  String email;
  HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(email: email);
}

class _HomeScreenState extends State<HomeScreen> {
  String email;
  
  _HomeScreenState({Key? key, required this.email});
  int _currentIndex = 0;
  List<ChuDeObject> chuDe=[];
void loadChuDe() async{
  final data= await ChuDeProvider.getDataById();
  setState(() {
      chuDe=data;
  });
}
@override
  void initState() {
    loadChuDe();
    super.initState();
  }
  
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
                  nextpage(context, Profile(email: email));
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
          width: 70,
          height: 90,
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
                fixedSize: Size(200, 50),
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
    return FutureBuilder<List<ProfileObject>>(
        future: ProfileProvider.getUsers(email),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProfileObject> thongTin = snapshot.data!;
            return Scaffold(
              body: user != null
                  ? UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 28, 100, 0),
                      ),
                      accountName: user.displayName == null
                          ? Text(thongTin[0].name)
                          : Text(user.displayName!),
                      accountEmail: Text(user.email!),
                      currentAccountPicture: CircleAvatar(
                        radius: 50,
                        backgroundImage: user.photoURL == null
                            ? NetworkImage(
                                'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_960_720.png',
                                scale: 20)
                            : NetworkImage(user.photoURL!),
                        backgroundColor: Color.fromARGB(255, 28, 100, 0),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          }
          return Text('');
        });
  }

  Widget cardItem(int i) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: chuDe.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              nextpage(context,PlayScreen(email: email, id:chuDe[index].id));
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(child: Image.network(chuDe[index].image.toString())),
                    Text(chuDe[index].chude, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
