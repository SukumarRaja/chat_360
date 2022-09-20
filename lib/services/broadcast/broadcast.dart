import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/database_keys.dart';
import '../../config/database_path.dart';
import '../../data/model/broadcast/broadcast.dart';

class FirebaseBroadcastServices {
  Stream<List<BroadcastModel>> getBroadCastList(String? phone) {
    return FirebaseFirestore.instance
        .collection(DatabasePath.fireStoreCollectionBroadCast)
        .where(DatabaseKeys.broadCastCreatedBy, isEqualTo: phone)
        .orderBy(DatabaseKeys.broadCastCreatedOn, descending: true)
        .snapshots()
        .map((event) =>
        event.docs.map((e) => BroadcastModel.fromJson(e.data())).toList());
  }

  // FlutterSecureStorage storage = const FlutterSecureStorage();
  // late encrypt.Encrypter crypter;
  // final iv = encrypt.IV.fromLength(8);
  //
  // dynamic encryptWithCRC({required String input}) {
  //   try {
  //     var encrypted = crypter.encrypt(input, iv: iv).base64;
  //     int crc = CRC32.compute(input);
  //     return '$encrypted${DatabaseKeys.crcSeparator}$crc';
  //   } catch (e) {
  //     FiberChatSettings.toast('Error occurred while encrypting !');
  //     return false;
  //   }
  // }

  // sendMessageToBroadcastRecipients(
  //     {required List<dynamic> recipientList,
  //       required BuildContext context,
  //       required String content,
  //       required String currentUserNo,
  //       required String broadCastId,
  //       required MessageType type,
  //       required DataModel cachedModel}) async {
  //   String? privateKey = await storage.read(key: DatabaseKeys.privateKey);
  //   content = content.trim();
  //   int timeStamp = DateTime.now().millisecondsSinceEpoch;
  //   if (content.trim() != "") {
  //     await FirebaseFirestore.instance
  //         .collection(DatabasePath.fireStoreCollectionBroadCast)
  //         .doc(broadCastId)
  //         .collection(DatabasePath.fireStoreCollectionBroadCastChat)
  //         .doc(timeStamp.toString() + '--' + currentUserNo)
  //         .set({
  //       DatabaseKeys.broadCastMessageContent: content,
  //       DatabaseKeys.broadCastMessageIsDeleted: false,
  //       DatabaseKeys.broadCastMessageListOptional: [],
  //       DatabaseKeys.broadCastMessageTime: timeStamp,
  //       DatabaseKeys.broadCastMessageSendBy: currentUserNo,
  //       DatabaseKeys.broadCastMessageType: type.index,
  //       DatabaseKeys.broadCastLocations: [],
  //     }, SetOptions(merge: true));
  //
  //     await FirebaseFirestore.instance
  //         .collection(DatabasePath.fireStoreCollectionBroadCast)
  //         .doc(broadCastId)
  //         .update({DatabaseKeys.broadCastLatestMessageTime: timeStamp});
  //     recipientList.forEach((peer) async {
  //       await FirebaseFirestore.instance
  //           .collection(DatabasePath.fireStoreCollectionUsers)
  //           .doc(peer)
  //           .get()
  //           .then((userDoc) async {
  //         try {
  //           String? sharedSecret = (await const e2ee.X25519()
  //               .calculateSharedSecret(
  //               e2ee.Key.fromBase64(
  //                   encoded: privateKey!, isPublic: false),
  //               e2ee.Key.fromBase64(
  //                   encoded: userDoc[DatabaseKeys.publicKey],
  //                   isPublic: true)))
  //               .toBase64();
  //           final key = encrypt.Key.fromBase64(sharedSecret);
  //           crypter = encrypt.Encrypter(encrypt.Salsa20(key));
  //           final encrypted = encryptWithCRC(input: content);
  //           if (encrypted is String) {
  //             int timeStamp2 = DateTime.now().millisecondsSinceEpoch;
  //             if (content.trim() != "") {
  //               var chatId = FiberChatSettings.getChatId(currentUserNo, peer);
  //               await FirebaseFirestore.instance
  //                   .collection(DatabasePath.fireStoreCollectionBroadCast)
  //                   .doc(broadCastId)
  //                   .collection(DatabasePath.fireStoreCollectionBroadCastChat)
  //                   .doc(timeStamp.toString() + '--' + currentUserNo)
  //                   .set({
  //                 DatabaseKeys.broadCastLocations:
  //                 FieldValue.arrayUnion(['$chatId--BREAK--$timeStamp2'])
  //               }, SetOptions(merge: true)).then((value) async {
  //                 await FirebaseFirestore.instance
  //                     .collection(DatabasePath.fireStoreCollectionMessages)
  //                     .doc(chatId)
  //                     .set({
  //                   currentUserNo: true,
  //                   peer: userDoc[DatabaseKeys.lastSeen],
  //                   DatabaseKeys.isBroadCast: true
  //                 }, SetOptions(merge: true)).then((value) {
  //                   Future messaging = FirebaseFirestore.instance
  //                       .collection(DatabasePath.fireStoreCollectionUsers)
  //                       .doc(peer)
  //                       .collection(DatabaseKeys.chatsWith)
  //                       .doc(DatabaseKeys.chatsWith)
  //                       .set({
  //                     currentUserNo: 4,
  //                   }, SetOptions(merge: true));
  //                   cachedModel.addMessage(peer, timeStamp2, messaging);
  //                 }).then((value) {
  //                   Future messaging = FirebaseFirestore.instance
  //                       .collection(DatabasePath.fireStoreCollectionMessages)
  //                       .doc(chatId)
  //                       .collection(chatId)
  //                       .doc('$timeStamp2')
  //                       .set({
  //                     DatabaseKeys.from: currentUserNo,
  //                     DatabaseKeys.to: peer,
  //                     DatabaseKeys.timeStamp: timeStamp2,
  //                     DatabaseKeys.content: encrypted,
  //                     DatabaseKeys.messageType: type.index,
  //                     DatabaseKeys.isBroadCast: true,
  //                     DatabaseKeys.broadCastId: broadCastId,
  //                     DatabaseKeys.hasRecipientDeleted: false,
  //                     DatabaseKeys.hasSenderDeleted: false,
  //                   }, SetOptions(merge: true));
  //                   cachedModel.addMessage(peer, timeStamp2, messaging);
  //                 });
  //               });
  //             }
  //           } else {
  //             FiberChatSettings.toast('Nothing to send');
  //           }
  //         } catch (e) {
  //           FiberChatSettings.toast('Failed to Send message. Error:$e');
  //         }
  //       }).catchError(((e) {
  //         FiberChatSettings.toast('Failed to Send message. Error:$e');
  //       }));
  //     });
  //   } else {
  //     FiberChatSettings.toast('Nothing to Send !');
  //   }
  // }
}
