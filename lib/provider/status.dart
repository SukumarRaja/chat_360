import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../config/database_keys.dart';
import '../config/database_path.dart';
import '../data/model/joined_user/joined_user.dart';

class StatusProvider extends ChangeNotifier {
  List<JoinedUserModel> joinedUserPhoneStringAsInServer = [];
  bool isLoading = false;
  bool searchingContactsStatus = true;
  List<DocumentSnapshot<dynamic>> contactsStatus = [];

  setIsLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  searchContactStatus(String currentUserPhone,
      List<JoinedUserModel> allJoinedUserPhoneStringAsInServer) async {
    joinedUserPhoneStringAsInServer = allJoinedUserPhoneStringAsInServer;
    notifyListeners();
    debugPrint(
        'SEARCHING STATUS FOR ${joinedUserPhoneStringAsInServer.length} AVAILABLE CONTACTS');
    if (joinedUserPhoneStringAsInServer.isEmpty) {
      searchingContactsStatus = false;
      notifyListeners();
    } else {
      // ignore: avoid_function_literals_in_foreach_calls
      joinedUserPhoneStringAsInServer.forEach((user) async {
        await FirebaseFirestore.instance
            .collection(DatabasePath.fireStoreCollectionStatus)
            .where(DatabaseKeys.phoneVariants,
                arrayContains: user.phone.toString())
            .get()
            .then((docs) {
          if (docs.docs.isNotEmpty) {
            if (docs.docs.isNotEmpty &&
                DateTime.now().isBefore(docs.docs[0]
                    .data()[DatabaseKeys.statusExpiringOn]
                    .toDate()) &&
                docs.docs[0].data()[DatabaseKeys.statusPublishingPhone] !=
                    currentUserPhone &&
                contactsStatus.indexWhere((element) =>
                        element.data()[DatabaseKeys.statusPublishingPhone] ==
                        docs.docs[0]
                            .data()[DatabaseKeys.statusPublishingPhone]) <
                    0) {
              contactsStatus.add(docs.docs[0]);

              if (user.phone == joinedUserPhoneStringAsInServer.last.phone) {
                searchingContactsStatus = false;
                if (contactsStatus.length > 8 && contactsStatus.length < 10) {
                  isLoading = false;
                }
              }
              notifyListeners();
            } else {
              if (user.phone == joinedUserPhoneStringAsInServer.last.phone) {
                searchingContactsStatus = false;
                notifyListeners();
              }
              // if (docs.docs.length == 0) {
              //   if (contactsStatus.contains(docs.docs[0])) {
              //     contactsStatus.remove(docs.docs[0]);
              //     notifyListeners();
              //   }
              // }
            }
          } else {
            if (user.phone == joinedUserPhoneStringAsInServer.last.phone) {
              searchingContactsStatus = false;
              notifyListeners();
            }
            if (docs.docs.isEmpty) {
              int i = contactsStatus.indexWhere((status) =>
                  status[DatabaseKeys.phoneVariants]
                      .contains(user.phone.toString()));
              if (i >= 0) {
                contactsStatus.removeAt(i);
                notifyListeners();
              }
            }
          }
        });
        if (user.phone == joinedUserPhoneStringAsInServer.last.phone) {
          searchingContactsStatus = false;
          notifyListeners();
        }
      });
    }
  }

  triggerDeleteMyExpiredStatus(String myPhone) async {
    await FirebaseFirestore.instance
        .collection(DatabasePath.fireStoreCollectionStatus)
        .doc(myPhone)
        .get()
        .then((myStatus) async {
      if (myStatus.exists &&
          (DateTime.now()
              .isAfter(myStatus[DatabaseKeys.statusExpiringOn].toDate()))) {
        myStatus.reference.delete();
      }
    });
  }

  triggerDeleteOtherUsersExpiredStatus(String myPhone) async {
    await FirebaseFirestore.instance
        .collection(DatabasePath.fireStoreCollectionStatus)
        .where(DatabaseKeys.statusExpiringOn, isLessThan: DateTime.now())
        .limit(2)
        .get()
        .then((allStatus) async {
      if (allStatus.docs.isNotEmpty) {
        // ignore: avoid_function_literals_in_foreach_calls
        allStatus.docs.forEach((eachStatus) async {
          await eachStatus.reference.delete();
        });
      }
    });

    FirebaseFirestore.instance
        .collection(DatabasePath.fireStoreCollectionUsers)
        .where(DatabaseKeys.lastSeen, isEqualTo: true)
        .where(DatabaseKeys.lastTimeOnline,
            isLessThan: DateTime.now()
                .subtract(const Duration(minutes: 10))
                .millisecondsSinceEpoch)
        .limit(10)
        .get()
        .then((allUsers) async {
      if (allUsers.docs.isNotEmpty) {
        // ignore: avoid_function_literals_in_foreach_calls
        allUsers.docs.forEach((eachUser) async {
          if (eachUser[DatabaseKeys.phone] != myPhone) {
            if (eachUser.data().containsKey(DatabaseKeys.lastTimeOnline)) {
              if (DateTime.now()
                      .difference(DateTime.fromMillisecondsSinceEpoch(
                          eachUser[DatabaseKeys.lastTimeOnline]))
                      .inMinutes >=
                  10) {
                eachUser.reference.update({
                  DatabaseKeys.lastSeen: DateTime.now().millisecondsSinceEpoch
                });
              }
            } else {
              eachUser.reference.update({
                DatabaseKeys.lastSeen: DateTime.now().millisecondsSinceEpoch
              });
            }
          }
        });
      }
    });
//----command to set every online user force offline:
    // FirebaseFirestore.instance
    //     .collection(DbPaths.collectionusers)
    //     .where(DatabaseKeys.lastSeen, isEqualTo: true)
    //     .get()
    //     .then((allUsers) async {
    //   if (allUsers.docs.length > 0) {
    //     allUsers.docs.forEach((eachUser) async {
    //       if (eachUser[DatabaseKeys.phone] != myPhone) {
    //         eachUser.reference.update({
    //           DatabaseKeys.lastSeen: DateTime.now().millisecondsSinceEpoch,
    //           DatabaseKeys.lastOnline: DateTime.now().millisecondsSinceEpoch
    //         });
    //       }
    //     });
    //   }
    // });
  }
}
