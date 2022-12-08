import 'package:cloud_firestore/cloud_firestore.dart';
import '../object/cau_hoi_object.dart';

class CauHoiProvider {
    static Future<List<CauHoiObject>> getDataById(int id) async {
     List<CauHoiObject> cauHoi =[];
      QuerySnapshot snapshot;
          snapshot = await FirebaseFirestore.instance.collection('cau_hoi')
              .where('id_chu_de', isEqualTo: id)
              .get();
          cauHoi = snapshot.docs.map((json) => CauHoiObject.fromJson(json.data()as Map<String, dynamic>)).toList(); 
    return cauHoi;
  }
}