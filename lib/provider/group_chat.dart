import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../config/database_keys.dart';
import '../config/limit_constants.dart';
import '../data/repository/firebase_api.dart';

class GroupChatProvider extends ChangeNotifier {
  List<DocumentSnapshot> documentSnapshot = <DocumentSnapshot>[];
  String _errorMessage = "";
  bool _hasNext = true;
  bool isFetchingData = false;
  String? parentId;

  bool get hasNext => _hasNext;

  String get errorMessage => _errorMessage;

  List get receivedDocs => documentSnapshot.map((snap) {
        final receivedData = snap.data();
        return receivedData;
      }).toList();

  dataReset() {
    _hasNext = true;
    documentSnapshot.clear();
    isFetchingData = false;
    _errorMessage = '';
    receivedDocs.clear();
    notifyListeners();
  }

  Future fetchNextData(
      String? dataType, Query? refData, bool isAfterNewDocCreated) async {
    if (isFetchingData) {
      return;
    }

    _errorMessage = "";
    isFetchingData = true;

    try {
      final snap = isAfterNewDocCreated == true
          ? await FirebaseApi.getFireStoreCollectionData(
              limit: LimitConstants.groupMessageLoadingChatMessageLength,
              // startAfter: null,
              refData: refData)
          : await FirebaseApi.getFireStoreCollectionData(
              limit: LimitConstants.groupMessageLoadingChatMessageLength,
              startAfter:
                  documentSnapshot.isNotEmpty ? documentSnapshot.last : null,
              refData: refData);
      if (isAfterNewDocCreated == true) {
        documentSnapshot.clear();
        documentSnapshot.addAll(snap.docs);
      } else {
        documentSnapshot.addAll(snap.docs);
      }
      // notifyListeners();
      if (snap.docs.length <
          LimitConstants.groupMessageLoadingChatMessageLength) {
        _hasNext = false;
      }
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    isFetchingData = false;
  }

  addDoc(DocumentSnapshot newDoc) {
    int index = documentSnapshot.indexWhere(
        (doc) => doc[DatabaseKeys.timeStamp] == newDoc[DatabaseKeys.timeStamp]);
    if (index < 0) {
      documentSnapshot.insert(0, newDoc);
      notifyListeners();
    }
  }

  bool checkIfDocAlreadyExits(
      {required DocumentSnapshot newDoc, int? timeStamp}) {
    return timeStamp != null
        ? documentSnapshot.indexWhere((doc) =>
                doc[DatabaseKeys.timeStamp] ==
                newDoc[DatabaseKeys.timeStamp]) >=
            0
        : documentSnapshot.contains(newDoc);
  }

  int totalDocsLoadedLength() {
    return documentSnapshot.length;
  }

  updateParticularDoc({
    required DocumentSnapshot updatedDoc,
  }) async {
    int index = documentSnapshot.indexWhere((doc) =>
        doc[DatabaseKeys.timeStamp] == updatedDoc[DatabaseKeys.timeStamp]);
    documentSnapshot.removeAt(index);
    documentSnapshot.insert(index, updatedDoc);
    notifyListeners();
  }

  deleteParticularDoc({required DocumentSnapshot deletedDoc}) async {
    int index = documentSnapshot.indexWhere((doc) =>
        doc[DatabaseKeys.timeStamp] == deletedDoc[DatabaseKeys.timeStamp]);
    if (index >= 0) {
      documentSnapshot.removeAt(index);
      notifyListeners();
    }
  }
}
