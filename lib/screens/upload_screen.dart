// import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mathniac_plus/settings/constants.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';

import 'package:mathniac_plus/tasks/task_hive.dart';
import 'package:mathniac_plus/tasks/custom_route.dart';
import 'package:mathniac_plus/tasks/tasks_functions.dart';

import 'package:mathniac_plus/widgets/my_button.dart';
import 'package:mathniac_plus/widgets/custom_header.dart';

import 'package:mathniac_plus/screens/game_screen.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool _nicknameExist;

  @override
  void initState() {
    if (vNickname == '') {
      _nicknameExist = false;
    } else {
      _nicknameExist = true;
    }
    super.initState();
  }

  void _checkInternetConnectivity() async {
    // Check internet connection
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        vInternetConnection = true;
        if (!_nicknameExist) {
          getListOfAllNames();
        }
      }
    } on SocketException catch (_) {
      print('not connected');
      vInternetConnection = false;
    }
  }

  Future<void> getListOfAllNames() async {
    final _firebase = FirebaseFirestore.instance.collection("scores");
    try {
      QuerySnapshot querySnapshot = await _firebase.get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        // print(a['score']);
        // print("${a.id} : ${a['score']}");

        // print('====== 111 ========');
        listOfAllNames.add(a['name']);
      }
    } catch (e) {
      QuerySnapshot querySnapshot = await _firebase.get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var a = querySnapshot.docs[i];
        // print(a['score']);
        // print("${a.id} : ${a['score']}");

        // print('====== 222 ========');
        listOfAllNames.add(a.id);
      }
    }
    print('listOfAllNames: $listOfAllNames');
  }

  final _firebase = FirebaseFirestore.instance.collection("scores");
  final messageTextController = TextEditingController();
  String _nickname = vNickname;

  double _widthRatio = 1.1; // 1.1
  double _heightRatio = 2;
  double _borderRatio = 10;
  double _marginRatio = 20;
  double _textRatio = 10; // 2.5

  Color _warningsColor = kColorRed;

  @override
  Widget build(BuildContext context) {
    _checkInternetConnectivity();
    var _screenSize = MediaQuery.of(context).size;
    double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    double _textSize = _screenSize.height / _textRatio / 5;
    double _borderRadius = _buttonSize / _borderRatio;
    double _edgeInsets = _buttonSize / _marginRatio;
    // double _shadowRadius = _buttonHeight / _marginRatio;

    int _highScore = listOfScorePoints[14];
    vUploadScore = false;

    Widget _alertDialog = AlertDialog(
      title: Text(
        'Internet connection',
        style: TextStyle(
          color: Colors.white,
          fontSize: _textSize / 1.8,
          fontFamily: kLetterType1,
        ),
      ),
      content: Text(
        'You have no internet connection!\n'
        'Your score will be saved.',
        style: TextStyle(
          fontSize: _textSize / 2,
          color: Colors.white,
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  CustomRoute(builder: (context) => GameScreen()));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(_borderRadius),
              ),
            ),
            child: Text(
              'Ok',
              style: TextStyle(
                fontSize: _textSize / 1.5,
              ),
            )),
      ],
      elevation: 24.0,
      backgroundColor: Colors.black,
      buttonPadding: EdgeInsets.all(_borderRadius / 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius),
        ),
        side: BorderSide(color: Colors.white60, width: _edgeInsets / 4),
      ),
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      // A flexible child that will grow to fit the viewport but
                      // still be at least as big as necessary to fit its contents.
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.black,
                                Colors.black,
                                kColorSilver,
                                Colors.black,
                                kColorBronze,
                                Colors.yellow,
                                kColorBronze,
                                Colors.black,
                                kColorSilver,
                                Colors.black,
                                Colors.black,
                              ]),
                        ),
                        // decoration: kBackground15,
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: _screenSize.height / 30,
                              ),
                              CustomHeader(
                                text: ' Congratulations ',
                              ),
                              Spacer(),
                              // SizedBox(
                              //   height: _screenSize.height / 30,
                              // ),
                              SizedBox(
                                width: _nicknameExist ? 0 : _buttonWidth,
                                height: _nicknameExist ? 0 : null,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(_edgeInsets),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _warningsColor,
                                      width: _edgeInsets / 4,
                                    ),
                                    color: Colors.black.withAlpha(155),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(_borderRadius),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Choose your nickname',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: _warningsColor,
                                          fontSize: _textSize * 1.1,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '- Between 4 and 12 characters long\n'
                                        '- Not yet in use',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: _warningsColor,
                                          fontSize: _textSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: _screenSize.height / 30,
                              ),
                              Column(
                                children: [
                                  Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        CustomHeader(
                                          text: ' $_nickname ',
                                          heightRatio: 10,
                                          widthRatio: 2,
                                        ),
                                        SizedBox(
                                          width: _nicknameExist
                                              ? 0
                                              : _buttonWidth / 2,
                                          child: TextField(
                                            autofocus:
                                                _nicknameExist ? false : true,
                                            // maxLength: 12,
                                            style: TextStyle(
                                              fontSize: _textSize * 1.1,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                            controller: messageTextController,
                                            onChanged: (value) {
                                              // between 4 and 12 letters
                                              // is already a used name and player has no name
                                              if ("$value".length >= 4 &&
                                                      "$value".length <= 12 ||
                                                  listOfAllNames.contains(
                                                          '$vNickname') &&
                                                      !_nicknameExist) {
                                                setState(() {
                                                  _warningsColor = Colors.white;
                                                  vNickname = value;
                                                });
                                              } else {
                                                setState(() {
                                                  vNickname = '';
                                                  if (_warningsColor ==
                                                      Colors.white) {
                                                    _warningsColor = kColorRed;
                                                  }
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ]),
                                  MyButton(
                                    onTap: () {},
                                    active: false,
                                    text: _highScore.toString(),
                                    widthRatio: 2,
                                    heightRatio: 5,
                                    textRatio: 1.5,
                                    colorPrimary: levelColor(),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: _screenSize.height / 30,
                              // ),
                              Spacer(),
                              Container(
                                width: _buttonWidth,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(_edgeInsets),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: _edgeInsets / 4,
                                  ),
                                  color: Colors.black.withAlpha(155),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(_borderRadius),
                                  ),
                                ),
                                child: Text(
                                  'After press Upload, restart the application to see the complete new leaderboard!',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _textSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                              // SizedBox(
                              //   height: _screenSize.height / 30,
                              // ),
                              MyButton(
                                text: ' Upload ',
                                active: vNickname == '' ? false : true,
                                // widthRatio: vNickname == '' ? 3 : 3,
                                // heightRatio: vNickname == '' ? 5 : 5,
                                onTap: () {
                                  print('nickname1: $vNickname');
                                  print('Internet: $vInternetConnection');

                                  if (vInternetConnection) {
                                    if (listOfAllNames.contains('$vNickname') &&
                                        _nicknameExist) {
                                      // Update existing score
                                      try {
                                        _firebase.doc('$vNickname').update({
                                          'name': vNickname,
                                          'score': _highScore,
                                        });
                                      } catch (e) {
                                        _firebase.doc('$vNickname').update({
                                          // 'name': vNickname,
                                          'score': _highScore,
                                        });
                                      }
                                    } else {
                                      // Add new score
                                      _firebase.doc('$vNickname').set({
                                        'score': _highScore,
                                        'name': vNickname,
                                      });
                                    }
                                    TaskHive().saveNickname(vNickname);
                                    TaskHive().uploadScore(false);
                                  } else {
                                    // true to update on restart
                                    TaskHive().uploadScore(true);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return _alertDialog;
                                        });
                                  }
                                  vUploadScore = false;
                                  // Navigator.pop(context);
                                },
                                navigator: vNickname == ''
                                    ? null
                                    : vInternetConnection
                                        ? GameScreen()
                                        : null,
                              ),
                              // Spacer(),
                              SizedBox(
                                height: _screenSize.height / 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
