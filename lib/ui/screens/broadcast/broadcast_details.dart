import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat360/ui/screens/pick_up/pick_up.dart';
import 'package:chat360/ui/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../config/app_config.dart';
import '../../../utility/enum.dart';
import '../../themes/app_colors.dart';
import '../../widgets/common_elevated_button.dart';

class BroadcastDetails extends StatefulWidget {
  const BroadcastDetails({Key? key}) : super(key: key);

  @override
  State<BroadcastDetails> createState() => _BroadcastDetailsState();
}

class _BroadcastDetailsState extends State<BroadcastDetails> {
  AdWidget? adWidget;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    bool bannerAd = false;
    bool admob = false;
    bool photoUrl = false;
    bool length = false;
    bool createdBy = false;
    return PickUpLayout(
        scaffold: Scaffold(
      appBar: AppBar(
        elevation: AppConfig.designType == ThemeType.messenger ? 0.4 : 1,
        titleSpacing: -5,
        leading: Container(
          margin: const EdgeInsets.only(right: 0),
          width: 10,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: AppConfig.designType == ThemeType.whatsapp
                  ? AppColors.chattingWhite
                  : AppColors.chattingBlack,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                // Navigator.push(
                //     this.context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             EditBroadcastDetails(
                //               currentUserNo: widget.currentUserNo,
                //               isAdmin: true,
                //               broadcastDesc: broadcastDoc[
                //               DatabaseKeys.broadcastDescription],
                //               broadcastName:
                //               broadcastDoc[DatabaseKeys.broadcastName],
                //               broadcastId: widget.broadcastId,
                //             )));
              },
              icon: Icon(
                Icons.edit,
                size: 21,
                color: AppConfig.designType == ThemeType.whatsapp
                    ? AppColors.chattingWhite
                    : AppColors.chattingBlack,
              ))
        ],
        backgroundColor: AppConfig.designType == ThemeType.whatsapp
            ? AppColors.deepGreen
            : AppColors.chattingWhite,
        title: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                  text: "Broadcast Name",
                  // broadcastDoc[DatabaseKeys.broadcastName],
                  maxLines: 1,
                  overFlow: TextOverflow.ellipsis,
                  fontColor: AppConfig.designType == ThemeType.whatsapp
                      ? AppColors.chattingWhite
                      : AppColors.chattingBlack,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
              const SizedBox(
                height: 4,
              ),
              CommonText(
                  text: "Created By",
                  // '${getTranslated(context, 'createdbyu')}, ${formatDate(broadcastDoc[DatabaseKeys.broadCastCreatedOn].toDate())}',

                  fontColor: AppConfig.designType == ThemeType.whatsapp
                      ? AppColors.chattingWhite
                      : AppColors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ],
          ),
        ),
      ),
      bottomSheet: bannerAd == true && admob == true && adWidget != null
          ? Container(
              height: 60,
              margin: EdgeInsets.only(
                  bottom: Platform.isIOS == true ? 25.0 : 5, top: 0),
              child: Center(child: adWidget),
            )
          : SizedBox(
              height: 0,
            ),
          body: Padding(
            padding: EdgeInsets.only(
                // bottom: IsBannerAdShow == true && observer.isadmobshow == true ? 60 : 0
              bottom: 60

            ),
            child: Stack(
              children: [
                ListView(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: "",
                          // imageUrl:
                          // broadcastDoc[Dbkeys.broadcastPHOTOURL] ??
                          //     '',
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                width: w,
                                height: w / 1.2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                          placeholder: (context, url) => Container(
                            width: w,
                            height: w / 1.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                            ),
                            child: Icon(Icons.campaign,
                                color: AppColors.grey.withOpacity(0.5),
                                size: 75),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: w,
                            height: w / 1.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                            ),
                            child: Icon(Icons.campaign,
                                color: AppColors.grey.withOpacity(0.5),
                                size: 75),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          width: w,
                          height: w / 1.2,
                          decoration: BoxDecoration(
                            // color:
                            // broadcastDoc[Dbkeys.broadcastPHOTOURL] ==
                            //     null
                            //     ? Colors.black.withOpacity(0.2)
                            //     : Colors.black.withOpacity(0.4),
                            color: Colors.black.withOpacity(0.2),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             SingleImagePicker(
                                    //               title: getTranslated(
                                    //                   this.context,
                                    //                   'pickimage'),
                                    //               callback: getImage,
                                    //             ))).then((url) async {
                                    //   if (url != null) {
                                    //     await FirebaseFirestore.instance
                                    //         .collection(DbPaths
                                    //         .collectionbroadcasts)
                                    //         .doc(widget.broadcastID)
                                    //         .update({
                                    //       Dbkeys.broadcastPHOTOURL: url
                                    //     }).then((value) async {
                                    //       DateTime time = DateTime.now();
                                    //       await FirebaseFirestore.instance
                                    //           .collection(DbPaths
                                    //           .collectionbroadcasts)
                                    //           .doc(widget.broadcastID)
                                    //           .collection(DbPaths
                                    //           .collectionbroadcastsChats)
                                    //           .doc(time
                                    //           .millisecondsSinceEpoch
                                    //           .toString() +
                                    //           '--' +
                                    //           widget.currentUserno
                                    //               .toString())
                                    //           .set({
                                    //         Dbkeys.broadcastmsgCONTENT:
                                    //         getTranslated(context,
                                    //             'broadcasticonupdtd'),
                                    //         Dbkeys.broadcastmsgLISToptional:
                                    //         [],
                                    //         Dbkeys.broadcastmsgTIME: time
                                    //             .millisecondsSinceEpoch,
                                    //         Dbkeys.broadcastmsgSENDBY:
                                    //         widget.currentUserno,
                                    //         Dbkeys.broadcastmsgISDELETED:
                                    //         false,
                                    //         Dbkeys.broadcastmsgTYPE: Dbkeys
                                    //             .broadcastmsgTYPEnotificationUpdatedbroadcasticon,
                                    //       });
                                    //     });
                                    //   }
                                    //
                                    //
                                    //   else {}
                                    // });
                                  },
                                  icon: Icon(Icons.camera_alt_rounded,
                                      color: AppColors.chattingWhite, size: 35),
                                ),
                                // broadcastDoc[Dbkeys.broadcastPHOTOURL] == null
                                photoUrl == true
                                    ? SizedBox()
                                    : IconButton(
                                  onPressed: () async {
                                    // Fiberchat.toast(
                                    //   getTranslated(
                                    //       context, 'plswait'),
                                    // );
                                    // await FirebaseStorage.instance
                                    //     .refFromURL(broadcastDoc[
                                    // Dbkeys
                                    //     .broadcastPHOTOURL])
                                    //     .delete()
                                    //     .then((d) async {
                                    //   await FirebaseFirestore
                                    //       .instance
                                    //       .collection(DbPaths
                                    //       .collectionbroadcasts)
                                    //       .doc(widget.broadcastID)
                                    //       .update({
                                    //     Dbkeys.broadcastPHOTOURL:
                                    //     null,
                                    //   });
                                    //   DateTime time =
                                    //   DateTime.now();
                                    //   await FirebaseFirestore
                                    //       .instance
                                    //       .collection(DbPaths
                                    //       .collectionbroadcasts)
                                    //       .doc(widget.broadcastID)
                                    //       .collection(DbPaths
                                    //       .collectionbroadcastsChats)
                                    //       .doc(time
                                    //       .millisecondsSinceEpoch
                                    //       .toString() +
                                    //       '--' +
                                    //       widget.currentUserno
                                    //           .toString())
                                    //       .set({
                                    //     Dbkeys.broadcastmsgCONTENT:
                                    //     getTranslated(context,
                                    //         'broadcasticondlted'),
                                    //     Dbkeys.broadcastmsgLISToptional:
                                    //     [],
                                    //     Dbkeys.broadcastmsgTIME: time
                                    //         .millisecondsSinceEpoch,
                                    //     Dbkeys.broadcastmsgSENDBY:
                                    //     widget.currentUserno,
                                    //     Dbkeys.broadcastmsgISDELETED:
                                    //     false,
                                    //     Dbkeys.broadcastmsgTYPE: Dbkeys
                                    //         .broadcastmsgTYPEnotificationDeletedbroadcasticon,
                                    //   });
                                    // }).catchError((error) async {
                                    //   if (error.toString().contains(Dbkeys.firebaseStorageNoObjectFound1) ||
                                    //       error.toString().contains(
                                    //           Dbkeys
                                    //               .firebaseStorageNoObjectFound2) ||
                                    //       error.toString().contains(
                                    //           Dbkeys
                                    //               .firebaseStorageNoObjectFound3) ||
                                    //       error.toString().contains(
                                    //           Dbkeys
                                    //               .firebaseStorageNoObjectFound4)) {
                                    //     await FirebaseFirestore
                                    //         .instance
                                    //         .collection(DbPaths
                                    //         .collectionbroadcasts)
                                    //         .doc(widget.broadcastID)
                                    //         .update({
                                    //       Dbkeys.broadcastPHOTOURL:
                                    //       null,
                                    //     });
                                    //   }
                                    // });
                                  },
                                  icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: AppColors.chattingWhite,
                                      size: 35),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              CommonText(
                                text:"Description",
                                // getTranslated(context, 'desc'),
                                textAlign: TextAlign.left,
                                    fontWeight: FontWeight.bold,
                                    fontColor: AppColors.chattingGreen,
                                    fontSize: 16
                              ),
                              IconButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     this.context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             EditBroadcastDetails(
                                    //               currentUserNo: widget
                                    //                   .currentUserNo,
                                    //               isAdmin: true,
                                    //               broadcastDesc:
                                    //               broadcastDoc[DatabaseKeys
                                    //                   .broadcastDescription],
                                    //               broadcastName:
                                    //               broadcastDoc[DatabaseKeys
                                    //                   .broadcastName],
                                    //               broadcastId:
                                    //               widget.broadcastId,
                                    //             )));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.grey,
                                  ))
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 7,
                          ),
                          CommonText(
                            text: "No Description",
                            // broadcastDoc[DatabaseKeys.broadcastDescription] ==
                            //     ''
                            //     ? getTranslated(context, 'nodesc')
                            //     : broadcastList
                            //     .lastWhere((element) =>
                            // element
                            //     .docMap[DatabaseKeys.broadCastId] ==
                            //     widget.broadcastId)
                            //     .docMap[DatabaseKeys.broadcastDescription],
                            textAlign: TextAlign.left,
                                fontWeight: FontWeight.normal,
                                fontColor: AppColors.chattingBlack,
                                fontSize: 15.3
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    CommonText(
                                      text: "20 recipents",
                                      // '${broadcastList.lastWhere((element) => element.docMap[DatabaseKeys.broadCastId] == widget.broadcastId).docMap[DatabaseKeys.broadcastMembersList].length} ${getTranslated(context, 'recipients')}  ',
                                      textAlign: TextAlign.left,
                                          fontWeight: FontWeight.bold,
                                          fontColor: AppColors.chattingGreen,
                                          fontSize: 16
                                    ),
                                    // Text(
                                    //   '${broadcastList.firstWhere((element) => element.docMap[DatabaseKeys.broadCastId] == widget.broadcastId).docMap[DatabaseKeys.groupMEMBERSLIST].length}',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 16),
                                    // ),
                                  ],
                                ),
                              ),
                              // (broadcastDoc[DatabaseKeys.broadcastMembersList]
                              //     .length >=
                              //     observer.broadcastMemberslimit)
                        length == true
                                  ? const SizedBox()
                                  : InkWell(
                                onTap: () {
                                  // final AvailableContactsProvider
                                  // dbcontactsProvider = Provider
                                  //     .of<AvailableContactsProvider>(
                                  //     context,
                                  //     listen: false);
                                  // dbcontactsProvider.fetchContacts(
                                  //     context,
                                  //     widget.model,
                                  //     widget.currentUserNo,
                                  //     widget.prefs);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             AddContactsToBroadcast(
                                  //               currentUserNo: widget
                                  //                   .currentUserNo,
                                  //               model: widget.model,
                                  //               biometricEnabled:
                                  //               false,
                                  //               prefs: widget.prefs,
                                  //               broadcastId: widget
                                  //                   .broadcastId,
                                  //               isAddingWhileCreatingBroadcast:
                                  //               false,
                                  //             )));
                                },
                                child: SizedBox(
                                  height: 50,
                                  // width: 70,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: const [
                                      SizedBox(
                                        width: 30,
                                        child: Icon(Icons.add,
                                            size: 19,
                                            color:
                                            AppColors.lightGreen),
                                      ),
                                      // Text(
                                      //   'ADD ',
                                      //   style: TextStyle(
                                      //       fontWeight:
                                      //           FontWeight.bold,
                                      //       color:
                                      //           AppColors.lightGreen),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Divider(),
                          // getUsersList(),
                        ],
                      ),
                    ),
                    // widget.currentUserNo ==
                    //     broadcastDoc[DatabaseKeys.broadCastCreatedBy]
              createdBy == false
                        ? InkWell(
                      onTap: () {
                        showDialog(
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: CommonText(
                                text: "Delete Broadcast",
                                // getTranslated(
                                //     context, 'deletebroadcast'),
                              ),
                              actions: [
                                // ignore: deprecated_member_use
                                CommonElevatedButton(
                                  child: CommonText(
                                    text:"Cancel",
                                    // getTranslated(
                                    //     context, 'cancel'),
                                        fontColor: AppColors.chattingGreen,
                                        fontSize: 18
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                // // ignore: deprecated_member_use
                                CommonElevatedButton(
                                  child: CommonText(
                                    text:"Delete",
                                    // getTranslated(
                                    //     context, 'delete'),
                                        fontColor: Colors.red,
                                        fontSize: 18
                                  ),
                                  onPressed: () async {

                                    // Future.delayed(
                                    //     const Duration(
                                    //         milliseconds: 500),
                                    //         () async {
                                    //       await FirebaseFirestore
                                    //           .instance
                                    //           .collection(DatabasePath
                                    //           .fireStoreCollectionBroadCast)
                                    //           .doc(widget.broadcastId)
                                    //           .get()
                                    //           .then((doc) async {
                                    //         await doc.reference
                                    //             .delete();
                                    //         //No need to delete the media data from here as it will be deleted automatically using Cloud functions deployed in Firebase once the .doc is deleted .
                                    //       });
                                    //     });
                                  },
                                )
                              ],
                            );
                          },
                          context: context,
                        );
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin:
                          const EdgeInsets.fromLTRB(10, 30, 10, 30),
                          width: MediaQuery.of(context).size.width,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: Colors.red[700],
                            borderRadius:
                            BorderRadius.circular(5.0),
                          ),
                          child: CommonText(
                            text: "Delete Broadcast",
                            // getTranslated(
                            //     context, 'deletebroadcast'),
                                fontColor: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                          )),
                    )
                        : const SizedBox()

                  ],
                ),
                Positioned(
                  child: createdBy== true
                      ? Container(
                      color: AppConfig.designType == ThemeType.whatsapp
                          ? AppColors.chattingBlack.withOpacity(0.6)
                          : AppColors.chattingWhite.withOpacity(0.6),
                      child: const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.blue)),
                      ))
                      : Container(),
                )


              ],
            ),
          ),
    ),
    );
  }
}
