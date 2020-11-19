import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:firebase_admob/firebase_admob.dart';

import 'package:mathniac_plus/settings/vars.dart';
import 'package:mathniac_plus/settings/constants.dart';

import 'package:mathniac_plus/tasks/tasks_functions.dart';
import 'package:mathniac_plus/tasks/admob_service.dart';

import 'package:mathniac_plus/widgets/my_button.dart';
import 'package:mathniac_plus/widgets/custom_header.dart';
import 'package:mathniac_plus/widgets/pop_up.dart';

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
    _videoAd
        .load(

            /// TODO
            // adUnitId: RewardedVideoAd.testAdUnitId,
            adUnitId: AdMobService().getRewardedAdId(),
            targetingInfo: targetingInfo)
        .catchError((e) => print("error in loading 1st time"))
        .then((v) => setState(() => _loaded = v));

    // ad listener
    _videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.completed) {
        RewardedVideoAd.instance
            .load(

                /// TODO
                // adUnitId: RewardedVideoAd.testAdUnitId,
                adUnitId: AdMobService().getRewardedAdId(),
                targetingInfo: targetingInfo)
            .catchError((e) => print("error in loading again"))
            .then((v) => setState(() => _loaded = v));
      }

      //On every other event change pass the values to the _handleEvent Method.
      _handleEvent(event, rewardType, 'Reward', rewardAmount);
    };
  }

  @override
  void dispose() {
    // TODO: Remove Rewarded Ad event listener
    RewardedVideoAd.instance.listener = null;

    super.dispose();
  }

  //---- Useful function to know exactly what is being done ----//
  void _handleEvent(RewardedVideoAdEvent event, String rewardType,
      String adType, int rewardAmount) {
    print('\n=== 0 === $event === 0 ===');
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        // print('\n=== 1 === $event === 1 ===');
        // _showSnackBar('New Admob $adType Ad loaded!', 1500);
        break;

      case RewardedVideoAdEvent.opened:
        // print('\n=== 2 === $event === 2 ===');
        // _showSnackBar('Admob $adType Ad opened!', 1500);
        break;

      case RewardedVideoAdEvent.started:
        // print('\n=== 3 === $event === 3 ===');
        // _showSnackBar('Admob $adType Ad started!', 1500);
        break;

      case RewardedVideoAdEvent.completed:
        // print('\n=== 4 === $event === 4 ===');
        // _showSnackBar('Admob $adType Ad completed!', 1500);
        break;

      case RewardedVideoAdEvent.failedToLoad:
        // print('\n=== 5 === $event === 5 ===');
        // _showSnackBar('Admob $adType failed to load.', 1500);
        break;

      case RewardedVideoAdEvent.rewarded:
        // Update level
        UpdateValues().getNewLevelValue();
        vWatchAds = false;

        // print('\n=== 6 === $event === 6 ===');
        print('\n\n=== REWARDED ==');
        // _showSnackBar('Rewarded $rewardAmount', 3000);
        break;

      //This is by calling the video to be loaded when the other rewarded video is closed.
      case RewardedVideoAdEvent.closed:
        // print('\n=== 7 === $event === 7 ===');
        // _videoAd
        //     .load(
        //         /// TODO
        //         adUnitId: RewardedVideoAd.testAdUnitId,
        //         // adUnitId: AdMobService().getRewardedAdId(),
        //         targetingInfo: targetingInfo)
        //     .catchError((e) => print('Error in loading.'));
        // _showSnackBar('Admob $adType Ad closed!', 1500);
        break;

      default:
      // print('\n===== $event =======');
    }
  }

  // //Snackbar shown with ad status
  // void _showSnackBar(String content, int duration) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text(content),
  //     duration: Duration(milliseconds: duration),
  //   ));
  // }

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

    print('\n=== Is Ad loaded: $_loaded ===');

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
              CustomHeader(text: ' Level Up '),

              Visibility(
                visible: !vInternetConnection,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _screenSize.width / 20,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _screenSize.height / 20,
                      ),
                      Container(
                        // width: _buttonWidth / 1.5,
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
              ),
              Spacer(),
              Container(
                width: _buttonWidth,
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
              Spacer(),
              // Builder(
              //   builder: (context) {
              //     return RaisedButton(
              //       onPressed: () {
              //         Scaffold.of(context).showSnackBar(SnackBar(
              //           content: Text('content'),
              //           duration: Duration(milliseconds: 1500),
              //         ));
              //       },
              //     );
              //   },
              // ),
              MyButton(
                contentColor: Colors.yellowAccent,
                onTap: () async {
                  print('\n=== Is Ad loaded onTap: $_loaded ===');
                  if (vWatchAds) {
                    if (_loaded) {
                      await RewardedVideoAd.instance.show().catchError(
                          (e) => print("error in showing ad: ${e.toString()}"));
                      setState(() => _loaded = false);
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
                          });
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
                        });
                  }
                },
                text: ' Watch Ad ',
                textRatio: 3.5,
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
