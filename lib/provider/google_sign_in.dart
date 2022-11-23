import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_quizz/screens/home.dart';
import 'package:game_quizz/screens/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin(context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    if (googleAuth.accessToken != null && googleAuth.idToken != null) {
      try {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
        await FirebaseAuth.instance.signInWithCredential(credential);

        print("sign in success");
      } catch (e) {
        print("failed login!");
      }
    }
    notifyListeners();
  }

  //đăng nhập bằng email
  Future<User?> emailSignin(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw Exception('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      throw Exception('Wrong password provided for that user.');
    }
  }
  return null;
}


  Future googleLogout(context) async {
    await googleSignIn.signOut();
  }
}
