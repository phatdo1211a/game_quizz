import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/screens/home.dart';
import 'package:game_quizz/screens/nextpage.dart';
import 'package:game_quizz/screens/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:game_quizz/play/components/customStartButton.dart';
import 'package:game_quizz/provider/google_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'Register.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _input(context),
              _signup(context),
              //_stream(context),
            ],
          ),
        ),
      ),
    );
  }
}

_stream(context) {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Something Went Wrong'),
          );
        } else {
          return Register();
        }
      });
}

_input(context) {
  const edgeInsets = EdgeInsets.all(15);
  return Container(
    padding: edgeInsets,
    child: Column(
      children: [
        Image.asset(
          "assets/image.png",
          width: 100,
          height: 100,
        ),
        text_quizz(context),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: "Tên đăng nhập",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Mật khẩu",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.key),
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
            onPressed: () {
              nextpage(context,HomeScreen());
            },
            child: Text(
              "Đăng nhập",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(200, 60),
              shape: StadiumBorder(),
              padding: edgeInsets,
            )),
        SizedBox(height: 20),
        Center(child: Text ('OR'),),
        Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SignInButton(
                
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin(context);
                },
              )),
        ),
        SizedBox(
          height: 20,
        ),
        // StreamBuilder(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator());
        //       } else if (snapshot.hasData) {
        //         return HomeScreen();
        //       } else if (snapshot.hasError) {
        //         return Center(
        //           child: Text('Something Went Wrong'),
        //         );
        //       } else {
        //         return Register();
        //       }
        //     }),
      ],
    ),
  );
}

_signup(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Bạn chưa có tài khoản? ",
        style: TextStyle(color: Colors.black54, fontSize: 20),
      ),
      TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            "Đăng kí",
            style: TextStyle(fontSize: 20),
          ))
    ],
  );
}
