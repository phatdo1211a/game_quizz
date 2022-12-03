import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/home.dart';

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInProvider();
  var firebaseUser = FirebaseAuth.instance.currentUser;
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
        var a = await FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser?.uid)
            .get();

        if (a.exists) {
          final DocumentReference documentReference = FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseUser?.uid);
          return await documentReference.update({
            'email': googleUser.email,
            'phone': '0385938943', 
            'name': googleUser.displayName
          });
        } else {
          FirebaseFirestore.instance.collection("users").add({
            'email': googleUser.email,
            'phone': '0839887334',
            'name': googleUser.displayName,
          });
        }

        // if (googleAuth.idToken != null) {
        //   FirebaseFirestore.instance
        //       .collection("users")
        //       .doc(firebaseUser?.uid)
        //       .update({
        //     'email': googleUser.email,
        //     'phone': '0978776',
        //     'name': googleUser.displayName,
        //   });
        // } else {
        //   FirebaseFirestore.instance.collection("users").add({
        //     'email': googleUser.email,
        //     'phone': '0839887334',
        //     'name': googleUser.displayName,
        //   });
        // }

      } catch (e) {
        print("failed login!");
      }
    }
  }

  Future googleLogout(context) async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
