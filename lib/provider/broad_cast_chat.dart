import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../config/database_keys.dart';
import '../config/limit_constants.dart';
import '../data/repository/firebase_api.dart';

class BroadCastChatProvider extends ChangeNotifier {
  List<DocumentSnapshot> documentSnapShot = <DocumentSnapshot>[];
  String _errorMessage = "";
  String parentId = "";
  bool _hasNext = true;
  bool isFetchingData = false;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  List get receivedDocs => documentSnapShot.map((e) {
        final receivedData = e.data();
        return receivedData;
      }).toList();

  dataReset() {
    _hasNext = true;
    documentSnapShot.clear();
    isFetchingData = false;
    _errorMessage = "";
    receivedDocs.clear();
    notifyListeners();
  }

  Future fetchNextData(
      {String? dataType,
      Query? refData,
      bool isAfterNewDocCreated = false}) async {
    if (isFetchingData) {
      return;
    }
    _errorMessage = "";
    isFetchingData = true;

    try {
      final snap = isAfterNewDocCreated == true
          ? await FirebaseApi.getFireStoreCollectionData(
              limit: LimitConstants.groupMessageLoadingChatMessageLength,
              refData: refData)
          : await FirebaseApi.getFireStoreCollectionData(
              limit: LimitConstants.groupMessageLoadingChatMessageLength,
              startAfter:
                  documentSnapShot.isNotEmpty ? documentSnapShot.last : null,
              refData: refData);
      if (isAfterNewDocCreated == true) {
        documentSnapShot.clear();
        documentSnapShot.addAll(snap.docs);
      } else {
        documentSnapShot.addAll(snap.docs);
      }
      if (snap.docs.length <
          LimitConstants.groupMessageLoadingChatMessageLength) {
        _hasNext = false;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
    isFetchingData = false;
  }

  addDocuments(DocumentSnapshot newDoc) {
    int index = documentSnapShot.indexWhere((element) =>
        element[DatabaseKeys.timeStamp] == newDoc[DatabaseKeys.timeStamp]);
    if (index < 0) {
      documentSnapShot.insert(0, newDoc);
      notifyListeners();
    }
  }

  bool checkIfDocAlreadyExits(
      {required DocumentSnapshot newDoc, int? timeStamp}) {
    return timeStamp != null
        ? documentSnapShot.indexWhere((element) =>
                element[DatabaseKeys.timeStamp] ==
                newDoc[DatabaseKeys.timeStamp]) >=
            0
        : documentSnapShot.contains(newDoc);
  }

  int totalDocsLoadedLength() {
    return documentSnapShot.length;
  }

  updateParticularDoc({required DocumentSnapshot updateDoc}) async {
    int index = documentSnapShot.indexWhere((element) =>
        element[DatabaseKeys.timeStamp] == updateDoc[DatabaseKeys.timeStamp]);
    documentSnapShot.removeAt(index);
    documentSnapShot.insert(index, updateDoc);
    notifyListeners();
  }

  deleteParticularDoc({required DocumentSnapshot deleteDoc}) async {
    int index = documentSnapShot.indexWhere((element) =>
        element[DatabaseKeys.timeStamp] == deleteDoc[DatabaseKeys.timeStamp]);
    if (index >= 0) {
      documentSnapShot.removeAt(index);
      notifyListeners();
    }
  }
}
