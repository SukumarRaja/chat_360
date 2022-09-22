import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/database_keys.dart';
import '../config/database_path.dart';
import '../data/model/data/data.dart';
import '../data/model/joined_user/joined_user.dart';
import '../services/localization/language_constants.dart';
import '../utility/settings.dart';
import 'status.dart';

class AvailableContactsProvider extends ChangeNotifier {
  final TextEditingController filter = TextEditingController();
  Map<String?, String?>? contacts;
  Map<String?, String?>? filtered = <String, String>{};

  bool searchingContactsInDatabase = true;
  List availableContactsLastTime = [];
  List contactsAvailableInPhone = [];
  List<JoinedUserModel> joinedContactsInSharePref = [];
  List<JoinedUserModel> joinedUserPhoneStringAsInServer = [];
  List<dynamic> phoneNumberVariants = [];
  List<DocumentSnapshot> storedUserDoc = [];

  fetchContacts(BuildContext context, DataModel? model, String currentUserPhone,
      SharedPreferences prefs,
      {List<dynamic>? currentUserPhoneNumberVariants}) async {
    if (currentUserPhoneNumberVariants != null) {
      phoneNumberVariants = currentUserPhoneNumberVariants;
    }
    await getContacts(context, model).then((value) async {
      final List<JoinedUserModel> decodedPhoneStrings = prefs
                      .getString('availablePhoneString') ==
                  null ||
              prefs.getString('availablePhoneString') == ''
          ? []
          : JoinedUserModel.decode(prefs.getString('availablePhoneString')!);
      final List<JoinedUserModel> decodedPhoneAndNameStrings =
          prefs.getString('availablePhoneAndNameString') == null ||
                  prefs.getString('availablePhoneAndNameString') == ''
              ? []
              : JoinedUserModel.decode(
                  prefs.getString('availablePhoneAndNameString')!);
      joinedContactsInSharePref = decodedPhoneStrings;
      joinedUserPhoneStringAsInServer = decodedPhoneAndNameStrings;

      await searchAvailableContactsInDatabase(
        context,
        currentUserPhone,
        prefs,
      );
      notifyListeners();
    });
  }

  setIsLoading(bool val) {
    searchingContactsInDatabase = val;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    filter.dispose();
  }

