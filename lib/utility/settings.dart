import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import '../ui/themes/app_colors.dart';
import '../ui/widgets/common_text.dart';
class Settings{
  static Widget getNTPWrappedWidget(Widget child) {
    return FutureBuilder(
      future: NTP.getNtpOffset(),
      builder: (BuildContext context, AsyncSnapshot<int> snapShot) {
        if (snapShot.connectionState == ConnectionState.done &&
            snapShot.hasData) {
          if (snapShot.data! > const Duration(minutes: 1).inMilliseconds ||
              snapShot.data! < const Duration(minutes: 1).inMilliseconds) {
            return const Material(
              color: AppColors.chattingBlack,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: CommonText(
                      // text: getTranslated(context, "cloktime"),
                    text:"Clock Time",
                      fontColor: AppColors.chattingWhite),
                ),
              ),
            );
          }
        }
        return child;
      },
    );
  }
}