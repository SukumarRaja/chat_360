import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../config/database_keys.dart';
import '../config/limit_constants.dart';
import '../data/repository/firebase_api.dart';

class ChatProvider extends ChangeNotifier {
  List<DocumentSnapshot> documentSnapShot = <DocumentSnapshot>[];
  String _errorMessage = '';
  bool _hasNext = true;
  bool isFetchingData = false;
  String? parentId;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  List get receivedDocs => documentSnapShot.map((snap) {
        final receivedData = snap.data();
        return receivedData;
      }).toList();

  reset() {
    _hasNext = true;
    documentSnapShot.clear();
    isFetchingData = false;
    _errorMessage = '';
    receivedDocs.clear();
    notifyListeners();
  }

  Future fetchNextData(
      String? dataType, Query? refData, bool isAfterNewDocCreated) async {
    if (isFetchingData) return;

    _errorMessage = '';
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
    int index = documentSnapShot.indexWhere(
        (doc) => doc[DatabaseKeys.timeStamp] == newDoc[DatabaseKeys.timeStamp]);
    if (index < 0) {
      documentSnapShot.insert(0, newDoc);
      notifyListeners();
    }
  }

  bool checkIfDocAlreadyExits(
      {required DocumentSnapshot newDoc, int? timeStamp}) {
    return timeStamp != null
        ? documentSnapShot.indexWhere((doc) =>
                doc[DatabaseKeys.timeStamp] ==
                newDoc[DatabaseKeys.timeStamp]) >=
            0
        : documentSnapShot.contains(newDoc);
  }

  int totalDocsLoadedLength() {
    return documentSnapShot.length;
  }

  updateParticularDoc({
    required DocumentSnapshot updatedDoc,
  }) async {
    int index = documentSnapShot.indexWhere((doc) =>
        doc[DatabaseKeys.timeStamp] == updatedDoc[DatabaseKeys.timeStamp]);
    documentSnapShot.removeAt(index);
    documentSnapShot.insert(index, updatedDoc);
    notifyListeners();
  }

  deleteParticularDoc({required DocumentSnapshot deletedDoc}) async {
    int index = documentSnapShot.indexWhere((doc) =>
        doc[DatabaseKeys.timeStamp] == deletedDoc[DatabaseKeys.timeStamp]);
    if (index >= 0) {
      documentSnapShot.removeAt(index);
      notifyListeners();
    }
  }
}
