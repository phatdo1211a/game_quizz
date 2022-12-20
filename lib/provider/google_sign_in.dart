import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
>>>>>>> 47836af7ffdf6154d77ea0259968c8fb3f8f2476
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
 
  GoogleSignInProvider();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
<<<<<<< HEAD

=======
>>>>>>> 47836af7ffdf6154d77ea0259968c8fb3f8f2476
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
<<<<<<< HEAD
        await users.add({
=======
        users.add({
>>>>>>> 47836af7ffdf6154d77ea0259968c8fb3f8f2476
          'email': googleUser.email,
          'name': googleUser.displayName,
          'phone': '0123456789'
        });
<<<<<<< HEAD

        print('sign in success');
=======
        print("sign in success");
>>>>>>> 47836af7ffdf6154d77ea0259968c8fb3f8f2476
      } catch (e) {
        print('failed login!');
      }
    }
    notifyListeners();
  }

  Future googleLogout(context) async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
