import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  static Future<QuerySnapshot> getFireStoreCollectionData(
      {required int limit,
      DocumentSnapshot? startAfter,
      String? dataType,
      Query? refData}) async {
    if (startAfter == null) {
      return refData!.get();
    } else {
      return refData!.startAfterDocument(startAfter).get();
    }
  }
}
