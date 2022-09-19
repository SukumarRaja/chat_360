import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

//Ids for interstitial Ad
const androidInterstitialAdId = 'ca-app-pub-3940256099942544/1033173712';
const iosInterstitialAdId = 'ca-app-pub-3940256099942544/4411468910';

//Ids for banner Ad
const androidBannerAdId = 'ca-app-pub-3940256099942544/6300978111';
const iosBannerAdId = 'ca-app-pub-3940256099942544/2934735716';

class AdMobService {
  static String get bannerAdId =>
      Platform.isAndroid ? androidBannerAdId : iosBannerAdId;

  static String get interstitialAdId =>
      Platform.isAndroid ? androidInterstitialAdId : iosInterstitialAdId;

  static InterstitialAd? _interstitialAd;
  static int _numInterstitialLoadAttempts = 0;
  static int maxFailedLoadAttempts = 3;

  static initialize() {
    MobileAds.instance.initialize();
  }

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: bannerAdId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        // Called when an ad is successfully received.

        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Called when an ad request failed.
          ad.dispose();
          print('Ad failed to load: $error');
        },

        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad opens an overlay that covers the screen.

        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an ad removes an overlay that covers the screen.

        onAdImpression: (Ad ad) => print(
            'Ad impression.'), // Called when an impression occurs on the ad.
      ),
    );
  }

  static void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitialAdId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  static void showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
