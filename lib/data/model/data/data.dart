import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../config/database_keys.dart';
import '../../../config/database_path.dart';
import 'package:async/async.dart' show StreamGroup;

import '../../../utility/settings.dart';


class DataModel extends Model {
  Map<String?, Map<String, dynamic>?> userData =
  <String?, Map<String, dynamic>?>{};
  bool _loaded = false;
  Map<String, Future> messageStatus = <String, Future>{};

  bool get loaded => _loaded;

  Map<String, dynamic>? get currentUser => _currentUser;

  Map<String, dynamic>? _currentUser;

  Map<String?, int?> get lastSpokenAt => _lastSpokenAt;

  final Map<String?, int?> _lastSpokenAt = {};

  getMessageKey(String? peerNo, int? timestamp) => '$peerNo$timestamp';

  getMessageStatus(String? peerNo, int? timestamp) {
    final key = getMessageKey(peerNo, timestamp);
    return messageStatus[key] ?? true;
  }

  LocalStorage storage = LocalStorage('model');

  addMessage(String? peerNo, int? timestamp, Future future) {
    final key = getMessageKey(peerNo, timestamp);
    future.then((_) {
      messageStatus.remove(key);
    });
    messageStatus[key] = future;
  }

  addUser(DocumentSnapshot<Map<String, dynamic>> user) {
    userData[user.data()![DatabaseKeys.phone]] = user.data();
    notifyListeners();
  }

  setWallpaper(String? phone, File image) async {
    final dir = await getDir();
    int now = DateTime.now().millisecondsSinceEpoch;
    String path = '${dir.path}/WALLPAPER-$phone-$now';
    await image.copy(path);
    userData[phone]![DatabaseKeys.wallpaper] = path;
    updateItem(phone!, {DatabaseKeys.wallpaper: path});
    notifyListeners();
  }

  removeWallpaper(String phone) {
    userData[phone]![DatabaseKeys.wallpaper] = null;
    String? path = userData[phone]![DatabaseKeys.aliasAvatar];
    if (path != null) {
      File(path).delete();
      userData[phone]![DatabaseKeys.wallpaper] = null;
    }
    updateItem(phone, {DatabaseKeys.wallpaper: null});
    notifyListeners();
  }

  getDir() async {
    return await getApplicationDocumentsDirectory();
  }

  updateItem(String key, Map<String, dynamic> value) {
    Map<String, dynamic> old = storage.getItem(key) ?? <String, dynamic>{};

    old.addAll(value);
    storage.setItem(key, old);
  }

  setAlias(String aliasName, File? image, String phone) async {
    userData[phone]![DatabaseKeys.aliasName] = aliasName;
    if (image != null) {
      final dir = await getDir();
      int now = DateTime.now().millisecondsSinceEpoch;
      String path = '${dir.path}/$phone-$now';
      await image.copy(path);
      userData[phone]![DatabaseKeys.aliasAvatar] = path;
    }
    updateItem(phone, {
      DatabaseKeys.aliasName: userData[phone]![DatabaseKeys.aliasName],
      DatabaseKeys.aliasAvatar: userData[phone]![DatabaseKeys.aliasAvatar],
    });
    notifyListeners();
  }

  removeAlias(String phone) {
    userData[phone]![DatabaseKeys.aliasName] = null;
    String? path = userData[phone]![DatabaseKeys.aliasAvatar];
    if (path != null) {
      File(path).delete();
      userData[phone]![DatabaseKeys.aliasAvatar] = null;
    }
    updateItem(
        phone, {DatabaseKeys.aliasName: null, DatabaseKeys.aliasAvatar: null});
    notifyListeners();
  }

  getChatOrder(List<String> chatsWith, String? currentUserNo) {
    List<Stream<QuerySnapshot>> messages = [];
    chatsWith.forEach((otherNo) {
      String chatId = FiberSettings.getChatId(currentUserNo, otherNo);
      messages.add(FirebaseFirestore.instance
          .collection(DatabasePath.fireStoreCollectionMessages)
          .doc(chatId)
          .collection(chatId)
          .snapshots());
    });
    StreamGroup.merge(messages).listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot message = snapshot.docs.last;
        _lastSpokenAt[message[DatabaseKeys.from] == currentUserNo
            ? message[DatabaseKeys.to]
            : message[DatabaseKeys.from]] = message[DatabaseKeys.timeStamp];
        notifyListeners();
      }
    });
  }

  DataModel(String? currentUserNo) {
    FirebaseFirestore.instance
        .collection(DatabasePath.fireStoreCollectionUsers)
        .doc(currentUserNo)
        .snapshots()
        .listen((user) {
      _currentUser = user.data();
      notifyListeners();
    });
    storage.ready.then((ready) {
      if (ready) {
        FirebaseFirestore.instance
            .collection(DatabasePath.fireStoreCollectionUsers)
            .doc(currentUserNo)
            .collection(DatabaseKeys.chatsWith)
            .doc(DatabaseKeys.chatsWith)
            .snapshots()
            .listen((chatsWith) {
          if (chatsWith.exists) {
            List<Stream<DocumentSnapshot>> users = [];
            List<String> peers = [];
            chatsWith.data()!.entries.forEach((data) {
              peers.add(data.key);
              users.add(FirebaseFirestore.instance
                  .collection(DatabasePath.fireStoreCollectionUsers)
                  .doc(data.key)
                  .snapshots());
              if (userData[data.key] != null) {
                userData[data.key]![DatabaseKeys.chatStatus] =
                chatsWith[data.key];
              }
            });
            getChatOrder(peers, currentUserNo);
            notifyListeners();
            Map<String?, Map<String, dynamic>?> newData =
            <String?, Map<String, dynamic>?>{};
            StreamGroup.merge(users).listen((user) {
              if (user.exists) {
                newData[user[DatabaseKeys.phone]] =
                user.data() as Map<String, dynamic>?;
                newData[user[DatabaseKeys.phone]]![DatabaseKeys.chatStatus] =
                chatsWith[user[DatabaseKeys.phone]];
                Map<String, dynamic>? stored =
                storage.getItem(user[DatabaseKeys.phone]);
                if (stored != null) {
                  newData[user[DatabaseKeys.phone]]!.addAll(stored);
                }
              }
              userData = Map.from(newData);
              notifyListeners();
            });
          }
          if (!_loaded) {
            _loaded = true;
            notifyListeners();
          }
        });
      }
    });
  }
}

