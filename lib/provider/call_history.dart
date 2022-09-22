import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CallHistoryProvider extends ChangeNotifier {
  final documentSnapshot = <DocumentSnapshot>[];
  String _errorMessage = "";
  bool _hasNext = true;
  bool isFetchingData = false;

  String get errorMessage => _errorMessage;

  bool get hasNext => _hasNext;

  clearAll() {
    documentSnapshot.clear();
    _hasNext = false;
    isFetchingData = false;
    receivedDocs.clear();
    notifyListeners();
  }

  deleteSingle(dynamic doc) {
    receivedDocs.removeWhere((element) => element['TIME'] == doc['TIME']);
    documentSnapshot.removeWhere((element) => element['TIME'] == doc['TIME']);
    notifyListeners();
  }

  List get receivedDocs => documentSnapshot.map((snap) {
        final receivedData = snap.data();
        return receivedData;
      }).toList();

  static Future<QuerySnapshot> getFirestoreCOLLECTIONData(int limit,
      {DocumentSnapshot? startAfter, String? dataType, Query? refData}) async {
    if (startAfter == null) {
      return refData!.get();
    } else {
      return refData!.startAfterDocument(startAfter).get();
    }
  }

  Future fetchNextData(
      String? dataType, Query? refData, bool isAfterNewDocCreated) async {
    if (isFetchingData) return;
    _hasNext = true;
    _errorMessage = "";
    isFetchingData = true;

    try {
      final snap = isAfterNewDocCreated == true
          ? await getFirestoreCOLLECTIONData(10,
              // startAfter: null,
              refData: refData)
          : await getFirestoreCOLLECTIONData(10,
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
      if (snap.docs.length < 10) _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    isFetchingData = false;
  }

  updateParticularDoc({
    required String collection,
    String? document,
    String? compareKey,
    String? compareVal,
    GlobalKey? scaffoldKey,
    GlobalKey? keyLoader,
    BuildContext? context,
  }) async {
    int index =
        documentSnapshot.indexWhere((prod) => prod[compareKey!] == compareVal);
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .get()
        .then((value) {
      documentSnapshot.removeAt(index);
      documentSnapshot.insert(index, value);
      notifyListeners();
    });
  }

  deleteParticularDoc({
    String? collection,
    String? document,
    String? compareKey,
    String? compareVal,
    GlobalKey? scaffoldKey,
    GlobalKey? keyLoader,
    BuildContext? context,
  }) async {
    int index =
        documentSnapshot.indexWhere((prod) => prod[compareKey!] == compareVal);
    documentSnapshot.removeAt(index);
    notifyListeners();
  }
}
