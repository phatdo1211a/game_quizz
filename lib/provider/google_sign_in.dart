import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/home.dart';

class GoogleSignInProvider extends ChangeNotifier {
 
  GoogleSignInProvider();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
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
        await FirebaseAuth.instance.signInWithCredential(credential);
        users.add({
          'email': googleUser.email,
          'name': googleUser.displayName,
          'phone': '0123456789'
        });
        print("sign in success");
      } catch (e) {
        print("failed login!");
      }
    }
    notifyListeners();
  }

  Future googleLogout(context) async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
