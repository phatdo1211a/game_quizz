import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/screens/home.dart';
import 'package:game_quizz/screens/nextpage.dart';
import 'package:game_quizz/screens/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:game_quizz/provider/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'register.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPass = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    const edgeInsets = EdgeInsets.fromLTRB(10, 10, 10, 10);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/image.png",
                      width: 100,
                      height: 100,
                    ),
                    text_quizz(context),
                    SizedBox(height: 20),
                    //Email
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: TextField(
                        controller: _txtEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          fillColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          filled: true,
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                    ),
                    //Mật khẩu
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          TextField(
                            obscureText: !_showPass,
                            controller: _txtPass,
                            decoration: InputDecoration(
                              hintText: "Mật khẩu",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              filled: true,
                              prefixIcon: Icon(Icons.password_outlined),
                            ),
                          ),
                          GestureDetector(
                            onTap: inTongleShowPass,
                            child: Text(
                              _showPass ? "ẨN" : "HIỆN",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final _user =
                                await _firebaseAuth.signInWithEmailAndPassword(
                                    email: _txtEmail.text,
                                    password: _txtPass.text);
                            _firebaseAuth.authStateChanges().listen((event) {
                              if (event != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(email: _txtEmail.text,)));
                              } else {
                                final snackBar = SnackBar(
                                    content: Text(
                                        'Email hoặc mật khẩu không đúng!'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            });
                            final snackBar =
                                SnackBar(content: Text('Đăng nhập thành công'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          } catch (e) {
                            final snackBar = SnackBar(
                                content: Text('Lỗi kết nối đến server'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w400),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(400, 55),
                          shape: StadiumBorder(),
                          padding: edgeInsets,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: Divider(
                          color: Colors.blue,
                          thickness: 1,
                        )),
                        Text(
                          "Hoặc",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Divider(
                          color: Colors.blue,
                          thickness: 1,
                        )),
                      ]),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Center(
                        child: SignInButton(
                          Buttons.Google,
                          shape: StadiumBorder(),
                          padding: edgeInsets,
                          text: "Đăng nhập bằng google",
                          onPressed: () {
                            var user = FirebaseAuth.instance.currentUser!;
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.googleLogin(context).then((value) {
                               nextpage(context, HomeScreen(email: user.email!));
                            },);
                                  
                         
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: _signup(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _txtEmail.dispose();
    _txtPass.dispose();
    super.dispose();
  }

  void inTongleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  // _stream(context) {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return CircularProgressIndicator();
  //         } else if (snapshot.hasData) {
  //           return HomeScreen();
  //         } else if (snapshot.hasError) {
  //           return Center(
  //             child: Text('Something Went Wrong'),
  //           );
  //         } else {
  //           return Register();
  //         }
  //       });
  // }

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
                context,
                MaterialPageRoute(
                  builder: (context) => Register(),
                ),
              );
            },
            child: Text(
              "Đăng kí",
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  }
}