  Future<Map<String?, String?>> getContacts(
      BuildContext context, DataModel? model,
      {bool refresh = false}) async {
    Completer<Map<String?, String?>> completer =
        Completer<Map<String?, String?>>();

    LocalStorage storage = LocalStorage(DatabaseKeys.cachedContacts);

    Map<String?, String?> cachedContacts = {};

    completer.future.then((c) {
      c.removeWhere((key, val) => isHidden(key, model));
      contacts = filtered = c;
    });

    FiberSettings.checkAndRequestPermission(Permission.contacts)
        .then((res) {
      if (res) {
        storage.ready.then((ready) async {
          if (ready) {
            String? getNormalizedNumber(String? number) {
              if (number == null) return null;
              return number.replaceAll(RegExp('[^0-9+]'), '');
            }

            ContactsService.getContacts(withThumbnails: false)
                .then((Iterable<Contact> contacts) async {
              contacts.where((c) => c.phones!.isNotEmpty).forEach((Contact p) {
                if (p.displayName != null && p.phones!.isNotEmpty) {
                  List<String?> numbers = p.phones!
                      .map((number) {
                        String? phone = getNormalizedNumber(number.value);
                        return phone;
                      })
                      .toList()
                      .where((s) => s != null)
                      .toList();

                  // ignore: avoid_function_literals_in_foreach_calls
                  numbers.forEach((number) {
                    cachedContacts[number] = p.displayName;
                  });
                }
              });
              completer.complete(cachedContacts);
            });
          }
          // }
        });
      } else {
        FiberSettings.showRationaleToast(
            getTranslated(context, 'perm_contact'));
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const OpenSettings()));
      }
    }).catchError((onError) {
      FiberSettings.showRationaleToast('Error occurred: $onError');
    });
    notifyListeners();
    return completer.future;
  }

  String? getNormalizedNumber(String number) {
    if (number.isEmpty) {
      return null;
    }

    return number.replaceAll(RegExp('[^0-9+]'), '');
  }

  isHidden(String? phoneNo, DataModel? model) {
    Map<String, dynamic> currentUser = model!.currentUser!;
    return currentUser[DatabaseKeys.hidden] != null &&
        currentUser[DatabaseKeys.hidden].contains(phoneNo);
  }

  // List<DocumentSnapshot<dynamic>> contactsAvailable = [];
  searchAvailableContactsInDatabase(
    BuildContext context,
    String currentUserPhone,
    SharedPreferences existingPrefs,
  ) async {
    if (searchingContactsInDatabase == false &&
            contactsAvailableInPhone.length == filtered!.length ||
        filtered!.isEmpty) {
      searchingContactsInDatabase = false;
      notifyListeners();
    } else {
      // contactsAvailable.clear();
      filtered!.forEach((key, value) async {
        contactsAvailableInPhone.add(key);
        if ((joinedContactsInSharePref
                    .indexWhere((element) => element.phone == key) <
                0) &&
            (!phoneNumberVariants.contains(key))) {
          if (!availableContactsLastTime.contains(key)) {
            await FirebaseFirestore.instance
                .collection(DatabasePath.fireStoreCollectionUsers)
                .where(DatabaseKeys.phoneVariants, arrayContains: key)
                .get()
                .then((docs) async {
              if (docs.docs.isNotEmpty) {
                if (docs.docs[0].data().containsKey(DatabaseKeys.joinedOn)) {
                  if (joinedUserPhoneStringAsInServer.indexWhere((element) =>
                              element.phone ==
                              docs.docs[0][DatabaseKeys.phone]) <
                          0 &&
                      docs.docs[0][DatabaseKeys.phone] != currentUserPhone) {
                    docs.docs[0]
                        .data()[DatabaseKeys.phoneVariants]
                        .toList()
                        .forEach((phone) async {
                      joinedContactsInSharePref
                          .add(JoinedUserModel(phone: phone ?? ''));

                      final String encodedAvailablePhoneString =
                          JoinedUserModel.encode(joinedContactsInSharePref);
                      await existingPrefs.setString(
                          'availablePhoneString', encodedAvailablePhoneString);
                    });
                    joinedUserPhoneStringAsInServer.add(JoinedUserModel(
                        phone: docs.docs[0].data()[DatabaseKeys.phone] ?? '',
                        name:
                            value ?? docs.docs[0].data()[DatabaseKeys.phone]));

                    final String encodedJoinedUserPhoneStringAsInServer =
                        JoinedUserModel.encode(joinedUserPhoneStringAsInServer);
                    await existingPrefs.setString('availablePhoneAndNameString',
                        encodedJoinedUserPhoneStringAsInServer);
                    int i = joinedUserPhoneStringAsInServer.indexWhere(
                        (element) => element.phone == currentUserPhone);
                    if (i >= 0) {
                      joinedUserPhoneStringAsInServer.removeAt(i);
                      joinedContactsInSharePref.removeAt(i);
                    }
                  }

                  if (key == filtered!.entries.last.key) {
                    searchingContactsInDatabase = false;
                    if (joinedUserPhoneStringAsInServer.length > 8 &&
                        joinedUserPhoneStringAsInServer.length < 10) {
                      searchingContactsInDatabase = false;
                      final StatusProvider statusProvider =
                          Provider.of<StatusProvider>(context, listen: false);
                      await statusProvider.searchContactStatus(
                          currentUserPhone, joinedUserPhoneStringAsInServer);
                    }
                  }
                } else {
                  if (key == filtered!.entries.last.key) {
                    searchingContactsInDatabase = false;
                    notifyListeners();
                    final StatusProvider statusProvider =
                        Provider.of<StatusProvider>(context, listen: false);
                    await statusProvider.searchContactStatus(
                        currentUserPhone, joinedUserPhoneStringAsInServer);
                  }
                }
              } else {
                if (key == filtered!.entries.last.key) {
                  searchingContactsInDatabase = false;
                  notifyListeners();
                  final StatusProvider statusProvider =
                      Provider.of<StatusProvider>(context, listen: false);
                  await statusProvider.searchContactStatus(
                      currentUserPhone, joinedUserPhoneStringAsInServer);
                } else if (filtered!.isEmpty) {
                  searchingContactsInDatabase = false;
                  notifyListeners();
                  final StatusProvider statusProvider =
                      Provider.of<StatusProvider>(context, listen: false);
                  await statusProvider.searchContactStatus(
                      currentUserPhone, joinedUserPhoneStringAsInServer);
                }
              }
            });
          } else {
            if (key == filtered!.entries.last.key) {
              searchingContactsInDatabase = false;
              notifyListeners();
              final StatusProvider statusProvider =
                  Provider.of<StatusProvider>(context, listen: false);
              await statusProvider.searchContactStatus(
                  currentUserPhone, joinedUserPhoneStringAsInServer);
            }
          }
        } else {
          if (key == filtered!.entries.last.key) {
            searchingContactsInDatabase = false;
            notifyListeners();
            final StatusProvider statusProvider =
                Provider.of<StatusProvider>(context, listen: false);
            await statusProvider.searchContactStatus(
                currentUserPhone, joinedUserPhoneStringAsInServer);
          }
        }
      });
    }
  }

  Future<DocumentSnapshot> getUserDoc(String phone) async {
    if (storedUserDoc
            .indexWhere((element) => element[DatabaseKeys.phone] == phone) >=
        0) {
      return storedUserDoc[storedUserDoc
          .indexWhere((element) => element[DatabaseKeys.phone] == phone)];
    } else {
      var doc = await FirebaseFirestore.instance
          .collection(DatabasePath.fireStoreCollectionUsers)
          .doc(phone)
          .get();
      storedUserDoc.add(doc);
      return doc;
    }
  }
}
