import 'dart:io';

import '../settings/constants.dart';

class AdMobService {
  String? getAdMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-4259634083772880~8976810502'; // mine
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-4259634083772880~7378704091'; // mine
    }
    return null;
  }

  String? getBannerAdId() {
    if (Platform.isIOS) {
      if (kTestAds) {
        return 'ca-app-pub-3940256099942544/2934735716';
      } else {
        return "ca-app-pub-4259634083772880/7531866890"; // mine
      }
    } else if (Platform.isAndroid) {
      if (kTestAds) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else {
        return "ca-app-pub-4259634083772880/3567451592"; // mine
      }
    }
    return null;
  }

  String? getInterstitialAdId() {
    if (Platform.isIOS) {
      if (kTestAds) {
        // Interstitial Video
        return 'ca-app-pub-3940256099942544/5135589807';
        // // Interstitial
        // return 'ca-app-pub-3940256099942544/4411468910';
      } else {
        return 'ca-app-pub-3940256099942544/4411468910';
      }
    } else if (Platform.isAndroid) {
      if (kTestAds) {
        // Interstitial Video
        return 'ca-app-pub-3940256099942544/8691691433';
        // // Interstitial
        // return '	ca-app-pub-3940256099942544/1033173712';
      } else {
        return "ca-app-pub-4259634083772880/1684402590"; // mine
      }
    }
    return null;
  }

  String? getRewardedAdId() {
    if (Platform.isIOS) {
      if (kTestAds) {
        return 'ca-app-pub-3940256099942544/1712485313';
      } else {
        return "ca-app-pub-4259634083772880/4905703552"; // mine
      }
    } else if (Platform.isAndroid) {
      if (kTestAds) {
        return 'ca-app-pub-3940256099942544/5224354917';
      } else {
        return "ca-app-pub-4259634083772880/3212405984"; // mine
      }
    }
    return null;
  }

  // InterstitialAd getNewTripInterstitial() {
  //   return InterstitialAd(
  //     adUnitId: getInterstitialAdId(),
  //     listener: (MobileAdEvent event) {
  //       print("InterstitialAd event is $event");
  //     },
  //   );
  // }

  // static BannerAd _homeBannerAd;
  //
  // static BannerAd _getHomePageBannerAd() {
  //   return BannerAd(adUnitId: _getBannerAdId(), size: AdSize.smartBanner);
  // }

  // static void showHomeBannerAd() {
  //   if (_homeBannerAd == null) _homeBannerAd = _getHomePageBannerAd();
  //   _homeBannerAd
  //     ..load()
  //     ..show(
  //         anchorType: AnchorType.bottom,
  //         anchorOffset: kBottomNavigationBarHeight);
  // }
  //
  // static void hideHomeBannerAd() async {
  //   await _homeBannerAd.dispose();
  //   _homeBannerAd = null;
  // }
}
