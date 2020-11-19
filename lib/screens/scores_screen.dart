// import 'package:flutter/foundation.dart';
// import 'dart:io';

// import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'package:mathniac_plus/settings/constants.dart';
// import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';

// import 'package:mathniac_plus/tasks/task_hive.dart';
// import 'package:mathniac_plus/tasks/tasks_functions.dart';
import 'package:mathniac_plus/tasks/admob_service.dart';

import 'package:mathniac_plus/widgets/my_button.dart';
import 'package:mathniac_plus/widgets/custom_header.dart';

import 'package:mathniac_plus/screens/home_screen.dart';

class ScoresScreen extends StatefulWidget {
  @override
  _ScoresScreenState createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  final ams = AdMobService();
  double _widthRatio = 1.1;
  double _heightRatio = 2;
  double _borderRatio = 10;
  double _marginRatio = 20;
  double _textRatio = 10;
  int _place = 0;

  List<Widget> rowElements = [];

  Widget _scoresListStreamer() {
    final _firebase = FirebaseFirestore.instance
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(kTopScores + 1);

    var _screenSize = MediaQuery.of(context).size;
    double _buttonHeight = _screenSize.width / _heightRatio;
    double _buttonWidth = _screenSize.width / _widthRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    // double _textSize = _screenSize.height / _textRatio / 5;
    double _borderRadius = _buttonSize / _borderRatio;
    double _edgeInsets = _buttonSize / _marginRatio;

    // if (true) {
    return StreamBuilder(
      stream: _firebase.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: snapshot.data.docs.map((document) {
              if (_place < kTopScores) {
                _place++;
                String _nickname;
                try {
                  _nickname = document['name'];
                } catch (e) {
                  _nickname = document.id;
                  print('\n== ${document.id} has no field [name] ==\n');
                }

                String _score = document['score'].toString();

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _screenSize.width / 50,
                    vertical: 4.0,
                  ),
                  child: _place % 5 == 0 && _place != kTopScores
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // mainAxisSize: MainAxisSize.min,
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
                                CustomHeader(
                                  text: _nickname,
                                  widthRatio: 2.25,
                                  heightRatio: 9,
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
                            SizedBox(
                              height: 4.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 5.0,
                              ),
                              child: Container(
                                // width: _buttonWidth / 1.5,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(_edgeInsets),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image: AssetImage('images/banner.png'),
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
                                child: AdmobBanner(
                                  /// TODO
                                  // adUnitId: ams.getBannerAdId(),
                                  adUnitId:
                                      'ca-app-pub-3940256099942544/6300978111',
                                  adSize: AdmobBannerSize.BANNER,
                                  nonPersonalizedAds: true,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // mainAxisSize: MainAxisSize.min,
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
                            CustomHeader(
                              text: _nickname,
                              widthRatio: 2.25,
                              heightRatio: 9,
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
                // }
                // if (_place == kTopScores) {
                //   _place = 0;
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
    var _screenSize = MediaQuery.of(context).size;
    // List<Widget> list = generateRowElements();

    double _buttonHeight = _screenSize.width / _heightRatio;
    double _buttonWidth = _screenSize.width / _widthRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    double _textSize = _screenSize.height / _textRatio / 5;
    double _borderRadius = _buttonSize / _borderRatio;
    double _edgeInsets = _buttonSize / _marginRatio;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: _screenSize.height / 30,
              ),
              CustomHeader(
                text: ' Leaderboard ',
              ),
              SizedBox(
                height: _screenSize.height / 20,
              ),
              Visibility(
                visible: !vInternetConnection,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: _screenSize.width / 20,
                  ),
                  child: Column(
                    children: [
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
    );
  }
}
