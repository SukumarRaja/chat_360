import 'dart:io';
import 'package:chat_360/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../config/limit_constants.dart';

class SearchContacts extends StatefulWidget {
  const SearchContacts({Key? key}) : super(key: key);

  @override
  State<SearchContacts> createState() => _SearchContactsState();
}

class _SearchContactsState extends State<SearchContacts> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  AdWidget? adWidget;
  TextEditingController filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool admob = false;

    return Scaffold(
      key: scaffoldState,
      backgroundColor: AppColors.chattingWhite,
      bottomSheet: LimitConstants.isBannerAdShow == true &&
              admob == true &&
              adWidget != null
          ? Container(
              height: 60,
              margin: EdgeInsets.only(
                  bottom: Platform.isIOS == true ? 25.0 : 5, top: 0),
              child: Center(child: adWidget))
          : const SizedBox(
              height: 0,
            ),
      body: ListView(
        padding: LimitConstants.isBannerAdShow == true && admob == true
            ? const EdgeInsets.fromLTRB(5, 5, 5, 60)
            : const EdgeInsets.all(5),
        shrinkWrap: true,
        children: [
          Container(
            height: 77,
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 7),
            child: TextField(
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              controller: filterController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                // hintText: getTranslated(context, 'search_recentchats'),
                hintText: "Search Recent Chats",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.grey[100]!, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(
                    color: Colors.grey[100]!,
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          // _chats(_model.userData, _model.currentUser),
        ],
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    // if (LimitConstants.isBannerAdShow == true) {
    //   myBanner.dispose();
    // }
  }
}
