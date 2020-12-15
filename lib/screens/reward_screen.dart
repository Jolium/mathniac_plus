import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// import 'package:device_info/device_info.dart';
import 'package:firebase_admob/firebase_admob.dart';
// import 'package:admob_flutter/admob_flutter.dart';

import '../settings/lists.dart';
import '../settings/vars.dart';
import '../settings/constants.dart';

import '../tasks/tasks_functions.dart';
import '../tasks/admob_service.dart';

import '../widgets/my_button.dart';
import '../widgets/custom_header.dart';
import '../widgets/pop_up.dart';

import 'home_screen.dart';

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
    keywords: listOfKeyWords,
    contentUrl: 'https://play.google.com/store/apps',
    childDirected: false,
    nonPersonalizedAds: true,
    testDevices:
        listOfTestDevices, // Android emulators are considered test devices
  );

  bool _loaded = false;

  // Ad button active
  bool _adButtonActive = false;

  //An instance to be called in the init state
  RewardedVideoAd _videoAd = RewardedVideoAd.instance;

  // Rewarded Unit Id
  String _rewardedUnitId = AdMobService().getRewardedAdId();

  @override
  void initState() {
    super.initState();

    // print(' Unit ID: $_rewardedUnitId');

    if (vWatchAds) {
      // load ad in the beginning
      _videoAd
          .load(adUnitId: _rewardedUnitId, targetingInfo: targetingInfo)
          .catchError((e) => print("error in loading 1st time"))
          .then((v) => setState(() => _loaded = v));
    } else {
      // Activate button to show pop-up showing warning 'You have to play at least 1 time...'
      _adButtonActive = true;
    }

    // ad listener
    _videoAd.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.completed) {
        RewardedVideoAd.instance
            .load(adUnitId: _rewardedUnitId, targetingInfo: targetingInfo)
            .catchError((e) => print("error in loading again"))
            .then((v) => setState(() => _loaded = v));
      }

      // Check rewarded event
      _handleEvent(event);

      if (kTestAds) {
        // On every other event change pass the values to the _handleEvent Method.
        _infoEvent(event, rewardType, 'Reward', rewardAmount);
      }
    };
  }

  @override
  void dispose() {
    /// TODO: Remove Rewarded Ad event listener
    RewardedVideoAd.instance.listener = null;

    super.dispose();
  }

  // Handle rewarded event
  void _handleEvent(RewardedVideoAdEvent event) {
    if (event == RewardedVideoAdEvent.rewarded) {
      // Update level
      UpdateValues().getNewLevelValue();
      vWatchAds = false;
    }
    if (event == RewardedVideoAdEvent.loaded) {
      setState(() {
        _adButtonActive = true;
      });
    }
  }

  //---- Useful function to know exactly what is being done ----//
  void _infoEvent(RewardedVideoAdEvent event, String rewardType, String adType,
      int rewardAmount) {
    print('\n=== 0 === $event === 0 ===');
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        print('\n=== 1 === $event === 1 ===');
        break;

      case RewardedVideoAdEvent.opened:
        print('\n=== 2 === $event === 2 ===');
        break;

      case RewardedVideoAdEvent.started:
        print('\n=== 3 === $event === 3 ===');
        break;

      case RewardedVideoAdEvent.completed:
        print('\n=== 4 === $event === 4 ===');
        break;

      case RewardedVideoAdEvent.failedToLoad:
        print('\n=== 5 === $event === 5 ===');
        break;

      case RewardedVideoAdEvent.rewarded:
        print('\n=== 6 === $event === 6 ===');
        print('\n\n=== REWARDED ==');
        print('===== New level is $vMagicLevel =====');
        break;

      case RewardedVideoAdEvent.closed:
        print('\n=== 7 === $event === 7 ===');
        break;

      default:
        print('\n===== $event =======');
    }
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
                SizedBox(
                  height: _screenSize.height / 30,
                ),
                CustomHeader(text: ' Level Up '),
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
                Spacer(),
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
                Spacer(),
                MyButton(
                  contentColor:
                      _adButtonActive ? Colors.yellowAccent : Colors.grey,
                  text: ' Watch Ad ',
                  textRatio: 3.5,
                  active: _adButtonActive,
                  decreaseSizeOnTap: false,
                  onTap: () async {
                    print('\n=== Is Ad loaded onTap: $_loaded ===');
                    if (vWatchAds) {
                      if (_loaded) {
                        await RewardedVideoAd.instance.show().catchError((e) =>
                            print("error in showing ad: ${e.toString()}"));
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
      ),
    );
  }
}
