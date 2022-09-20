import 'package:chat360/ui/screens/pick_up/pick_up.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../config/app_config.dart';
import '../../../utility/enum.dart';
import '../../themes/app_colors.dart';
import '../../widgets/common_text.dart';

class EditBroadcast extends StatefulWidget {
  const EditBroadcast({Key? key}) : super(key: key);

  @override
  State<EditBroadcast> createState() => _EditBroadcastState();
}

class _EditBroadcastState extends State<EditBroadcast> {
  AdWidget? adWidget;
  @override
  Widget build(BuildContext context) {
    bool admob = false;
    bool bannerAd = false;
    bool loading = false;
    return PickUpLayout(scaffold: Scaffold(
      appBar: AppBar(
        elevation: AppConfig.designType == ThemeType.messenger ? 0.4 : 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: AppConfig.designType == ThemeType.whatsapp
                ? AppColors.chattingWhite
                : AppColors.chattingBlack,
          ),
        ),
        titleSpacing: 0,
        backgroundColor: AppConfig.designType == ThemeType.whatsapp
            ? AppColors.deepGreen
            : AppColors.chattingWhite,
        title: CommonText(
          text: "Edit Broadcast",
          // getTranslated(context, 'editbroadcast'),
            fontSize: 20.0,
            fontColor: AppConfig.designType == ThemeType.whatsapp
                ? AppColors.chattingWhite
                : AppColors.chattingBlack,
            fontWeight: FontWeight.w600,

        ),
        actions: <Widget>[
          TextButton(
            onPressed: (){

            },
            child: CommonText(
              text: "Save",
              // getTranslated(this.context, 'save'),
                fontSize: 16,
                fontColor: AppConfig.designType == ThemeType.whatsapp
                    ? AppColors.chattingWhite
                    : AppColors.chattingGreen,

            ),
          )
        ],
      ),
      body: Stack(
        children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              ListTile(
                  title: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    // controller: controllerName,
                    validator: (v) {
                      return v!.isEmpty
                          // ? getTranslated(context, 'validdetails')
                      ?"validate"
                          : null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(6),
                      labelStyle: const TextStyle(height: 0.8),
                      // labelText: getTranslated(context, 'broadcastname'),
                      labelText: "Broadcast Name"
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              ListTile(
                  title: TextFormField(
                    minLines: 1,
                    maxLines: 10,
                    // controller: controllerDesc,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(6),
                      labelStyle: const TextStyle(height: 0.8),
                      // labelText: getTranslated(context, 'broadcastdesc'),
                      labelText: "Broadcast Description",
                    ),
                  )),
              const SizedBox(
                height: 85,
              ),
              admob == true && bannerAd == true && adWidget != null ? Container(
                  height: MediaQuery.of(context).size.width - 30,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                    bottom: 5.0,
                    top: 2,
                  ),
                  child: adWidget!)
                  : const SizedBox(
                height: 0,
              ),




            ],
          ),


        ),
          Positioned(
            child: loading == true
                ? Container(
                color: AppConfig.designType == ThemeType.whatsapp
                    ? AppColors.chattingBlack.withOpacity(0.8)
                    : AppColors.chattingWhite.withOpacity(0.8),
                child: const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.blue)),
                ))
                : Container(),
          ),
        ],
      ),

    ));
  }
}
