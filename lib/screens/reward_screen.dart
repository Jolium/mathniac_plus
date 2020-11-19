import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:mathniac_plus/tasks/admob_service.dart';

import 'package:mathniac_plus/settings/vars.dart';
import 'package:mathniac_plus/settings/constants.dart';

import 'package:mathniac_plus/widgets/my_button.dart';
import 'package:mathniac_plus/widgets/custom_header.dart';

import 'package:mathniac_plus/screens/home_screen.dart';

class RewardScreen extends StatefulWidget {
  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  double _widthRatio = 1.1;
  double _heightRatio = 1.1;
  double _borderRatio = 10;
  double _marginRatio = 20;
  double _textRatio = 20;

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'games',
      'flutter',
      'math',
      'strategy',
      'hobby',
      'google play',
      'flutterio',
      'beautiful apps'
    ],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );

  bool _loaded = false;

  //An instance to be called in the init state
  RewardedVideoAd _videoAd = RewardedVideoAd.instance;

  @override
  void initState() {
    super.initState();

    // load ad in the beginning
    RewardedVideoAd.instance
        .load(
            // adUnitId: RewardedVideoAd.testAdUnitId,
            adUnitId: AdMobService().getRewardedAdId(),
            targetingInfo: targetingInfo)
        .catchError((e) => print("error in loading 1st time"))
        .then((v) => setState(() => _loaded = v));

    print('\n1 === Ads: $_loaded ===');

    // ad listener
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.closed) {
        RewardedVideoAd.instance
            .load(

                /// TODO
                adUnitId: RewardedVideoAd.testAdUnitId,
                // adUnitId: AdMobService().getRewardedAdId(),
                targetingInfo: targetingInfo)
            .catchError((e) => print("error in loading again"))
            .then((v) => setState(() => _loaded = v));
      }

      print('\n2 === Ads: $_loaded ===');

      //On every other event change pass the values to the _handleEvent Method.
      _handleEvent(event, rewardType, 'Reward', rewardAmount);
    };

    //This will load the video when the widget is built for the first time.
    _videoAd
        .load(

            /// TODO
            adUnitId: RewardedVideoAd.testAdUnitId,
            // adUnitId: AdMobService().getRewardedAdId(),
            targetingInfo: targetingInfo)
        .catchError((e) => print('Error in loading.'));
  }

  //---- Useful function to know exactly what is being done ----//
  void _handleEvent(RewardedVideoAdEvent event, String rewardType,
      String adType, int rewardAmount) {
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        _showSnackBar('New Admob $adType Ad loaded!', 1500);
        break;
      case RewardedVideoAdEvent.opened:
        _showSnackBar('Admob $adType Ad opened!', 1500);
        break;

      //This is by calling the video to be loaded when the other rewarded video is closed.
      case RewardedVideoAdEvent.closed:
        _showSnackBar('Admob $adType Ad closed!', 1500);
        _videoAd
            .load(

                /// TODO
                adUnitId: RewardedVideoAd.testAdUnitId,
                // adUnitId: AdMobService().getRewardedAdId(),
                targetingInfo: targetingInfo)
            .catchError((e) => print('Error in loading.'));
        break;
      case RewardedVideoAdEvent.failedToLoad:
        _showSnackBar('Admob $adType failed to load.', 1500);
        break;
      case RewardedVideoAdEvent.rewarded:
        _showSnackBar('Rewarded $rewardAmount', 3000);
        print('\n\n=== REWARDED ==');
        break;
      default:
    }
  }

  //Snackbar shown with ad status
  void _showSnackBar(String content, int duration) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: duration),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    double _textSize = _buttonSize / _textRatio;
    double _borderRadius = _buttonSize / _borderRatio;
    double _edgeInsets = _buttonSize / _marginRatio;
    // double _shadowRadius = _buttonHeight / _marginRatio;

    print('\n3 === Ads: $_loaded ===');

    return Scaffold(
      body: Container(
        decoration: vBackground
            ? vMagicLevel == 15
                ? kBackground15
                : kBackgroundOn
            : kBackgroundOff,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: _screenSize.height / 30,
              ),
              CustomHeader(text: ' Hint '),
              Spacer(),
              Container(
                width: _buttonWidth,
                alignment: Alignment.center,
                padding: EdgeInsets.all(_edgeInsets),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.white, width: _edgeInsets / 4),
                  color: Colors.black.withAlpha(155),
                  borderRadius: BorderRadius.all(
                    Radius.circular(_borderRadius),
                  ),
                ),
                child: Text(
                  'See Ads',
                  textAlign: TextAlign.justify,
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
              MyButton(
                onTap: () async {
                  await RewardedVideoAd.instance.show().catchError(
                      (e) => print("error in showing ad: ${e.toString()}"));
                  setState(() => _loaded = false);
                },
                text: ' Ads ',
                // navigator: HomeScreen(),
              ),
              Spacer(),
              MyButton(
                onTap: () {},
                text: ' Home ',
                navigator: HomeScreen(),
              ),
              SizedBox(
                height: _screenSize.height / 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
