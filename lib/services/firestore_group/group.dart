import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/database_keys.dart';
import '../../config/database_path.dart';
import '../../data/model/group/group.dart';

class FirebaseGroupServices {
  Stream<List<GroupModel>> getGroupList(String? phone) {
    return FirebaseFirestore.instance
        .collection(DatabasePath.fireStoreCollectionGroup)
        .where(DatabaseKeys.groupMemberList, arrayContains: phone)
        .orderBy(DatabaseKeys.groupCreation, descending: true)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => GroupModel.fromJson(e.data())).toList());
  }
}
