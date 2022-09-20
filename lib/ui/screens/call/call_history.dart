import 'dart:io';

import 'package:chat360/ui/widgets/common_text.dart';
import 'package:chat360/ui/widgets/common_text.dart';
import 'package:chat360/ui/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../config/limit_constants.dart';
import '../../themes/app_colors.dart';
import '../infinite_list/infinite_list.dart';

class CallHistory extends StatefulWidget {
  const CallHistory({Key? key}) : super(key: key);

  @override
  State<CallHistory> createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  AdWidget? adWidget;

  @override
  Widget build(BuildContext context) {
    bool admob = false;
    bool receivedDoc = false;
    return Scaffold(
      key: scaffold,
      backgroundColor: AppColors.chattingWhite,
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
      floatingActionButton: receivedDoc == false
          ? const SizedBox()
          : Padding(
              padding: EdgeInsets.only(
                  bottom: LimitConstants.isBannerAdShow == true && admob == true
                      ? 60
                      : 0),
              child: FloatingActionButton(
                heroTag: "clear",
                backgroundColor: AppColors.chattingWhite,
                onPressed: () {
                  showDialog(
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const CommonText(
                          text: "Clear Log",
                          // getTranslated(context, 'clearlog')
                        ),
                        content: const CommonText(
                          text: "Clear Log Long",
                          // getTranslated(context, 'clearloglong')
                        ),
                        actions: [
                          // ignore: deprecated_member_use
                          ElevatedButton(
                            child: const CommonText(
                                text: "Cancel",
                                // getTranslated(context, 'cancel'),
                                fontColor: AppColors.chattingGreen,
                                fontSize: 18),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          // ignore: deprecated_member_use
                          ElevatedButton(
                            child: const CommonText(
                                text: "Delete",
                                // getTranslated(context, 'delete'),
                                fontColor: Colors.red,
                                fontSize: 18),
                            onPressed: () async {
                              // Navigator.of(context).pop();
                              // FiberChatSettings.toast(
                              //     getTranslated(context, 'plswait'));
                              // FirebaseFirestore.instance
                              //     .collection(
                              //     DatabasePath.fireStoreCollectionUsers)
                              //     .doc(widget.userPhone)
                              //     .collection(DatabasePath.callHistory)
                              //     .get()
                              //     .then((snapshot) {
                              //   for (DocumentSnapshot doc
                              //   in snapshot.docs) {
                              //     doc.reference.delete();
                              //   }
                              // }).then((value) {
                              //   firestoreDataProvider.clearAll();
                              // });
                            },
                          )
                        ],
                      );
                    },
                    context: context,
                  );
                },
              ),
            ),
      body: const InfiniteListView(datatype: "Call History",),
    );
  }
}
