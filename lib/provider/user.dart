import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../config/database_path.dart';
import '../data/model/user/user.dart';


class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get getUser => _user;

  getUserDetails(String? phone) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection(DatabasePath.fireStoreCollectionUsers)
        .doc(phone)
        .get();

    _user = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    notifyListeners();
    print("provider list $getUser");
  }
}
