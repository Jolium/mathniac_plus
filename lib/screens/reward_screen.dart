import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../settings/backgrounds.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/admob_service.dart';
import '../tasks/tasks_functions.dart';
import '../widgets/custom_header.dart';
import '../widgets/my_button.dart';
import '../widgets/pop_up.dart';
import 'home_screen.dart';

class RewardScreen extends StatefulWidget {
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final double _widthRatio = 1.1;
  final double _heightRatio = 1.1;
  final double _borderRatio = 10;
  final double _marginRatio = 20;
  final double _textRatio = 20;

  /// Ad button active
  bool _adButtonActive = false;

  RewardedAd? _rewardedAd;
  bool _rewardedReady = false;

  Timer? timer;

  int _counter = 5;

  static final AdRequest request = AdRequest(
    testDevices: listOfTestDevices, // Android emulators are test devices
    // testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: listOfKeyWords,
    contentUrl: 'https://play.google.com/store/apps/category/GAME_CASUAL',
    nonPersonalizedAds: true,
  );

  void counter() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _counter--;
      });
      if (_counter == 0) {
        timer.cancel();
      }
    });
  }

  void createRewardedAd() {
    try {
      _rewardedAd ??= RewardedAd(
        // adUnitId: RewardedAd.testAdUnitId,
        adUnitId: _rewardedUnitId!,
        request: request,
        listener: AdListener(onAdLoaded: (Ad ad) {
          // print('${ad.runtimeType} loaded.');
          _rewardedReady = true;
          setState(() {
            _adButtonActive = true;
          });
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // print('${ad.runtimeType} failed to load: $error');
          ad.dispose();
          // _rewardedAd = null;
          createRewardedAd();
        }, onAdOpened: (Ad ad) {
          // print('${ad.runtimeType} onAdOpened.');
        }, onAdClosed: (Ad ad) {
          // print('${ad.runtimeType} closed.');
          ad.dispose();
          createRewardedAd();
        }, onApplicationExit: (Ad ad) {
          // print('${ad.runtimeType} onApplicationExit.');
        }, onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
          UpdateValues().getNewLevelValue();
          vWatchAds = false;
          // print(
          //   '$RewardedAd with reward $RewardItem(${reward.amount}, ${reward.type})',
          // );
        }),
      )..load();
    } catch (e) {
      /// Do something if error
      // print('== ERROR: $e ==');
    }
  }

  /// Rewarded Unit Id
  late final String? _rewardedUnitId = AdMobService().getRewardedAdId();

  @override
  void initState() {
    super.initState();
    // print('vWatchAds: $vWatchAds');
    /// Check if allowed to watch ads
    if (vWatchAds) {
      /// load ad in the beginning
      MobileAds.instance.initialize().then((InitializationStatus status) {
        // print('Initialization done: ${status.adapterStatuses}');
        MobileAds.instance
            .updateRequestConfiguration(RequestConfiguration(
                tagForChildDirectedTreatment:
                    TagForChildDirectedTreatment.unspecified))
            .then((value) {
          createRewardedAd();
        });
      });

      /// Start counter
      counter();

      /// If NOT allowed to watch ads
    } else {
      /// Activate button to show pop-up showing warning 'You have to play at least 1 time...'
      _adButtonActive = true;
    }
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();

    /// Cancel timer if navigate to other screen before reach 0
    if (timer!.isActive) {
      timer!.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    final double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    final double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _textSize = _buttonSize / _textRatio;
    final double _borderRadius = _buttonSize / _borderRatio;
    final double _edgeInsets = _buttonSize / _marginRatio;

    return Scaffold(
      body: Container(
        decoration: vBackground
            ? vMagicLevel == 15
                ? kBackground15
                : kBackgroundOn
            : kBackgroundOff,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenSize.width / 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: _screenSize.height / 60),
                const CustomHeader(text: ' Level Up '),
                Visibility(
                  visible: !vInternetConnection,
                  child: Column(
                    children: [
                      SizedBox(
                        height: _screenSize.height / 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(_edgeInsets),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: _edgeInsets / 4,
                          ),
                          color: Colors.black.withAlpha(155),
                          borderRadius: BorderRadius.all(
                            Radius.circular(_borderRadius / 1.5),
                          ),
                        ),
                        child: Text(
                          'Probably you have no internet connection!\n'
                          '-----\n'
                          'Level Up is not possible.',
                          // 'Turn your internet on and restart the application.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _textSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _screenSize.height / 30,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(_edgeInsets),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.white, width: _edgeInsets / 6),
                    color: Colors.black.withAlpha(155),
                    borderRadius: BorderRadius.all(
                      Radius.circular(_borderRadius / 1.5),
                    ),
                  ),
                  child: Text(
                    vMagicLevel < 15
                        ? 'Watch this ad to move to the next level.\n\n'
                            'Currently you are on Level $vMagicLevel and after watching '
                            'this ad you will move to Level ${vMagicLevel + 1}.\n\n'
                            'You have to play at least 1 time the new unlocked level before watch a new ad.'
                        : 'Watch this ad to move to the next level.\n\n'
                            'Currently you are on Level 15 and after watching '
                            'this ad you will move to Level 15.\n\n'
                            'You have to play at least 1 time the new unlocked level before watch a new ad.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _textSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                MyButton(
                  contentColor:
                      _adButtonActive ? Colors.yellowAccent : Colors.grey,
                  text: _adButtonActive ? ' Watch Ad ' : ' Loading $_counter ',
                  textRatio: 3.5,
                  active: _adButtonActive,
                  decreaseSizeOnTap: false,
                  onTap: () async {
                    // print('\n=== Is Ad loaded onTap: $_rewardedReady ===');
                    if (vWatchAds) {
                      if (_rewardedReady) {
                        _rewardedAd!.show().catchError((e) => showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PopUp(
                                  title: 'Something went wrong!',
                                  content:
                                      "error in showing ad: ${e.toString()}",
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ));
                        setState(() => _rewardedReady = false);
                        // _rewardedAd = null;
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PopUp(
                              title: 'Something went wrong!',
                              content:
                                  '\nAt this moment is not possible to show Ads.\n'
                                  'Please, try it again later.',
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PopUp(
                            title: 'Not authorized!',
                            content:
                                '\nYou have to play at least 1 time the new unlocked level before watch a new ad.',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    }
                  },
                ),
                const Spacer(),
                MyButton(onTap: () {}, text: ' Home ', navigator: HomeScreen()),
                SizedBox(height: _screenSize.height / 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
