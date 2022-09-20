import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat360/ui/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../config/app_config.dart';
import '../../../data/model/call/call.dart';
import '../../../services/localization/language_constants.dart';
import '../../../utility/enum.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/common_text.dart';

class PickUpScreen extends StatelessWidget {
  final Call? call;

  const PickUpScreen({Key? key, this.call}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCallPic = false;
    bool isCallHistory = true;
    bool isVideoCall = true;
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return isCallHistory == false
        ? Scaffold(
            backgroundColor: AppColors.deepGreen,
            body: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    color: AppConfig.designType == ThemeType.messenger
                        ? AppColors.deepGreen
                        : AppColors.deepGreen,
                    height: h / 4,
                    width: w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 7,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mic_rounded,
                              size: 40,
                              color: AppConfig.designType == ThemeType.whatsapp
                                  ? AppColors.lightGreen
                                  : Colors.white.withOpacity(0.5),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Incoming Audio Call",

                              // getTranslated(context, 'incomingaudio'),
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color:
                                      AppConfig.designType == ThemeType.whatsapp
                                          ? AppColors.lightGreen
                                          : Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h / 9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 7),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Text(
                                  "Caller Name",
                                  // call!.callerName!,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppConfig.designType ==
                                            ThemeType.whatsapp
                                        ? AppColors.chattingWhite
                                        : AppColors.chattingWhite,
                                    fontSize: 27,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                "Caller Id",
                                // call!.callerId!,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color:
                                      AppConfig.designType == ThemeType.whatsapp
                                          ? AppColors.chattingWhite
                                              .withOpacity(0.34)
                                          : AppColors.chattingWhite
                                              .withOpacity(0.34),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: h / 25),

                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  isCallPic == false
                      ? Container(
                          height: w + (w / 140),
                          width: w,
                          color: Colors.white12,
                          child: const Icon(
                            Icons.person,
                            size: 140,
                            color: AppColors.deepGreen,
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                                height: w + (w / 140),
                                width: w,
                                color: Colors.white12,
                                child: CachedNetworkImage(
                                  // imageUrl: call.callerPic!,
                                  imageUrl: "",
                                  fit: BoxFit.cover,
                                  height: w + (w / 140),
                                  width: w,
                                  placeholder: (context, url) => Center(
                                      child: Container(
                                    height: w + (w / 140),
                                    width: w,
                                    color: Colors.white12,
                                    child: const Icon(
                                      Icons.person,
                                      size: 140,
                                      color: AppColors.deepGreen,
                                    ),
                                  )),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: w + (w / 140),
                                    width: w,
                                    color: Colors.white12,
                                    child: const Icon(
                                      Icons.person,
                                      size: 140,
                                      color: AppColors.deepGreen,
                                    ),
                                  ),
                                )),
                            Container(
                              height: w + (w / 140),
                              width: w,
                              color: Colors.black.withOpacity(0.18),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: h / 6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () async {
                            // flutterLocalNotificationsPlugin.cancelAll();
                            // await callMethods.endCall(call: call);
                            // FirebaseFirestore.instance
                            //     .collection(
                            //     DatabasePath.fireStoreCollectionUsers)
                            //     .doc(call.callerId)
                            //     .collection(DatabasePath.callHistory)
                            //     .doc(call.timeEpoch.toString())
                            //     .set({
                            //   'STATUS': 'rejected',
                            //   'ENDED': DateTime.now(),
                            // }, SetOptions(merge: true));
                            // FirebaseFirestore.instance
                            //     .collection(
                            //     DatabasePath.fireStoreCollectionUsers)
                            //     .doc(call.receiverId)
                            //     .collection(DatabasePath.callHistory)
                            //     .doc(call.timeEpoch.toString())
                            //     .set({
                            //   'STATUS': 'rejected',
                            //   'ENDED': DateTime.now(),
                            // }, SetOptions(merge: true));
                            //----------
                            // await FirebaseFirestore.instance
                            //     .collection(
                            //     DatabasePath.fireStoreCollectionUsers)
                            //     .doc(call.receiverId)
                            //     .collection('recent')
                            //     .doc('callended')
                            //     .set({
                            //   'id': call.receiverId,
                            //   'ENDED': DateTime.now().millisecondsSinceEpoch
                            // }, SetOptions(merge: true));

                            // firestoreDataProviderCALLHISTORY.fetchNextData(
                            //     'CALLHISTORY',
                            //     FirebaseFirestore.instance
                            //         .collection(
                            //         DatabasePath.fireStoreCollectionUsers)
                            //         .doc(call.receiverId)
                            //         .collection(DatabasePath.callHistory)
                            //         .orderBy('TIME', descending: true)
                            //         .limit(14),
                            //     true);
                          },
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          padding: const EdgeInsets.all(15.0),
                          child: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 35.0,
                          ),
                        ),
                        const SizedBox(width: 45),
                        RawMaterialButton(
                          onPressed: () async {
                            // flutterLocalNotificationsPlugin.cancelAll();
                            // await Permissions
                            //     .cameraAndMicrophonePermissionsGranted()
                            //     .then((isGranted) async {
                            //   if (isGranted == true) {
                            //     await Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => call.isVideoCall ==
                            //             true
                            //             ? VideoCall(
                            //           currentUserUid: currentUserUid,
                            //           call: call,
                            //           channelName: call.channelId,
                            //           role: role,
                            //         )
                            //             : AudioCall(
                            //           currentUserUid: currentUserUid,
                            //           call: call,
                            //           channelName: call.channelId,
                            //           role: role,
                            //         ),
                            //       ),
                            //     );
                            //   } else {
                            //     FiberChatSettings.showRationaleToast(
                            //         getTranslated(context, 'pmc'));
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //             const OpenSettings()));
                            //   }
                            // }).catchError((onError) {
                            //   FiberChatSettings.showRationaleToast(
                            //       getTranslated(context, 'pmc'));
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //           const OpenSettings()));
                            // });
                          },
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.green[400],
                          padding: const EdgeInsets.all(15.0),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 35.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: AppConfig.designType == ThemeType.whatsapp
                ? AppColors.chattingGreen
                : AppColors.chattingWhite,
            body: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: w > h ? 60 : 100),
                child: Column(
                  children: [
                    w > h
                        ? const SizedBox(
                            height: 0,
                          )
                        : Icon(
                            isVideoCall == true
                                ? Icons.videocam_outlined
                                : Icons.mic,
                            size: 80,
                            color: AppConfig.designType == ThemeType.whatsapp
                                ? AppColors.chattingWhite.withOpacity(0.3)
                                : AppColors.chattingBlack.withOpacity(0.3),
                          ),
                    w > h
                        ? const SizedBox(
                            height: 0,
                          )
                        : const SizedBox(
                            height: 20,
                          ),
                    CommonText(
                      // text: isVideoCall == true
                      //     ? getTranslated(context, 'incomingvideo')
                      //     : getTranslated(context, 'incomingaudio'),
                      text: isVideoCall == true
                          ? "Incoming Video Call"
                          : "Incoming Audio Call",
                      fontColor: AppConfig.designType == ThemeType.whatsapp
                          ? AppColors.chattingWhite.withOpacity(0.54)
                          : AppColors.chattingBlack.withOpacity(0.54),
                    ),
                    SizedBox(height: w > h ? 16 : 50),
                    CachedImage(
                      // call.callerPic,
                      "",
                      isRound: true,
                      height: w > h ? 60 : 110,
                      width: w > h ? 60 : 110,
                      radius: w > h ? 70 : 138,
                    ),
                    const SizedBox(height: 15),
                    CommonText(
                      text: "Caller Name",
                      fontWeight: FontWeight.bold,
                      fontColor: AppConfig.designType == ThemeType.whatsapp
                          ? AppColors.chattingWhite
                          : AppColors.chattingBlack,
                      fontSize: 22,
                    ),
                    SizedBox(height: w > h ? 30 : 75),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        RawMaterialButton(
                          onPressed: () async {
                            // flutterLocalNotificationsPlugin.cancelAll();
                            // await callMethods.endCall(call: call);
                            // FirebaseFirestore.instance
                            //     .collection(
                            //     DatabasePath.fireStoreCollectionUsers)
                            //     .doc(call.callerId)
                            //     .collection(DatabasePath.callHistory)
                            //     .doc(call.timeEpoch.toString())
                            //     .set({
                            //   'STATUS': 'rejected',
                            //   'ENDED': DateTime.now(),
                            // }, SetOptions(merge: true));
                            // FirebaseFirestore.instance
                            //     .collection(
                            //     DatabasePath.fireStoreCollectionUsers)
                            //     .doc(call.receiverId)
                            //     .collection(DatabasePath.callHistory)
                            //     .doc(call.timeEpoch.toString())
                            //     .set({
                            //   'STATUS': 'rejected',
                            //   'ENDED': DateTime.now(),
                            // }, SetOptions(merge: true));
                            // //----------
                            // await FirebaseFirestore.instance
                            //     .collection(
                            //     DatabasePath.fireStoreCollectionUsers)
                            //     .doc(call.receiverId)
                            //     .collection('recent')
                            //     .doc('callended')
                            //     .set({
                            //   'id': call.receiverId,
                            //   'ENDED': DateTime.now().millisecondsSinceEpoch
                            // }, SetOptions(merge: true));
                            //
                            // firestoreDataProviderCALLHISTORY.fetchNextData(
                            //     'CALLHISTORY',
                            //     FirebaseFirestore.instance
                            //         .collection(
                            //         DatabasePath.fireStoreCollectionUsers)
                            //         .doc(call.receiverId)
                            //         .collection(DatabasePath.callHistory)
                            //         .orderBy('TIME', descending: true)
                            //         .limit(14),
                            //     true);
                          },
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          padding: const EdgeInsets.all(15.0),
                          child: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 35.0,
                          ),
                        ),
                        const SizedBox(width: 45),
                        RawMaterialButton(
                          onPressed: () async {
                            // flutterLocalNotificationsPlugin.cancelAll();
                            // await Permissions
                            //     .cameraAndMicrophonePermissionsGranted()
                            //     .then((isGranted) async {
                            //   if (isGranted == true) {
                            //     await Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => call.isVideoCall ==
                            //             true
                            //             ? VideoCall(
                            //           currentUserUid: currentUserUid,
                            //           call: call,
                            //           channelName: call.channelId,
                            //           role: role,
                            //         )
                            //             : AudioCall(
                            //           currentUserUid: currentUserUid,
                            //           call: call,
                            //           channelName: call.channelId,
                            //           role: role,
                            //         ),
                            //       ),
                            //     );
                            //   } else {
                            //     FiberChatSettings.showRationaleToast(
                            //         getTranslated(context, 'pmc'));
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //             const OpenSettings()));
                            //   }
                            // }).catchError((onError) {
                            //   FiberChatSettings.showRationaleToast(
                            //       getTranslated(context, 'pmc'));
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //           const OpenSettings()));
                            // });
                          },
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: AppColors.lightGreen,
                          padding: const EdgeInsets.all(15.0),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 35.0,
                          ),
                        )



                      ],
                    )

                  ],
                ),
              ),
            ),
          );
  }
}
