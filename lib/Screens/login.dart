import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/play/components/thongbao.dart';
import 'package:game_quizz/screens/home.dart';
import 'package:game_quizz/screens/nextpage.dart';
import 'package:game_quizz/screens/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:game_quizz/provider/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  // var docID;
  // var querySnapshots;
  // CollectionReference user = FirebaseFirestore.instance.collection("users");
  // Future<void> updateUser(var docID) {
  //   return user
  //       .doc(docID)
  //       .update({
  //         'email': _txtEmail.text,
  //       })
  //       .then((value) => Navigator.pop(context, 'Cập nhật thành công'))
  //       .catchError(
  //           (error) => Navigator.pop(context, 'Cập nhật thất bại $error'));
  // }

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
                            child: Icon(
                              !_showPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                                nextpage(
                                    context, HomeScreen(email: _txtEmail.text));
                              }
                            });
                            thongbao("Đăng nhập thành công");
                          } on FirebaseAuthException catch (e) {
                            thongbao(e.message.toString());
                          }
                        },
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w400),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 28, 100, 0),
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
                          color: Color.fromARGB(255, 28, 100, 0),
                          thickness: 1,
                        )),
                        Text(
                          "Hoặc",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Divider(
                          color: Color.fromARGB(255, 28, 100, 0),
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
                          onPressed: () async {
                            final provider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            provider.googleLogin(context).then(
                              (value) {
                                nextpage(
                                    context,
                                    HomeScreen(
                                        email:
                                            _firebaseAuth.currentUser!.email!));
                              },
                            );
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
             nextpage(context, Register());
            },
            child: Text(
              "Đăng kí",
              style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 28, 100, 0)),
              
            ))
      ],
    );
  }
}
