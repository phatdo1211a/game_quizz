import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_quizz/object/profile_object.dart';

class ProfileProvider{
  static Future<List<ProfileObject>> getUsers(String email) async {
    List<ProfileObject> profile = []; 
    final snapshot = await FirebaseFirestore.instance.collection("users")
    .where('email', isEqualTo:email).get();
      profile = snapshot.docs.map((json) => ProfileObject.fromJson(json.data()as Map<String, dynamic>)).toList();
    return profile;
  }
}