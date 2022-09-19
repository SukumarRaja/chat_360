import 'package:chat_360/ui/screens/pick_up/pick_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

import 'services/admob/admob.dart';
import 'ui/screens/home/home.dart';
import 'ui/screens/login/login.dart';

void main() {

  // if (AppConfig.designType == ThemeType.messenger) {
  //   SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(
  //         statusBarColor: Color(0XFFFFFFFF),
  //         statusBarIconBrightness: Brightness.dark),
  //   );
  // }
  WidgetsFlutterBinding.ensureInitialized();
  AdMobService.initialize();

  // if (LimitConstants.isBannerAdShow == true ||
  //     LimitConstants.isInterstitialAdShow == true ||
  //     LimitConstants.isVideoAdShow == true) {
  //   MobileAds.instance.initialize();
  // }

  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();

  binding.renderView.automaticSystemUiAdjustment = false;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        const OverlaySupport.global(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginPage(),
          ),
        ),
      );
    },
  );
}
