import 'dart:io';

import '../../config/app_config.dart';

String? getBannerAdUnitId() {
  if (Platform.isIOS) {
    return AppConfig.admobBannerAdUnitIdIos;
  } else if (Platform.isAndroid) {
    return AppConfig.admobBannerAdUnitIdAndroid;
  }
  return null;
}

String? getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return AppConfig.admobInterstitialAdUnitIdIos;
  } else if (Platform.isAndroid) {
    return AppConfig.admobBannerAdUnitIdAndroid;
  }
  return null;
}

String? getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return AppConfig.admobRewardedAdUnitIdIos;
  } else if (Platform.isAndroid) {
    return AppConfig.admobRewardedAdUnitIdAndroid;
  }
  return null;
}
