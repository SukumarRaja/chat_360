import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ntp/ntp.dart';
import '../ui/themes/app_colors.dart';
import '../ui/widgets/common_text.dart';

class FiberSettings {
  static Widget getNTPWrappedWidget(Widget child) {
    return FutureBuilder(
      future: NTP.getNtpOffset(),
      builder: (BuildContext context, AsyncSnapshot<int> snapShot) {
        // if (snapShot.connectionState == ConnectionState.done &&
        //     snapShot.hasData) {
        //   if (snapShot.data! > const Duration(minutes: 1).inMilliseconds ||
        //       snapShot.data! < const Duration(minutes: 1).inMilliseconds) {
        //     return const Material(
        //       color: AppColors.chattingBlack,
        //       child: Center(
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 30.0),
        //           child: CommonText(
        //               // text: getTranslated(context, "cloktime"),
        //             text:"Your clock time is out of sync with the server time. Please set it right to continue",
        //               fontColor: AppColors.chattingWhite),
        //         ),
        //       ),
        //     );
        //   }
        // }
        return child;
      },
    );
  }

  static String getChatId(String? currentUserNo, String? peerNo) {
    if (currentUserNo.hashCode <= peerNo.hashCode) {
      return '$currentUserNo-$peerNo';
    }
    return '$peerNo-$currentUserNo';
  }

  static toast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: AppColors.chattingBlack.withOpacity(0.95),
        textColor: AppColors.chattingWhite);
  }
}
