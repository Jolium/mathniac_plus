import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:mathniac_plus/widgets/pop_up.dart';

import '../settings/backgrounds.dart';
import '../settings/constants.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/admob_service.dart';
import '../widgets/custom_header.dart';
import '../widgets/my_button.dart';
import 'home_screen.dart';

class ScoresScreen extends StatefulWidget {
  @override
  _ScoresScreenState createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  final double _widthRatio = 1.1;
  final double _heightRatio = 2;
  final double _borderRatio = 10;
  final double _marginRatio = 20;
  final double _textRatio = 10;
  int _place = 0;

  List<Widget> rowElements = [];

  /// Banner Unit Id
  final String _bannerUnitId = AdMobService().getBannerAdId();

  BannerAd _bannerAd;
  final Completer<BannerAd> bannerCompleter = Completer<BannerAd>();

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    // Admob.initialize(testDeviceIds: listOfTestDevices);

    MobileAds.instance.initialize();

    _bannerAd = BannerAd(
      // adUnitId: BannerAd.testAdUnitId,
      adUnitId: _bannerUnitId,
      request: AdRequest(
        testDevices: listOfTestDevices,
        keywords: listOfKeyWords,
        contentUrl: 'https://play.google.com/store/apps/category/GAME_CASUAL',
        nonPersonalizedAds: true,
      ),
      size: AdSize.banner,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          bannerCompleter.complete(ad as BannerAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('$BannerAd failedToLoad: $error');
          bannerCompleter.completeError(null);
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$BannerAd onApplicationExit.'),
      ),
    );

    // _bannerAd?.load();
    Future<void>.delayed(const Duration(seconds: 1), () {
      _bannerAd?.load();
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  Widget _scoresListStreamer() {
    final _firebase = FirebaseFirestore.instance
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(kTopScores + 1);

    final Size _screenSize = MediaQuery.of(context).size;
    final double _buttonHeight = _screenSize.width / _heightRatio;
    final double _buttonWidth = _screenSize.width / _widthRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    // double _textSize = _screenSize.height / _textRatio / 5;
    final double _borderRadius = _buttonSize / _borderRatio;
    final double _edgeInsets = _buttonSize / _marginRatio;

    Widget banner(BuildContext context) {
      return FutureBuilder<BannerAd>(
        future: bannerCompleter.future,
        builder: (BuildContext context, AsyncSnapshot<BannerAd> snapshot) {
          Widget child;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              child = Container();
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                child = AdWidget(ad: _bannerAd);
              } else {
                child = Text('Error loading $BannerAd');
              }
          }
          return child;
        },
      );
    }

    return StreamBuilder(
      stream: _firebase.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: snapshot.data.docs.map((document) {
              if (_place < kTopScores) {
                _place++;
                dynamic _nickname;
                try {
                  _nickname = document['name'];
                } catch (e) {
                  _nickname = document.id;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PopUp(
                          title: 'Something went wrong!',
                          content:
                          e.toString(),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                      });
                  // print('\n== ${document.id} has no field [name] ==\n');
                }

                final String _score = document['score'].toString();

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  child: _place % 5 == 0 && _place != kTopScores
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  onTap: () {},
                                  active: false,
                                  widthRatio: 9,
                                  heightRatio: 9,
                                  textRatio: 2,
                                  text: (_place).toString(),
                                  colorPrimary: kColorSilver,
                                ),
                                SizedBox(
                                  width: _screenSize.height / 50,
                                ),
                                SizedBox(
                                  width: _screenSize.width / 2.25,
                                  child: CustomHeader(
                                    text: _nickname.toString(),
                                    heightRatio: 9,
                                  ),
                                ),
                                SizedBox(
                                  width: _screenSize.height / 50,
                                ),
                                MyButton(
                                  onTap: () {},
                                  active: false,
                                  widthRatio: 5,
                                  heightRatio: 9,
                                  textRatio: 2,
                                  text: _score,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Container(
                                height: 80.0,
                                // width: _buttonWidth / 1.5,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(_edgeInsets),
                                decoration: isLoaded
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: _edgeInsets / 4,
                                        ),
                                        color: Colors.black.withAlpha(155),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(_borderRadius / 1.5),
                                        ),
                                      )
                                    : BoxDecoration(
                                        image: const DecorationImage(
                                          fit: BoxFit.scaleDown,
                                          image:
                                              AssetImage('images/banner.png'),
                                        ),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: _edgeInsets / 4,
                                        ),
                                        color: Colors.black.withAlpha(155),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(_borderRadius / 1.5),
                                        ),
                                      ),
                                child: banner(context),
                                // child: AdmobBanner(
                                //   adUnitId: _bannerUnitId,
                                //   adSize: AdmobBannerSize.BANNER,
                                //   nonPersonalizedAds: true,
                                // ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyButton(
                              onTap: () {},
                              active: false,
                              widthRatio: 9,
                              heightRatio: 9,
                              textRatio: 2,
                              text: (_place).toString(),
                              colorPrimary: kColorSilver,
                            ),
                            SizedBox(
                              width: _screenSize.height / 50,
                            ),
                            SizedBox(
                              width: _screenSize.width / 2.25,
                              child: CustomHeader(
                                text: _nickname.toString(),
                                heightRatio: 9,
                              ),
                            ),
                            SizedBox(
                              width: _screenSize.height / 50,
                            ),
                            MyButton(
                              onTap: () {},
                              active: false,
                              widthRatio: 5,
                              heightRatio: 9,
                              textRatio: 2,
                              text: _score,
                            )
                          ],
                        ),
                );
              } else {
                _place = 0;
                return Container();
              }
            }).toList(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;

    final double _buttonHeight = _screenSize.width / _heightRatio;
    final double _buttonWidth = _screenSize.width / _widthRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _textSize = _screenSize.height / _textRatio / 5;
    final double _borderRadius = _buttonSize / _borderRatio;
    final double _edgeInsets = _buttonSize / _marginRatio;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: _screenSize.height,
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
                const CustomHeader(
                  text: ' Leaderboard ',
                ),
                SizedBox(
                  height: _screenSize.height / 20,
                ),
                Visibility(
                  visible: !vInternetConnection,
                  child: Column(
                    children: [
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
                          'Leaderboard might not be updated.',
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
                Expanded(
                  child: _scoresListStreamer(),
                ),
                SizedBox(
                  height: _screenSize.height / 20,
                ),
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
