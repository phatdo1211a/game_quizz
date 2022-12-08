
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_quizz/object/chu_de_object.dart';

class ChuDeProvider {
    static Future<List<ChuDeObject>> getDataById() async {
     List<ChuDeObject> chuDe =[];
      QuerySnapshot snapshot;
          snapshot = await FirebaseFirestore.instance.collection('chude')
              .get();
         chuDe = snapshot.docs.map((json) => ChuDeObject.fromJson(json.data()as Map<String, dynamic>)).toList(); 
  return chuDe;
  }
}