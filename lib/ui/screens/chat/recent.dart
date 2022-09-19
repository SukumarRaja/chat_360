import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../config/limit_constants.dart';
import '../../themes/app_colors.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({Key? key}) : super(key: key);

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  AdWidget? adWidget;

  @override
  Widget build(BuildContext context) {
    bool admob = false;
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
        // child: chats(model.userData, model.currentUser),
        child: Container(),
      ),
    );
  }
}
