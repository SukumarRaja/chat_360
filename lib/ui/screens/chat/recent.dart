import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/database_keys.dart';
import '../../../config/database_path.dart';
import '../../../config/limit_constants.dart';
import '../../../data/model/broadcast/broadcast.dart';
import '../../../data/model/data/data.dart';
import '../../../data/model/group/group.dart';
import '../../../provider/observer.dart';
import '../../../services/admob/ad.dart';
import '../../../utility/settings.dart';
import '../../themes/app_colors.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  AdWidget? adWidget;
  final BannerAd myBanner = BannerAd(
    adUnitId: getBannerAdUnitId()!,
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  List<Map<String, dynamic>> streamDocSnap = [];
  bool showHidden = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    // FiberChatSettings.internetLookUp();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   final observer = Provider.of<ObserverProvider>(context, listen: false);
    //   if (LimitConstants.isBannerAdShow == true &&
    //       observer.isadmobshow == true) {
    //     myBanner.load();
    //     adWidget = AdWidget(ad: myBanner);
    //     setState(() {});
    //   }
    // });
  }

  DataModel? cachedModel;
  String? currentUserNo;

  DataModel? getModel() {
    cachedModel ??= DataModel(currentUserNo);
    return cachedModel;
  }

  @override
  Widget build(BuildContext context) {
    bool admob = false;
    return FiberSettings.getNTPWrappedWidget(ScopedModel<DataModel>(
      model: getModel()!,
      child: ScopedModelDescendant<DataModel>(
        builder: (context, child, model) {
          cachedModel = model;
          return Scaffold(
            bottomSheet: LimitConstants.isBannerAdShow == true &&
                    admob == true &&
                    adWidget != null
                ? Container(
                    height: 60,
                    margin: EdgeInsets.only(
                        bottom: Platform.isIOS == true ? 25.0 : 5, top: 0),
                    child: Center(child: adWidget),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            backgroundColor: AppColors.chattingWhite,
            floatingActionButton: Padding(
              padding: EdgeInsets.only(
                  bottom: LimitConstants.isBannerAdShow == true && admob == true
                      ? 60
                      : 0),
              child: FloatingActionButton(
                heroTag: "chat",
                backgroundColor: AppColors.lightGreen,
                child: const Icon(
                  Icons.chat,
                  size: 30.0,
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => SmartContactsPage(
                  //             onTapCreateGroup: () {
                  //               if (observer.isAllowCreatingGroups == false) {
                  //                 FiberChatSettings.showRationaleToast(
                  //                     getTranslated(this.context, 'disabled'));
                  //               } else {
                  //                 Navigator.pushReplacement(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             AddContactsToGroup(
                  //                               currentUserNo:
                  //                               widget.currentUserNo,
                  //                               model: cachedModel,
                  //                               biometricEnabled: false,
                  //                               prefs: widget.prefs,
                  //                               isAddingWhileCreatingGroup:
                  //                               true,
                  //                             )));
                  //               }
                  //             },
                  //             onTapCreateBroadcast: () {
                  //               if (observer.isAllowCreatingBroadcasts ==
                  //                   false) {
                  //                 FiberChatSettings.showRationaleToast(
                  //                     getTranslated(this.context, 'disabled'));
                  //               } else {
                  //                 Navigator.pushReplacement(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             AddContactsToBroadcast(
                  //                               currentUserNo:
                  //                               widget.currentUserNo,
                  //                               model: cachedModel,
                  //                               biometricEnabled: false,
                  //                               prefs: widget.prefs,
                  //                               isAddingWhileCreatingBroadcast:
                  //                               true,
                  //                             )));
                  //               }
                  //             },
                  //             prefs: widget.prefs,
                  //             biometricEnabled: biometricEnabled,
                  //             currentUserNo: currentUserNo!,
                  //             model: cachedModel!)));
                },
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () {
                // isAuthenticating = !isAuthenticating;
                // setState(() {
                //   showHidden = !showHidden;
                // });
                return Future.value();
              },
              child: chats(model.userData, model.currentUser),
              // child: Container(),
            ),
          );
        },
      ),
    ));
  }

  chats(Map<String?, Map<String, dynamic>?> userData,
      Map<String, dynamic>? currentUser) {
    return Consumer<List<GroupModel>>(
        builder: (context, groupList, child) => Consumer<List<BroadcastModel>>(
            builder: (context, broadcastList, child) {
              streamDocSnap = Map.from(userData)
                  .values
                  .where(
                      (user) => user.keys.contains(DatabaseKeys.chatStatus))
                  .toList()
                  .cast<Map<String, dynamic>>();
              Map<String?, int?> lastSpokenAt = cachedModel!.lastSpokenAt;
              List<Map<String, dynamic>> filtered =
              List.from(<Map<String, dynamic>>[]);
              groupList.forEach((element) {
                streamDocSnap.add(element.docMap);
              });
              broadcastList.forEach((element) {
                streamDocSnap.add(element.docMap);
              });
              streamDocSnap.sort((a, b) {
                int aTimestamp = a.containsKey(DatabaseKeys.groupIsTypingUserId)
                    ? a[DatabaseKeys.groupLatestMessageTime]
                    : a.containsKey(DatabaseKeys.broadcastBlackList)
                    ? a[DatabaseKeys.broadCastLatestMessageTime]
                    : lastSpokenAt[a[DatabaseKeys.phone]] ?? 0;
                int bTimestamp = b.containsKey(DatabaseKeys.groupIsTypingUserId)
                    ? b[DatabaseKeys.groupLatestMessageTime]
                    : b.containsKey(DatabaseKeys.broadcastBlackList)
                    ? b[DatabaseKeys.broadCastLatestMessageTime]
                    : lastSpokenAt[b[DatabaseKeys.phone]] ?? 0;
                return bTimestamp - aTimestamp;
              });

              if (!showHidden) {
                streamDocSnap.removeWhere((user) =>
                !user.containsKey(DatabaseKeys.groupIsTypingUserId) &&
                    !user.containsKey(DatabaseKeys.broadcastBlackList) &&
                    isHidden(user[DatabaseKeys.phone]));
              }

              return ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                shrinkWrap: true,
                children: [
                  // Container(
                  //     child: streamDocSnap.isNotEmpty
                  //         ? StreamBuilder(
                  //         stream: userQuery.stream.asBroadcastStream(),
                  //         builder: (context, snapshot) {
                  //           if (filter.text.isNotEmpty ||
                  //               snapshot.hasData) {
                  //             filtered = streamDocSnap.where((user) {
                  //               return user[DatabaseKeys.nickName]
                  //                   .toLowerCase()
                  //                   .trim()
                  //                   .contains(RegExp(r'' +
                  //                   filter.text.toLowerCase().trim() +
                  //                   ''));
                  //             }).toList();
                  //             if (filtered.isNotEmpty) {
                  //               return ListView.builder(
                  //                 physics:
                  //                 const AlwaysScrollableScrollPhysics(),
                  //                 shrinkWrap: true,
                  //                 padding: const EdgeInsets.all(10.0),
                  //                 itemBuilder: (context, index) =>
                  //                     buildItem(context,
                  //                         filtered.elementAt(index)),
                  //                 itemCount: filtered.length,
                  //               );
                  //             } else {
                  //               return ListView(
                  //                   physics:
                  //                   const AlwaysScrollableScrollPhysics(),
                  //                   shrinkWrap: true,
                  //                   children: [
                  //                     Padding(
                  //                         padding: EdgeInsets.only(
                  //                             top: MediaQuery.of(context)
                  //                                 .size
                  //                                 .height /
                  //                                 3.5),
                  //                         child: Center(
                  //                           child: Text(
                  //                               getTranslated(context,
                  //                                   'nosearchresult'),
                  //                               textAlign: TextAlign.center,
                  //                               style: const TextStyle(
                  //                                 fontSize: 18,
                  //                                 color: AppColors.grey,
                  //                               )),
                  //                         ))
                  //                   ]);
                  //             }
                  //           }
                  //           return ListView.builder(
                  //             physics: const NeverScrollableScrollPhysics(),
                  //             shrinkWrap: true,
                  //             padding:
                  //             const EdgeInsets.fromLTRB(0, 10, 0, 120),
                  //             itemBuilder: (context, index) {
                  //               if (streamDocSnap[index].containsKey(
                  //                   DatabaseKeys.groupIsTypingUserId)) {
                  //                 ///----- Build Group Chat Tile ----
                  //                 return Theme(
                  //                     data: ThemeData(
                  //                         splashColor: Colors.transparent,
                  //                         highlightColor:
                  //                         Colors.transparent),
                  //                     child: Column(
                  //                       children: [
                  //                         ListTile(
                  //                           onLongPress: () {
                  //                             showMenuForGroupChat(context,
                  //                                 streamDocSnap[index]);
                  //                           },
                  //                           contentPadding:
                  //                           const EdgeInsets.fromLTRB(
                  //                               20, 0, 20, 0),
                  //                           leading:
                  //                           CustomCircleAvatarGroup(
                  //                               url: streamDocSnap[
                  //                               index][
                  //                               DatabaseKeys
                  //                                   .groupPhotoUrl],
                  //                               radius: 22),
                  //                           title: Text(
                  //                             streamDocSnap[index]
                  //                             [DatabaseKeys.groupName],
                  //                             maxLines: 1,
                  //                             overflow:
                  //                             TextOverflow.ellipsis,
                  //                             style: const TextStyle(
                  //                               color:
                  //                               AppColors.chattingBlack,
                  //                               fontSize: 16,
                  //                             ),
                  //                           ),
                  //                           subtitle: Text(
                  //                             '${streamDocSnap[index][DatabaseKeys.groupMemberList].length} ${getTranslated(context, 'participants')}',
                  //                             style: const TextStyle(
                  //                               color: AppColors.grey,
                  //                               fontSize: 14,
                  //                             ),
                  //                           ),
                  //                           onTap: () {
                  //                             // Navigator.push(
                  //                             //     context,
                  //                             //     MaterialPageRoute(
                  //                             //         builder: (context) => GroupChatPage(
                  //                             //             isSharingIntentForwarded:
                  //                             //             false,
                  //                             //             model:
                  //                             //             cachedModel!,
                  //                             //             prefs:
                  //                             //             widget.prefs,
                  //                             //             joinedTime:
                  //                             //             streamDocSnap[
                  //                             //             index][
                  //                             //             '${widget.currentUserNo}-joinedOn'],
                  //                             //             currentUserNo: widget
                  //                             //                 .currentUserNo!,
                  //                             //             groupId: streamDocSnap[
                  //                             //             index][
                  //                             //             DatabaseKeys
                  //                             //                 .groupId])));
                  //                           },
                  //                           // trailing: StreamBuilder(
                  //                           //   stream: FirebaseFirestore
                  //                           //       .instance
                  //                           //       .collection(DatabasePath
                  //                           //       .fireStoreCollectionGroup)
                  //                           //       .doc(streamDocSnap[index]
                  //                           //   [
                  //                           //   DatabaseKeys.groupId])
                  //                           //       .collection(DatabasePath
                  //                           //       .groupChats)
                  //                           //       .where(
                  //                           //       DatabaseKeys
                  //                           //           .groupMessageTime,
                  //                           //       isGreaterThan:
                  //                           //       streamDocSnap[
                  //                           //       index][
                  //                           //       widget
                  //                           //           .currentUserNo])
                  //                           //       .snapshots(),
                  //                           //   builder:
                  //                           //       (BuildContext context,
                  //                           //       AsyncSnapshot<
                  //                           //           QuerySnapshot<
                  //                           //               dynamic>>
                  //                           //       snapshot) {
                  //                           //     if (snapshot
                  //                           //         .connectionState ==
                  //                           //         ConnectionState
                  //                           //             .waiting) {
                  //                           //       return const SizedBox(
                  //                           //         height: 0,
                  //                           //         width: 0,
                  //                           //       );
                  //                           //     } else if (snapshot
                  //                           //         .hasData &&
                  //                           //         snapshot.data!.docs.isNotEmpty) {
                  //                           //       return Container(
                  //                           //         padding:
                  //                           //         const EdgeInsets
                  //                           //             .all(7.0),
                  //                           //         decoration:
                  //                           //         BoxDecoration(
                  //                           //           shape:
                  //                           //           BoxShape.circle,
                  //                           //           color:
                  //                           //           Colors.blue[400],
                  //                           //         ),
                  //                           //         child: Text(
                  //                           //             '${snapshot.data!.docs.length}',
                  //                           //             style: const TextStyle(
                  //                           //                 fontSize: 14,
                  //                           //                 color: Colors
                  //                           //                     .white,
                  //                           //                 fontWeight:
                  //                           //                 FontWeight
                  //                           //                     .bold)),
                  //                           //       );
                  //                           //     }
                  //                           //     return const SizedBox(
                  //                           //       height: 0,
                  //                           //       width: 0,
                  //                           //     );
                  //                           //   },
                  //                           // ),
                  //                         ),
                  //                         const Divider(
                  //                           height: 0,
                  //                         ),
                  //                       ],
                  //                     ));
                  //               } else if (streamDocSnap[index]
                  //                   .containsKey(DatabaseKeys
                  //                   .broadcastBlackList)) {
                  //                 ///----- Build Broadcast Chat Tile ----
                  //                 return Theme(
                  //                     data: ThemeData(
                  //                         splashColor: Colors.transparent,
                  //                         highlightColor:
                  //                         Colors.transparent),
                  //                     child: Column(
                  //                       children: [
                  //                         // ListTile(
                  //                         //   onLongPress: () {
                  //                         //     showMenuForBroadcastChat(
                  //                         //         context,
                  //                         //         streamDocSnap[index]);
                  //                         //   },
                  //                         //   contentPadding:
                  //                         //   const EdgeInsets.fromLTRB(
                  //                         //       20, 0, 20, 0),
                  //                         //   leading:
                  //                         //   CustomCircleAvatarBroadcast(
                  //                         //       url: streamDocSnap[
                  //                         //       index][
                  //                         //       DatabaseKeys
                  //                         //           .broadcastPhotoUrl],
                  //                         //       radius: 22),
                  //                         //   title: Text(
                  //                         //     streamDocSnap[index][
                  //                         //     DatabaseKeys
                  //                         //         .broadcastName],
                  //                         //     maxLines: 1,
                  //                         //     overflow:
                  //                         //     TextOverflow.ellipsis,
                  //                         //     style: const TextStyle(
                  //                         //       color:
                  //                         //       AppColors.chattingBlack,
                  //                         //       fontSize: 16,
                  //                         //     ),
                  //                         //   ),
                  //                         //   subtitle: Text(
                  //                         //     '${streamDocSnap[index][DatabaseKeys.broadcastMembersList].length} ${getTranslated(context, 'recipients')}',
                  //                         //     style: const TextStyle(
                  //                         //       color: AppColors.grey,
                  //                         //       fontSize: 14,
                  //                         //     ),
                  //                         //   ),
                  //                         //   onTap: () {
                  //                         //     // Navigator.push(
                  //                         //     //     context,
                  //                         //     //     MaterialPageRoute(
                  //                         //     //         builder: (context) => BroadcastChatPage(
                  //                         //     //             model:
                  //                         //     //             cachedModel!,
                  //                         //     //             prefs:
                  //                         //     //             widget.prefs,
                  //                         //     //             currentUserNo: widget
                  //                         //     //                 .currentUserNo!,
                  //                         //     //             broadcastID:
                  //                         //     //             streamDocSnap[
                  //                         //     //             index]
                  //                         //     //             [
                  //                         //     //             DatabaseKeys
                  //                         //     //                 .broadCastId])));
                  //                         //   },
                  //                         // ),
                  //                         const Divider(height: 0),
                  //                       ],
                  //                     ));
                  //               } else {
                  //                 // return buildItem(context,
                  //                 //     streamDocSnap.elementAt(index));
                  //               }
                  //             },
                  //             itemCount: streamDocSnap.length,
                  //           );
                  //         })
                  //         : ListView(
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         padding: const EdgeInsets.all(0),
                  //         children: [
                  //           // Padding(
                  //           //     padding: EdgeInsets.only(
                  //           //         top: MediaQuery.of(context)
                  //           //             .size
                  //           //             .height /
                  //           //             3.5),
                  //           //     child: Center(
                  //           //       child: Padding(
                  //           //           padding: const EdgeInsets.all(30.0),
                  //           //           child: Text(
                  //           //               groupList.isNotEmpty
                  //           //                   ? ''
                  //           //                   : getTranslated(
                  //           //                   context, 'startchat'),
                  //           //               textAlign: TextAlign.center,
                  //           //               style: const TextStyle(
                  //           //                 fontSize: 16,
                  //           //                 height: 1.59,
                  //           //                 color: AppColors.grey,
                  //           //               ))),
                  //           //     ))
                  //         ])),
                ],
              );
            }));
  }
  isHidden(phoneNo) {
    Map<String, dynamic> currentUser = cachedModel!.currentUser!;
    return currentUser[DatabaseKeys.hidden] != null &&
        currentUser[DatabaseKeys.hidden].contains(phoneNo);
  }
}
