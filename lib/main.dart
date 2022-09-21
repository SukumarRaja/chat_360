import 'package:chat360/ui/screens/pick_up/pick_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

import 'services/admob/admob.dart';
import 'ui/screens/broadcast/add_contact_broadcast.dart';
import 'ui/screens/broadcast/broadcast_details.dart';
import 'ui/screens/broadcast/edit_broadcast.dart';
import 'ui/screens/call/audio.dart';
import 'ui/screens/home/home.dart';
import 'ui/screens/initial/initial.dart';
import 'ui/screens/login/login.dart';

void main() async{

  // if (AppConfig.designType == ThemeType.messenger) {
  //   SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(
  //         statusBarColor: Color(0XFFFFFFFF),
  //         statusBarIconBrightness: Brightness.dark),
  //   );
  // }
  WidgetsFlutterBinding.ensureInitialized();
  AdMobService.initialize();
  await Firebase.initializeApp();

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
            home: InitialPage(),
          ),
        ),
      );
    },
  );
}
