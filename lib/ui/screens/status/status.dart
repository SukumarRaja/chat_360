import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../config/limit_constants.dart';
import '../../../services/admob/admob.dart';
import '../../themes/app_colors.dart';
import '../../widgets/common_text.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> with AutomaticKeepAliveClientMixin{
  late Stream myStatusUpdates;

  AdWidget? adWidget;

  @override
  void initState() {
    AdMobService.createInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool admob = false;
    bool allowStatus = false;
    return Scaffold(
      backgroundColor: AppColors.chattingWhite,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom: LimitConstants.isBannerAdShow == true && admob == true
                ? 60
                : 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 43,
              margin: const EdgeInsets.only(bottom: 18),
              child: FloatingActionButton(
                heroTag: "d636546yt834",
                backgroundColor: const Color(0xffebecee),
                onPressed: () {
                  if (allowStatus == true) {
                    // FiberChatSettings.showRationaleToast(
                    //     getTranslated(this.context, 'disabled'));
                  } else {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             TextStatus(
                    //                 currentUserNo:
                    //                 widget.currentUserNo!,
                    //                 phoneNumberVariants:
                    //                 widget.phoneNumberVariants)));
                  }
                },
                child:
                    Icon(Icons.edit, size: 23.0, color: Colors.blueGrey[700]),
              ),
            ),
            FloatingActionButton(
              heroTag: "frewrwr",
              backgroundColor: AppColors.lightGreen,
              onPressed: () {
                if (allowStatus == true) {
                  // FiberChatSettings.showRationaleToast(
                  //     getTranslated(this.context, 'disabled'));
                } else {
                  // showMediaOptions(
                  //     ishideTextStatusbutton: true,
                  //     phoneVariants: widget.phoneNumberVariants,
                  //     context: context,
                  //     pickVideoCallback: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   StatusVideoEditor(
                  //                     callback: (v, d, t) async {
                  //                       Navigator.of(context).pop();
                  //                       await uploadFile(
                  //                           filename: DateTime
                  //                               .now()
                  //                               .millisecondsSinceEpoch
                  //                               .toString(),
                  //                           type: DatabaseKeys
                  //                               .statusTypeVideo,
                  //                           file: d,
                  //                           caption: v,
                  //                           duration: t);
                  //                     },
                  //                     title: getTranslated(
                  //                         context, 'createstatus'),
                  //                   )));
                  //     },
                  //     pickImageCallback: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) =>
                  //                   StatusImageEditor(
                  //                     callback: (v, d) async {
                  //                       Navigator.of(context).pop();
                  //                       await uploadFile(
                  //                           filename: DateTime
                  //                               .now()
                  //                               .millisecondsSinceEpoch
                  //                               .toString(),
                  //                           type: DatabaseKeys
                  //                               .statusTypeImage,
                  //                           file: d,
                  //                           caption: v);
                  //                     },
                  //                     title: getTranslated(
                  //                         context, 'createstatus'),
                  //                   )));
                  //     });
                }
              },
              child: const Icon(
                Icons.camera_alt_rounded,
                size: 25,
              ),
            ),
          ],
        ),
      ),
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
      body: RefreshIndicator(
        onRefresh: () {
          // final statusProvider =
          // Provider.of<StatusProvider>(context, listen: false);
          // final contactsProvider = Provider.of<AvailableContactsProvider>(
          //     context,
          //     listen: false);
          // statusProvider.searchContactStatus(widget.currentUserNo!,
          //     contactsProvider.joinedUserPhoneStringAsInServer);
          return Future.value();
        },
        child:Stack(
          children: [
            Container(
              color: const Color(0xfff2f2f2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // StreamBuilder(
                  //     stream: myStatusUpdates,
                  //     builder:
                  //         (context, AsyncSnapshot snapshot) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return Card(
                  //           color: Colors.white,
                  //           elevation: 0.0,
                  //           child: Padding(
                  //               padding:
                  //               const EdgeInsets.fromLTRB(
                  //                   0, 8, 8, 8),
                  //               child: InkWell(
                  //                 onTap: () {},
                  //                 child: ListTile(
                  //                   leading: Stack(
                  //                     children: <Widget>[
                  //                       // const CustomCircleAvatar(
                  //                       //     radius: 35),
                  //                       // Positioned(
                  //                       //   bottom: 1.0,
                  //                       //   right: 1.0,
                  //                       //   child: Container(
                  //                       //     height: 20,
                  //                       //     width: 20,
                  //                       //     decoration:
                  //                       //     const BoxDecoration(
                  //                       //       color:
                  //                       //       Colors.green,
                  //                       //       shape: BoxShape
                  //                       //           .circle,
                  //                       //     ),
                  //                       //     child: const Icon(
                  //                       //       Icons.add,
                  //                       //       color:
                  //                       //       Colors.white,
                  //                       //       size: 15,
                  //                       //     ),
                  //                       //   ),
                  //                       // ),
                  //                     ],
                  //                   ),
                  //                   title: CommonText(
                  //                     text:"My Status",
                  //                     // getTranslated(
                  //                     //     context, 'mystatus'),
                  //                         fontWeight:
                  //                         FontWeight.bold,
                  //                   ),
                  //                   subtitle: CommonText(
                  //                     text:"Loading",
                  //                     // getTranslated(
                  //                     //     context, 'loading'),
                  //                   ),
                  //                 ),
                  //               )),
                  //         );
                  //       }
                  //       else if (snapshot.hasData &&
                  //           snapshot.data.exists) {
                  //         // int seen = !snapshot.data
                  //         //     .data()
                  //         //     .containsKey(
                  //         //     widget.currentUserNo)
                  //         //     ? 0
                  //         //     : 0;
                  //         // if (snapshot.data.data().containsKey(
                  //         //     widget.currentUserNo)) {
                  //         //   // snapshot
                  //         //   //     .data[DatabaseKeys
                  //         //   //     .statusItemList]
                  //         //   //     .forEach((status) {
                  //         //   //   if (snapshot
                  //         //   //       .data[widget.currentUserNo]
                  //         //   //       .contains(status[
                  //         //   //   DatabaseKeys.statusItemId])) {
                  //         //   //     seen = seen + 1;
                  //         //   //   }
                  //         //   // });
                  //         // }
                  //         return Container();
                  //         // return Card(
                  //         //   color: Colors.white,
                  //         //   elevation: 0.0,
                  //         //   child: Padding(
                  //         //     padding:
                  //         //     const EdgeInsets.fromLTRB(
                  //         //         3, 8, 8, 8),
                  //         //     child: ListTile(
                  //         //       leading: Stack(
                  //         //         children: <Widget>[
                  //         //           InkWell(
                  //         //             onTap: () {
                  //         //               Navigator.push(
                  //         //                   context,
                  //         //                   MaterialPageRoute(
                  //         //                       builder:
                  //         //                           (context) =>
                  //         //                           StatusView(
                  //         //                             model:
                  //         //                             widget
                  //         //                                 .model!,
                  //         //                             prefs:
                  //         //                             widget
                  //         //                                 .prefs,
                  //         //                             currentUserNo:
                  //         //                             widget
                  //         //                                 .currentUserNo!,
                  //         //                             statusDoc:
                  //         //                             snapshot
                  //         //                                 .data,
                  //         //                             postedByFullName:
                  //         //                             widget
                  //         //                                 .currentUserFullName ??
                  //         //                                 '',
                  //         //                             postedByPhotoUrl:
                  //         //                             widget
                  //         //                                 .currentUserPhotoUrl,
                  //         //                           )));
                  //         //             },
                  //         //             child: Padding(
                  //         //               padding:
                  //         //               const EdgeInsets
                  //         //                   .only(left: 0),
                  //         //               child: CircularBorder(
                  //         //                 totalItems: snapshot
                  //         //                     .data[DatabaseKeys
                  //         //                     .statusItemList]
                  //         //                     .length,
                  //         //                 totalSeen: seen,
                  //         //                 width: 2.5,
                  //         //                 size: 65,
                  //         //                 color: snapshot.data
                  //         //                     .data()
                  //         //                     .containsKey(
                  //         //                     widget
                  //         //                         .currentUserNo) ==
                  //         //                     true
                  //         //                     ? snapshot
                  //         //                     .data[DatabaseKeys
                  //         //                     .statusItemList]
                  //         //                     .length >
                  //         //                     0
                  //         //                     ? Colors.teal
                  //         //                     .withOpacity(
                  //         //                     0.8)
                  //         //                     : Colors.grey
                  //         //                     .withOpacity(
                  //         //                     0.8)
                  //         //                     : Colors.grey
                  //         //                     .withOpacity(
                  //         //                     0.8),
                  //         //                 icon: Padding(
                  //         //                   padding:
                  //         //                   const EdgeInsets
                  //         //                       .all(3.0),
                  //         //                   child:
                  //         //                   snapshot
                  //         //                       .data[DatabaseKeys
                  //         //                       .statusItemList]
                  //         //                   [
                  //         //                   snapshot
                  //         //                       .data[DatabaseKeys
                  //         //                       .statusItemList]
                  //         //                       .length -
                  //         //                       1][DatabaseKeys
                  //         //                       .statusItemType] ==
                  //         //                       DatabaseKeys
                  //         //                           .statustypeTEXT
                  //         //                       ? Container(
                  //         //                     width:
                  //         //                     50.0,
                  //         //                     height:
                  //         //                     50.0,
                  //         //                     decoration:
                  //         //                     BoxDecoration(
                  //         //                       color: Color(
                  //         //                           int.parse(
                  //         //                               snapshot
                  //         //                                   .data[DatabaseKeys
                  //         //                                   .statusItemList][snapshot
                  //         //                                   .data[DatabaseKeys
                  //         //                                   .statusItemList]
                  //         //                                   .length -
                  //         //                                   1][DatabaseKeys
                  //         //                                   .statusItemBGCOLOR],
                  //         //                               radix: 16)),
                  //         //                       shape:
                  //         //                       BoxShape.circle,
                  //         //                     ),
                  //         //                     child: const Icon(
                  //         //                         Icons
                  //         //                             .text_fields,
                  //         //                         color:
                  //         //                         Colors
                  //         //                             .white54),
                  //         //                   )
                  //         //                       : snapshot
                  //         //                       .data[DatabaseKeys
                  //         //                       .statusItemList][snapshot
                  //         //                       .data[DatabaseKeys
                  //         //                       .statusItemList]
                  //         //                       .length -
                  //         //                       1][DatabaseKeys
                  //         //                       .statusItemType] ==
                  //         //                       DatabaseKeys
                  //         //                           .statusTypeVideo
                  //         //                       ? Container(
                  //         //                     width:
                  //         //                     50.0,
                  //         //                     height:
                  //         //                     50.0,
                  //         //                     decoration:
                  //         //                     const BoxDecoration(
                  //         //                       color: Colors
                  //         //                           .black87,
                  //         //                       shape: BoxShape
                  //         //                           .circle,
                  //         //                     ),
                  //         //                     child:
                  //         //                     const Icon(Icons
                  //         //                         .play_circle_fill_rounded,
                  //         //                         color: Colors
                  //         //                             .white54),
                  //         //                   )
                  //         //                       : CachedNetworkImage(
                  //         //                     imageUrl:
                  //         //                     snapshot
                  //         //                         .data[DatabaseKeys
                  //         //                         .statusItemList][snapshot
                  //         //                         .data[DatabaseKeys
                  //         //                         .statusItemList]
                  //         //                         .length -
                  //         //                         1][DatabaseKeys
                  //         //                         .statusItemUrl],
                  //         //                     imageBuilder: (
                  //         //                         context,
                  //         //                         imageProvider) =>
                  //         //                         Container(
                  //         //                           width: 50.0,
                  //         //                           height: 50.0,
                  //         //                           decoration: BoxDecoration(
                  //         //                             shape: BoxShape
                  //         //                                 .circle,
                  //         //                             image: DecorationImage(
                  //         //                                 image: imageProvider,
                  //         //                                 fit: BoxFit
                  //         //                                     .cover),
                  //         //                           ),
                  //         //                         ),
                  //         //                     placeholder: (
                  //         //                         context,
                  //         //                         url) =>
                  //         //                         Container(
                  //         //                           width: 50.0,
                  //         //                           height: 50.0,
                  //         //                           decoration: BoxDecoration(
                  //         //                             color: Colors
                  //         //                                 .grey[300],
                  //         //                             shape: BoxShape
                  //         //                                 .circle,
                  //         //                           ),
                  //         //                         ),
                  //         //                     errorWidget: (
                  //         //                         context, url,
                  //         //                         error) =>
                  //         //                         Container(
                  //         //                           width: 50.0,
                  //         //                           height: 50.0,
                  //         //                           decoration: BoxDecoration(
                  //         //                             color: Colors
                  //         //                                 .grey[300],
                  //         //                             shape: BoxShape
                  //         //                                 .circle,
                  //         //                           ),
                  //         //                         ),
                  //         //                   ),
                  //         //                 ),
                  //         //               ),
                  //         //             ),
                  //         //           ),
                  //         //           Positioned(
                  //         //             bottom: 1.0,
                  //         //             right: 1.0,
                  //         //             child: InkWell(
                  //         //               onTap:
                  //         //               observer
                  //         //                   .isAllowCreatingStatus ==
                  //         //                   false
                  //         //                   ? () {
                  //         //                 FiberChatSettings
                  //         //                     .showRationaleToast(
                  //         //                     getTranslated(
                  //         //                         this.context,
                  //         //                         'disabled'));
                  //         //               }
                  //         //                   : () async {
                  //         //                 showMediaOptions(
                  //         //                     ishideTextStatusbutton:
                  //         //                     false,
                  //         //                     phoneVariants:
                  //         //                     widget
                  //         //                         .phoneNumberVariants,
                  //         //                     context:
                  //         //                     context,
                  //         //                     pickVideoCallback:
                  //         //                         () {
                  //         //                       Navigator.push(
                  //         //                           context,
                  //         //                           MaterialPageRoute(
                  //         //                               builder: (
                  //         //                                   context) =>
                  //         //                                   StatusVideoEditor(
                  //         //                                     callback: (
                  //         //                                         v,
                  //         //                                         d,
                  //         //                                         t) async {
                  //         //                                       Navigator
                  //         //                                           .of(
                  //         //                                           context)
                  //         //                                           .pop();
                  //         //                                       await uploadFile(
                  //         //                                           filename: DateTime
                  //         //                                               .now()
                  //         //                                               .millisecondsSinceEpoch
                  //         //                                               .toString(),
                  //         //                                           type: DatabaseKeys
                  //         //                                               .statusTypeVideo,
                  //         //                                           file: d,
                  //         //                                           caption: v,
                  //         //                                           duration: t);
                  //         //                                     },
                  //         //                                     title: getTranslated(
                  //         //                                         context,
                  //         //                                         'createstatus'),
                  //         //                                   )));
                  //         //                     },
                  //         //                     pickImageCallback:
                  //         //                         () {
                  //         //                       Navigator.push(
                  //         //                           context,
                  //         //                           MaterialPageRoute(
                  //         //                               builder: (
                  //         //                                   context) =>
                  //         //                                   StatusImageEditor(
                  //         //                                     callback: (
                  //         //                                         v,
                  //         //                                         d) async {
                  //         //                                       Navigator
                  //         //                                           .of(
                  //         //                                           context)
                  //         //                                           .pop();
                  //         //                                       await uploadFile(
                  //         //                                           filename: DateTime
                  //         //                                               .now()
                  //         //                                               .millisecondsSinceEpoch
                  //         //                                               .toString(),
                  //         //                                           type: DatabaseKeys
                  //         //                                               .statusTypeImage,
                  //         //                                           file: d,
                  //         //                                           caption: v);
                  //         //                                     },
                  //         //                                     title: getTranslated(
                  //         //                                         context,
                  //         //                                         'createstatus'),
                  //         //                                   )));
                  //         //                     });
                  //         //               },
                  //         //               child: Container(
                  //         //                 height: 20,
                  //         //                 width: 20,
                  //         //                 decoration:
                  //         //                 const BoxDecoration(
                  //         //                   color: Colors.green,
                  //         //                   shape:
                  //         //                   BoxShape.circle,
                  //         //                 ),
                  //         //                 child: const Icon(
                  //         //                   Icons.add,
                  //         //                   color: Colors.white,
                  //         //                   size: 15,
                  //         //                 ),
                  //         //               ),
                  //         //             ),
                  //         //           ),
                  //         //         ],
                  //         //       ),
                  //         //       title: InkWell(
                  //         //         onTap: () {
                  //         //           Navigator.push(
                  //         //               context,
                  //         //               MaterialPageRoute(
                  //         //                   builder:
                  //         //                       (context) =>
                  //         //                       StatusView(
                  //         //                         model: widget
                  //         //                             .model!,
                  //         //                         prefs: widget
                  //         //                             .prefs,
                  //         //                         firestoreUserDoc:
                  //         //                         snapshot
                  //         //                             .data,
                  //         //                         currentUserNo:
                  //         //                         widget
                  //         //                             .currentUserNo!,
                  //         //                         statusDoc:
                  //         //                         snapshot
                  //         //                             .data,
                  //         //                         postedByFullName:
                  //         //                         widget
                  //         //                             .currentUserFullName ??
                  //         //                             '',
                  //         //                         postedByPhotoUrl:
                  //         //                         widget
                  //         //                             .currentUserPhotoUrl,
                  //         //                       )));
                  //         //         },
                  //         //         child: Text(
                  //         //           getTranslated(
                  //         //               context, 'mystatus'),
                  //         //           style: const TextStyle(
                  //         //               fontWeight:
                  //         //               FontWeight.bold),
                  //         //         ),
                  //         //       ),
                  //         //       subtitle: InkWell(
                  //         //           onTap: () {
                  //         //             Navigator.push(
                  //         //                 context,
                  //         //                 MaterialPageRoute(
                  //         //                     builder:
                  //         //                         (context) =>
                  //         //                         StatusView(
                  //         //                           model: widget
                  //         //                               .model!,
                  //         //                           prefs: widget
                  //         //                               .prefs,
                  //         //                           currentUserNo:
                  //         //                           widget
                  //         //                               .currentUserNo!,
                  //         //                           statusDoc:
                  //         //                           snapshot
                  //         //                               .data,
                  //         //                           postedByFullName:
                  //         //                           widget
                  //         //                               .currentUserFullName ??
                  //         //                               '',
                  //         //                           postedByPhotoUrl:
                  //         //                           widget
                  //         //                               .currentUserPhotoUrl,
                  //         //                         )));
                  //         //           },
                  //         //           child: Text(
                  //         //             getTranslated(
                  //         //                 context, 'taptoview'),
                  //         //             style: const TextStyle(
                  //         //                 fontSize: 14),
                  //         //           )),
                  //         //       trailing: Container(
                  //         //         alignment:
                  //         //         Alignment.centerRight,
                  //         //         width: 90,
                  //         //         child: Row(
                  //         //           mainAxisAlignment:
                  //         //           MainAxisAlignment
                  //         //               .spaceBetween,
                  //         //           children: [
                  //         //             InkWell(
                  //         //               onTap: snapshot
                  //         //                   .data[DatabaseKeys
                  //         //                   .statusViewerListWithTime]
                  //         //                   .length >
                  //         //                   0
                  //         //                   ? () {
                  //         //                 showViewers(
                  //         //                     context,
                  //         //                     snapshot
                  //         //                         .data,
                  //         //                     contactsProvider
                  //         //                         .filtered,
                  //         //                     widget
                  //         //                         .currentUserNo!,
                  //         //                     widget
                  //         //                         .prefs,
                  //         //                     widget
                  //         //                         .model!);
                  //         //               }
                  //         //                   : () {},
                  //         //               child: Row(
                  //         //                 children: [
                  //         //                   const Icon(Icons
                  //         //                       .visibility),
                  //         //                   const SizedBox(
                  //         //                     width: 2,
                  //         //                   ),
                  //         //                   Text(
                  //         //                     ' ${snapshot
                  //         //                         .data[DatabaseKeys
                  //         //                         .statusViewerList]
                  //         //                         .length}',
                  //         //                     style: const TextStyle(
                  //         //                         fontSize: 14,
                  //         //                         fontWeight:
                  //         //                         FontWeight
                  //         //                             .normal),
                  //         //                   ),
                  //         //                 ],
                  //         //               ),
                  //         //             ),
                  //         //             InkWell(
                  //         //               onTap: () {
                  //         //                 deleteOptions(context,
                  //         //                     snapshot.data);
                  //         //               },
                  //         //               child: const SizedBox(
                  //         //                   width: 25,
                  //         //                   child: Icon(
                  //         //                       Icons.edit)),
                  //         //             )
                  //         //           ],
                  //         //         ),
                  //         //       ),
                  //         //     ),
                  //         //   ),
                  //         // );
                  //       }
                  //       else if (!snapshot.hasData ||
                  //           !snapshot.data.exists) {
                  //         return Container();
                  //         // return Card(
                  //         //   color: Colors.white,
                  //         //   elevation: 0.0,
                  //         //   child: Padding(
                  //         //       padding:
                  //         //       const EdgeInsets.fromLTRB(
                  //         //           0, 8, 8, 8),
                  //         //       child: InkWell(
                  //         //         onTap:
                  //         //         observer
                  //         //             .isAllowCreatingStatus ==
                  //         //             false
                  //         //             ? () {
                  //         //           FiberChatSettings
                  //         //               .showRationaleToast(
                  //         //               getTranslated(
                  //         //                   this.context,
                  //         //                   'disabled'));
                  //         //         }
                  //         //             : () {
                  //         //           showMediaOptions(
                  //         //               ishideTextStatusbutton:
                  //         //               false,
                  //         //               phoneVariants:
                  //         //               widget
                  //         //                   .phoneNumberVariants,
                  //         //               context:
                  //         //               context,
                  //         //               pickVideoCallback:
                  //         //                   () {
                  //         //                 Navigator.push(
                  //         //                     context,
                  //         //                     MaterialPageRoute(
                  //         //                         builder: (
                  //         //                             context) =>
                  //         //                             StatusVideoEditor(
                  //         //                               callback: (
                  //         //                                   v,
                  //         //                                   d,
                  //         //                                   t) async {
                  //         //                                 Navigator
                  //         //                                     .of(
                  //         //                                     context)
                  //         //                                     .pop();
                  //         //                                 await uploadFile(
                  //         //                                     duration: t,
                  //         //                                     filename: DateTime
                  //         //                                         .now()
                  //         //                                         .millisecondsSinceEpoch
                  //         //                                         .toString(),
                  //         //                                     type: DatabaseKeys
                  //         //                                         .statusTypeVideo,
                  //         //                                     file: d,
                  //         //                                     caption: v);
                  //         //                               },
                  //         //                               title: getTranslated(
                  //         //                                   context,
                  //         //                                   'createstatus'),
                  //         //                             )));
                  //         //               },
                  //         //               pickImageCallback:
                  //         //                   () {
                  //         //                 Navigator.push(
                  //         //                     context,
                  //         //                     MaterialPageRoute(
                  //         //                         builder: (
                  //         //                             context) =>
                  //         //                             StatusImageEditor(
                  //         //                               callback: (
                  //         //                                   v,
                  //         //                                   d) async {
                  //         //                                 Navigator
                  //         //                                     .of(
                  //         //                                     context)
                  //         //                                     .pop();
                  //         //                                 await uploadFile(
                  //         //                                     filename: DateTime
                  //         //                                         .now()
                  //         //                                         .millisecondsSinceEpoch
                  //         //                                         .toString(),
                  //         //                                     type: DatabaseKeys
                  //         //                                         .statusTypeImage,
                  //         //                                     file: d,
                  //         //                                     caption: v);
                  //         //                               },
                  //         //                               title: getTranslated(
                  //         //                                   context,
                  //         //                                   'createstatus'),
                  //         //                             )));
                  //         //               });
                  //         //         },
                  //         //         child: ListTile(
                  //         //           leading: Stack(
                  //         //             children: <Widget>[
                  //         //               const CustomCircleAvatar(
                  //         //                   radius: 35),
                  //         //               Positioned(
                  //         //                 bottom: 1.0,
                  //         //                 right: 1.0,
                  //         //                 child: Container(
                  //         //                   height: 20,
                  //         //                   width: 20,
                  //         //                   decoration:
                  //         //                   const BoxDecoration(
                  //         //                     color:
                  //         //                     Colors.green,
                  //         //                     shape: BoxShape
                  //         //                         .circle,
                  //         //                   ),
                  //         //                   child: const Icon(
                  //         //                     Icons.add,
                  //         //                     color:
                  //         //                     Colors.white,
                  //         //                     size: 15,
                  //         //                   ),
                  //         //                 ),
                  //         //               ),
                  //         //             ],
                  //         //           ),
                  //         //           title: Text(
                  //         //             getTranslated(
                  //         //                 context, 'mystatus'),
                  //         //             style: const TextStyle(
                  //         //                 fontWeight:
                  //         //                 FontWeight.bold),
                  //         //           ),
                  //         //           subtitle: Text(
                  //         //             getTranslated(context,
                  //         //                 'taptoupdtstatus'),
                  //         //             style: const TextStyle(
                  //         //                 fontSize: 14),
                  //         //           ),
                  //         //         ),
                  //         //       )),
                  //         // );
                  //       }
                  //       return Container();
                  //       // return Card(
                  //       //   color: Colors.white,
                  //       //   elevation: 0.0,
                  //       //   child: Padding(
                  //       //       padding:
                  //       //       const EdgeInsets.fromLTRB(
                  //       //           0, 8, 8, 8),
                  //       //       child: InkWell(
                  //       //         onTap: () {},
                  //       //         child: ListTile(
                  //       //           leading: Stack(
                  //       //             children: <Widget>[
                  //       //               const CustomCircleAvatar(
                  //       //                   radius: 35),
                  //       //               Positioned(
                  //       //                 bottom: 1.0,
                  //       //                 right: 1.0,
                  //       //                 child: Container(
                  //       //                   height: 20,
                  //       //                   width: 20,
                  //       //                   decoration:
                  //       //                   const BoxDecoration(
                  //       //                     color: Colors.green,
                  //       //                     shape:
                  //       //                     BoxShape.circle,
                  //       //                   ),
                  //       //                   child: const Icon(
                  //       //                     Icons.add,
                  //       //                     color: Colors.white,
                  //       //                     size: 15,
                  //       //                   ),
                  //       //                 ),
                  //       //               ),
                  //       //             ],
                  //       //           ),
                  //       //           title: Text(
                  //       //             getTranslated(
                  //       //                 context, 'mystatus'),
                  //       //             style: const TextStyle(
                  //       //                 fontWeight:
                  //       //                 FontWeight.bold),
                  //       //           ),
                  //       //           subtitle: Text(
                  //       //             getTranslated(
                  //       //                 context, 'loading'),
                  //       //           ),
                  //       //         ),
                  //       //       )),
                  //       // );
                  //     }),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(12, 8, 8, 8),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        CommonText(
                          text:"Recent Updates",
                          // getTranslated(context, 'rcntupdates'),
                              fontColor: Colors.grey,
                              fontWeight: FontWeight.bold
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        // statusProvider
                        //     .searchingContactsStatus ==
                        //     true
                        //     ? Container(
                        //     margin:
                        //     const EdgeInsets.only(right: 17),
                        //     height: 15,
                        //     width: 15,
                        //     color: Colors.transparent,
                        //     child: const Center(
                        //       child: Padding(
                        //         padding:
                        //         EdgeInsets.only(top: 0),
                        //         child: CircularProgressIndicator(
                        //             strokeWidth: 1.5,
                        //             valueColor:
                        //             AlwaysStoppedAnimation<
                        //                 Color>(
                        //                 AppColors.blue)),
                        //       ),
                        //     ))
                        //     : const SizedBox()
                      ],
                    ),
                  ),
                  // statusProvider.searchingContactsStatus == true
                  //     ? Expanded(
                  //   child: Container(color: Colors.white),
                  // )
                  //     : statusProvider.contactsStatus.isEmpty
                  //     ? Expanded(
                  //   child: Container(
                  //       color: Colors.white,
                  //       child: Center(
                  //         child: Padding(
                  //             padding:
                  //             const EdgeInsets.only(
                  //                 top: 40,
                  //                 left: 25,
                  //                 right: 25,
                  //                 bottom: 70),
                  //             child: Text(
                  //               getTranslated(context,
                  //                   'nostatus'),
                  //               textAlign:
                  //               TextAlign.center,
                  //               style: TextStyle(
                  //                   fontSize: 15.0,
                  //                   color: AppColors.grey
                  //                       .withOpacity(
                  //                       0.8),
                  //                   fontWeight:
                  //                   FontWeight
                  //                       .w400),
                  //             )),
                  //       )),
                  // )
                  //     : Expanded(
                  //   child: Container(
                  //       padding:
                  //       const EdgeInsets.fromLTRB(
                  //           0, 8, 8, 8),
                  //       color: Colors.white,
                  //       child: ListView.builder(
                  //         padding: const EdgeInsets.all(10),
                  //         itemCount: statusProvider
                  //             .contactsStatus.length,
                  //         itemBuilder:
                  //             (context, idx) {
                  //           int seen = !statusProvider
                  //               .contactsStatus[
                  //           idx]
                  //               .data()!
                  //               .containsKey(widget
                  //               .currentUserNo)
                  //               ? 0
                  //               : 0;
                  //           if (statusProvider
                  //               .contactsStatus[idx]
                  //               .data()
                  //               .containsKey(widget
                  //               .currentUserNo)) {
                  //             statusProvider
                  //                 .contactsStatus[idx]
                  //             [DatabaseKeys
                  //                 .statusItemList]
                  //                 .forEach((status) {
                  //               if (statusProvider
                  //                   .contactsStatus[
                  //               idx]
                  //                   .data()[widget
                  //                   .currentUserNo]
                  //                   .contains(status[
                  //               DatabaseKeys
                  //                   .statusItemId])) {
                  //                 seen = seen + 1;
                  //               }
                  //             });
                  //           }
                  //           return Consumer<
                  //               AvailableContactsProvider>(
                  //               builder: (context,
                  //                   contactsProvider,
                  //                   _child) =>
                  //                   FutureBuilder<
                  //                       DocumentSnapshot>(
                  //                       future: contactsProvider
                  //                           .getUserDoc(
                  //                           statusProvider
                  //                               .contactsStatus[idx]
                  //                               .data()[DatabaseKeys
                  //                               .statusPublisherPhone]),
                  //                       builder: (BuildContext
                  //                       context,
                  //                           AsyncSnapshot
                  //                           snapshot) {
                  //                         if (snapshot
                  //                             .hasData &&
                  //                             snapshot
                  //                                 .data
                  //                                 .exists) {
                  //                           return InkWell(
                  //                             onTap:
                  //                                 () {
                  //                               Navigator.push(
                  //                                   context,
                  //                                   MaterialPageRoute(
                  //                                       builder: (
                  //                                           context) =>
                  //                                           StatusView(
                  //                                             model: widget
                  //                                                 .model!,
                  //                                             prefs: widget
                  //                                                 .prefs,
                  //                                             firestoreUserDoc: snapshot
                  //                                                 .data,
                  //                                             callback: (
                  //                                                 statuspublisherphone) {
                  //                                               FirebaseFirestore
                  //                                                   .instance
                  //                                                   .collection(
                  //                                                   DatabasePath
                  //                                                       .fireStoreCollectionStatus)
                  //                                                   .doc(
                  //                                                   statuspublisherphone)
                  //                                                   .get()
                  //                                                   .then((
                  //                                                   doc) {
                  //                                                 if (doc
                  //                                                     .exists) {
                  //                                                   int i = statusProvider
                  //                                                       .contactsStatus
                  //                                                       .indexWhere((
                  //                                                       element) =>
                  //                                                   element[DatabaseKeys
                  //                                                       .statusPublisherPhone] ==
                  //                                                       statuspublisherphone);
                  //                                                   statusProvider
                  //                                                       .contactsStatus
                  //                                                       .removeAt(
                  //                                                       i);
                  //                                                   statusProvider
                  //                                                       .contactsStatus
                  //                                                       .insert(
                  //                                                       i,
                  //                                                       doc);
                  //                                                   setState(() {});
                  //                                                 }
                  //                                               });
                  //                                               if (LimitConstants
                  //                                                   .isInterstitialAdShow ==
                  //                                                   true &&
                  //                                                   observer
                  //                                                       .isadmobshow ==
                  //                                                       true) {
                  //                                                 Future
                  //                                                     .delayed(
                  //                                                     const Duration(
                  //                                                         milliseconds: 500), () {
                  //                                                   showInterstitialAd();
                  //                                                 });
                  //                                               }
                  //                                             },
                  //                                             currentUserNo: widget
                  //                                                 .currentUserNo!,
                  //                                             statusDoc: statusProvider
                  //                                                 .contactsStatus[idx],
                  //                                             postedByFullName: snapshot
                  //                                                 .data![DatabaseKeys
                  //                                                 .nickName],
                  //                                             postedByPhotoUrl: snapshot
                  //                                                 .data![DatabaseKeys
                  //                                                 .photoUrl],
                  //                                           )));
                  //                             },
                  //                             child:
                  //                             ListTile(
                  //                               contentPadding: const EdgeInsets
                  //                                   .fromLTRB(
                  //                                   5,
                  //                                   6,
                  //                                   10,
                  //                                   6),
                  //                               leading:
                  //                               Padding(
                  //                                 padding:
                  //                                 const EdgeInsets
                  //                                     .only(
                  //                                     left: 5),
                  //                                 child:
                  //                                 CircularBorder(
                  //                                   totalItems: statusProvider
                  //                                       .contactsStatus[idx][DatabaseKeys
                  //                                       .statusItemList]
                  //                                       .length,
                  //                                   totalSeen: seen,
                  //                                   width: 2.5,
                  //                                   size: 65,
                  //                                   color: statusProvider
                  //                                       .contactsStatus[idx]
                  //                                       .data()
                  //                                       .containsKey(
                  //                                       widget
                  //                                           .currentUserNo)
                  //                                       ? statusProvider
                  //                                       .contactsStatus[idx][DatabaseKeys
                  //                                       .statusItemList]
                  //                                       .length >
                  //                                       0
                  //                                       ? Colors
                  //                                       .teal
                  //                                       .withOpacity(
                  //                                       0.8)
                  //                                       : Colors
                  //                                       .grey
                  //                                       .withOpacity(
                  //                                       0.8)
                  //                                       : Colors
                  //                                       .grey
                  //                                       .withOpacity(
                  //                                       0.8),
                  //                                   icon: Padding(
                  //                                     padding: const EdgeInsets
                  //                                         .all(
                  //                                         3.0),
                  //                                     child: statusProvider
                  //                                         .contactsStatus[idx][DatabaseKeys
                  //                                         .statusItemList][statusProvider
                  //                                         .contactsStatus[idx][DatabaseKeys
                  //                                         .statusItemList]
                  //                                         .length -
                  //                                         1][DatabaseKeys
                  //                                         .statusItemType] ==
                  //                                         DatabaseKeys
                  //                                             .statustypeTEXT
                  //                                         ? Container(
                  //                                       width: 50.0,
                  //                                       height: 50.0,
                  //                                       decoration: BoxDecoration(
                  //                                         color: Color(
                  //                                             int
                  //                                                 .parse(
                  //                                                 statusProvider
                  //                                                     .contactsStatus[idx][DatabaseKeys
                  //                                                     .statusItemList][statusProvider
                  //                                                     .contactsStatus[idx][DatabaseKeys
                  //                                                     .statusItemList]
                  //                                                     .length -
                  //                                                     1][DatabaseKeys
                  //                                                     .statusItemBGCOLOR],
                  //                                                 radix: 16)),
                  //                                         shape: BoxShape
                  //                                             .circle,
                  //                                       ),
                  //                                       child: const Icon(
                  //                                           Icons
                  //                                               .text_fields,
                  //                                           color: Colors
                  //                                               .white54),
                  //                                     )
                  //                                         : statusProvider
                  //                                         .contactsStatus[idx][DatabaseKeys
                  //                                         .statusItemList][statusProvider
                  //                                         .contactsStatus[idx][DatabaseKeys
                  //                                         .statusItemList]
                  //                                         .length -
                  //                                         1][DatabaseKeys
                  //                                         .statusItemType] ==
                  //                                         DatabaseKeys
                  //                                             .statusTypeVideo
                  //                                         ? Container(
                  //                                       width: 50.0,
                  //                                       height: 50.0,
                  //                                       decoration: const BoxDecoration(
                  //                                         color: Colors
                  //                                             .black87,
                  //                                         shape: BoxShape
                  //                                             .circle,
                  //                                       ),
                  //                                       child: const Icon(
                  //                                           Icons
                  //                                               .play_circle_fill_rounded,
                  //                                           color: Colors
                  //                                               .white54),
                  //                                     )
                  //                                         : CachedNetworkImage(
                  //                                       imageUrl: statusProvider
                  //                                           .contactsStatus[idx][DatabaseKeys
                  //                                           .statusItemList][statusProvider
                  //                                           .contactsStatus[idx][DatabaseKeys
                  //                                           .statusItemList]
                  //                                           .length -
                  //                                           1][DatabaseKeys
                  //                                           .statusItemUrl],
                  //                                       imageBuilder: (
                  //                                           context,
                  //                                           imageProvider) =>
                  //                                           Container(
                  //                                             width: 50.0,
                  //                                             height: 50.0,
                  //                                             decoration: BoxDecoration(
                  //                                               shape: BoxShape
                  //                                                   .circle,
                  //                                               image: DecorationImage(
                  //                                                   image: imageProvider,
                  //                                                   fit: BoxFit
                  //                                                       .cover),
                  //                                             ),
                  //                                           ),
                  //                                       placeholder: (
                  //                                           context,
                  //                                           url) =>
                  //                                           Container(
                  //                                             width: 50.0,
                  //                                             height: 50.0,
                  //                                             decoration: BoxDecoration(
                  //                                               color: Colors
                  //                                                   .grey[300],
                  //                                               shape: BoxShape
                  //                                                   .circle,
                  //                                             ),
                  //                                           ),
                  //                                       errorWidget: (
                  //                                           context,
                  //                                           url,
                  //                                           error) =>
                  //                                           Container(
                  //                                             width: 50.0,
                  //                                             height: 50.0,
                  //                                             decoration: BoxDecoration(
                  //                                               color: Colors
                  //                                                   .grey[300],
                  //                                               shape: BoxShape
                  //                                                   .circle,
                  //                                             ),
                  //                                           ),
                  //                                     ),
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               title:Text("hjkljlkjlk"),
                  //                               // Text(
                  //                               //   snapshot
                  //                               //       .data![DatabaseKeys
                  //                               //       .nickName],
                  //                               //   style:
                  //                               //   const TextStyle(
                  //                               //       fontWeight: FontWeight
                  //                               //           .bold),
                  //                               // ),
                  //                               subtitle:Text("jkljlkj")
                  //                               // Text(
                  //                               //   getStatusTime(
                  //                               //       statusProvider
                  //                               //           .contactsStatus[idx][DatabaseKeys
                  //                               //           .statusItemList][statusProvider
                  //                               //           .contactsStatus[idx][DatabaseKeys
                  //                               //           .statusItemList]
                  //                               //           .length -
                  //                               //           1][DatabaseKeys
                  //                               //           .statusItemId],
                  //                               //       this
                  //                               //           .context),
                  //                               //   style:
                  //                               //   const TextStyle(
                  //                               //       height: 1.4),
                  //                               // ),
                  //                             ),
                  //                           );
                  //                         }
                  //                         return InkWell(
                  //                           onTap:
                  //                               () {
                  //                             // Navigator.push(
                  //                             //     context,
                  //                             //     MaterialPageRoute(
                  //                             //         builder: (
                  //                             //             context) =>
                  //                             //             StatusView(
                  //                             //               model: widget
                  //                             //                   .model!,
                  //                             //               prefs: widget
                  //                             //                   .prefs,
                  //                             //               callback: (
                  //                             //                   statuspublisherphone) {
                  //                             //                 FirebaseFirestore
                  //                             //                     .instance
                  //                             //                     .collection(
                  //                             //                     DatabasePath
                  //                             //                         .fireStoreCollectionStatus)
                  //                             //                     .doc(
                  //                             //                     statuspublisherphone)
                  //                             //                     .get()
                  //                             //                     .then((
                  //                             //                     doc) {
                  //                             //                   if (doc
                  //                             //                       .exists) {
                  //                             //                     int i = statusProvider
                  //                             //                         .contactsStatus
                  //                             //                         .indexWhere((
                  //                             //                         element) =>
                  //                             //                     element[DatabaseKeys
                  //                             //                         .statusPublisherPhone] ==
                  //                             //                         statuspublisherphone);
                  //                             //                     statusProvider
                  //                             //                         .contactsStatus
                  //                             //                         .removeAt(
                  //                             //                         i);
                  //                             //                     statusProvider
                  //                             //                         .contactsStatus
                  //                             //                         .insert(
                  //                             //                         i,
                  //                             //                         doc);
                  //                             //                     setState(() {});
                  //                             //                   }
                  //                             //                 });
                  //                             //                 if (LimitConstants
                  //                             //                     .isInterstitialAdShow ==
                  //                             //                     true &&
                  //                             //                     observer
                  //                             //                         .isadmobshow ==
                  //                             //                         true) {
                  //                             //                   Future
                  //                             //                       .delayed(
                  //                             //                       const Duration(
                  //                             //                           milliseconds: 500), () {
                  //                             //                     showInterstitialAd();
                  //                             //                   });
                  //                             //                 }
                  //                             //               },
                  //                             //               currentUserNo: widget
                  //                             //                   .currentUserNo!,
                  //                             //               statusDoc: statusProvider
                  //                             //                   .contactsStatus[idx],
                  //                             //               postedByFullName: statusProvider
                  //                             //                   .joinedUserPhoneStringAsInServer
                  //                             //                   .elementAt(
                  //                             //                   statusProvider
                  //                             //                       .joinedUserPhoneStringAsInServer
                  //                             //                       .toList()
                  //                             //                       .indexWhere((
                  //                             //                       element) =>
                  //                             //                       statusProvider
                  //                             //                           .contactsStatus[idx][DatabaseKeys
                  //                             //                           .statusPublisherPhoneVaiants]
                  //                             //                           .contains(
                  //                             //                           element
                  //                             //                               .phone
                  //                             //                               .toString())))
                  //                             //                   .name
                  //                             //                   .toString(),
                  //                             //               postedByPhotoUrl: null,
                  //                             //             )));
                  //                           },
                  //                           child:
                  //                           ListTile(
                  //                             contentPadding: const EdgeInsets
                  //                                 .fromLTRB(
                  //                                 5,
                  //                                 6,
                  //                                 10,
                  //                                 6),
                  //                             // leading:
                  //                             // Padding(
                  //                             //   padding:
                  //                             //   const EdgeInsets
                  //                             //       .only(
                  //                             //       left: 5),
                  //                             //   child:
                  //                             //   CircularBorder(
                  //                             //     totalItems:
                  //                             //     statusProvider
                  //                             //         .contactsStatus[idx][DatabaseKeys
                  //                             //         .statusItemList]
                  //                             //         .length,
                  //                             //     totalSeen:
                  //                             //     seen,
                  //                             //     width:
                  //                             //     2.5,
                  //                             //     size:
                  //                             //     65,
                  //                             //     color: statusProvider
                  //                             //         .contactsStatus[idx]
                  //                             //         .data()
                  //                             //         .containsKey(
                  //                             //         widget
                  //                             //             .currentUserNo)
                  //                             //         ? statusProvider
                  //                             //         .contactsStatus[idx][DatabaseKeys
                  //                             //         .statusItemList]
                  //                             //         .length >
                  //                             //         0
                  //                             //         ? Colors
                  //                             //         .teal
                  //                             //         .withOpacity(
                  //                             //         0.8)
                  //                             //         : Colors
                  //                             //         .grey
                  //                             //         .withOpacity(
                  //                             //         0.8)
                  //                             //         : Colors
                  //                             //         .grey
                  //                             //         .withOpacity(
                  //                             //         0.8),
                  //                             //     icon:
                  //                             //     Padding(
                  //                             //       padding: const EdgeInsets
                  //                             //           .all(
                  //                             //           3.0),
                  //                             //       child: statusProvider
                  //                             //           .contactsStatus[idx][DatabaseKeys
                  //                             //           .statusItemList][statusProvider
                  //                             //           .contactsStatus[idx][DatabaseKeys
                  //                             //           .statusItemList]
                  //                             //           .length -
                  //                             //           1][DatabaseKeys
                  //                             //           .statusItemType] ==
                  //                             //           DatabaseKeys
                  //                             //               .statustypeTEXT
                  //                             //           ? Container(
                  //                             //         width: 50.0,
                  //                             //         height: 50.0,
                  //                             //         decoration: BoxDecoration(
                  //                             //           color: Color(
                  //                             //               int
                  //                             //                   .parse(
                  //                             //                   statusProvider
                  //                             //                       .contactsStatus[idx][DatabaseKeys
                  //                             //                       .statusItemList][statusProvider
                  //                             //                       .contactsStatus[idx][DatabaseKeys
                  //                             //                       .statusItemList]
                  //                             //                       .length -
                  //                             //                       1][DatabaseKeys
                  //                             //                       .statusItemBGCOLOR],
                  //                             //                   radix: 16)),
                  //                             //           shape: BoxShape
                  //                             //               .circle,
                  //                             //         ),
                  //                             //         child: const Icon(
                  //                             //             Icons
                  //                             //                 .text_fields,
                  //                             //             color: Colors
                  //                             //                 .white54),
                  //                             //       )
                  //                             //           : statusProvider
                  //                             //           .contactsStatus[idx][DatabaseKeys
                  //                             //           .statusItemList][statusProvider
                  //                             //           .contactsStatus[idx][DatabaseKeys
                  //                             //           .statusItemList]
                  //                             //           .length -
                  //                             //           1][DatabaseKeys
                  //                             //           .statusItemType] ==
                  //                             //           DatabaseKeys
                  //                             //               .statusTypeVideo
                  //                             //           ? Container(
                  //                             //         width: 50.0,
                  //                             //         height: 50.0,
                  //                             //         decoration: const BoxDecoration(
                  //                             //           color: Colors
                  //                             //               .black87,
                  //                             //           shape: BoxShape
                  //                             //               .circle,
                  //                             //         ),
                  //                             //         child: const Icon(
                  //                             //             Icons
                  //                             //                 .play_circle_fill_rounded,
                  //                             //             color: Colors
                  //                             //                 .white54),
                  //                             //       )
                  //                             //           : CachedNetworkImage(
                  //                             //         imageUrl: statusProvider
                  //                             //             .contactsStatus[idx][DatabaseKeys
                  //                             //             .statusItemList][statusProvider
                  //                             //             .contactsStatus[idx][DatabaseKeys
                  //                             //             .statusItemList]
                  //                             //             .length -
                  //                             //             1][DatabaseKeys
                  //                             //             .statusItemUrl],
                  //                             //         imageBuilder: (
                  //                             //             context,
                  //                             //             imageProvider) =>
                  //                             //             Container(
                  //                             //               width: 50.0,
                  //                             //               height: 50.0,
                  //                             //               decoration: BoxDecoration(
                  //                             //                 shape: BoxShape
                  //                             //                     .circle,
                  //                             //                 image: DecorationImage(
                  //                             //                     image: imageProvider,
                  //                             //                     fit: BoxFit
                  //                             //                         .cover),
                  //                             //               ),
                  //                             //             ),
                  //                             //         placeholder: (
                  //                             //             context,
                  //                             //             url) =>
                  //                             //             Container(
                  //                             //               width: 50.0,
                  //                             //               height: 50.0,
                  //                             //               decoration: BoxDecoration(
                  //                             //                 color: Colors
                  //                             //                     .grey[300],
                  //                             //                 shape: BoxShape
                  //                             //                     .circle,
                  //                             //               ),
                  //                             //             ),
                  //                             //         errorWidget: (
                  //                             //             context,
                  //                             //             url,
                  //                             //             error) =>
                  //                             //             Container(
                  //                             //               width: 50.0,
                  //                             //               height: 50.0,
                  //                             //               decoration: BoxDecoration(
                  //                             //                 color: Colors
                  //                             //                     .grey[300],
                  //                             //                 shape: BoxShape
                  //                             //                     .circle,
                  //                             //               ),
                  //                             //             ),
                  //                             //       ),
                  //                             //     ),
                  //                             //   ),
                  //                             // ),
                  //                             title:Text("jlkjlkjlk"),
                  //                             // Text(
                  //                             //   statusProvider
                  //                             //       .joinedUserPhoneStringAsInServer
                  //                             //       .elementAt(
                  //                             //       statusProvider
                  //                             //           .joinedUserPhoneStringAsInServer
                  //                             //           .toList()
                  //                             //           .indexWhere((
                  //                             //           element) =>
                  //                             //           statusProvider
                  //                             //               .contactsStatus[idx][DatabaseKeys
                  //                             //               .statusPublisherPhoneVaiants]
                  //                             //               .contains(
                  //                             //               element
                  //                             //                   .phone)))
                  //                             //       .name
                  //                             //       .toString(),
                  //                             //   style:
                  //                             //   const TextStyle(
                  //                             //       fontWeight: FontWeight
                  //                             //           .bold),
                  //                             // ),
                  //                             subtitle:Text("jkhkj")
                  //                             // Text(
                  //                             //   getStatusTime(
                  //                             //       statusProvider
                  //                             //           .contactsStatus[idx][DatabaseKeys
                  //                             //           .statusItemList][statusProvider
                  //                             //           .contactsStatus[idx][DatabaseKeys
                  //                             //           .statusItemList]
                  //                             //           .length -
                  //                             //           1][DatabaseKeys
                  //                             //           .statusItemId],
                  //                             //       this
                  //                             //           .context),
                  //                             //   style:
                  //                             //   const TextStyle(
                  //                             //       height: 1.4),
                  //                             // ),
                  //                           ),
                  //                         );
                  //                       }));
                  //         },
                  //       )),
                  // ),
                ],
              ),
            ),
            // Positioned(
            //   child: statusProvider.isLoading
            //       ? Container(
            //       color: AppConfig.designType ==
            //           ThemeType.whatsapp
            //           ? AppColors.chattingBlack.withOpacity(0.2)
            //           : AppColors.chattingWhite.withOpacity(
            //           0.2),
            //       child: const Center(
            //         child: CircularProgressIndicator(
            //             valueColor:
            //             AlwaysStoppedAnimation<Color>(
            //                 AppColors.blue)),
            //       ))
            //       : Container(),
            // )
          ],
        ),

      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
