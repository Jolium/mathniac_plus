import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../settings/backgrounds.dart';
import '../settings/constants.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/custom_route.dart';
import '../tasks/task_hive.dart';
import '../tasks/tasks_functions.dart';
import '../widgets/custom_header.dart';
import '../widgets/my_button.dart';
import 'game_screen.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool _nicknameExist;
  List<String> listOfAllNames = [];

  @override
  void initState() {
    if (vNickname == '') {
      _nicknameExist = false;
    } else {
      _nicknameExist = true;
    }
    _checkInternetConnectivity();
    super.initState();
  }

  Future<void> _checkInternetConnectivity() async {
    /// Check internet connection
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        vInternetConnection = true;
        if (!_nicknameExist) {
          getListOfAllNames();
        }
      }
    } on SocketException catch (_) {
      // print('not connected');
      vInternetConnection = false;
    }
  }

  Future<void> getListOfAllNames() async {
    final _firebase = FirebaseFirestore.instance.collection("scores");
    try {
      final QuerySnapshot querySnapshot = await _firebase.get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        final QueryDocumentSnapshot a = querySnapshot.docs[i];
        final dynamic name = a['name'];
        listOfAllNames.add(name.toString());
      }
    } catch (e) {
      final QuerySnapshot querySnapshot = await _firebase.get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        final QueryDocumentSnapshot a = querySnapshot.docs[i];
        listOfAllNames.add(a.id);
      }
    }
    print('listOfAllNames: $listOfAllNames');
  }

  final _firebase = FirebaseFirestore.instance.collection("scores");
  final messageTextController = TextEditingController();
  final String _nickname = vNickname;

  final double _widthRatio = 1.1; // 1.1
  final double _heightRatio = 2;
  final double _borderRatio = 10;
  final double _marginRatio = 20;
  final double _textRatio = 10; // 2.5

  Color _warningsColor = kColorRed;
  Color _warningsColorText1 = kColorRed;
  Color _warningsColorText2 = kColorRed;

  @override
  Widget build(BuildContext context) {
    /// Hide bottom bar and top bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    // _checkInternetConnectivity();

    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    final double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    final double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _textSize = _screenSize.height / _textRatio / 5;
    final double _borderRadius = _buttonSize / _borderRatio;
    final double _edgeInsets = _buttonSize / _marginRatio;
    // double _shadowRadius = _buttonHeight / _marginRatio;

    final int _highScore = listOfScorePoints[14];
    vUploadScore = false;

    final Widget _alertDialog = AlertDialog(
      title: Text(
        'Internet connection',
        style: TextStyle(
          color: Colors.white,
          fontSize: _textSize * 1.1,
          fontFamily: kLetterType1,
        ),
      ),
      content: Text(
        'You have no internet connection!\n'
        'Your score will be saved.',
        style: TextStyle(
          fontSize: _textSize,
          color: Colors.white,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                CustomRoute(builder: (context) => GameScreen()));
          },
          child: Text(
            'Ok',
            style: TextStyle(
              fontSize: _textSize * 1.5,
            ),
          ),
        ),
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
                      child: Container(
                        decoration: kBackground15,
                        child: SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: _screenSize.width / 30,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: _screenSize.height / 30,
                                ),
                                const CustomHeader(
                                  text: ' Congratulations ',
                                ),
                                const Spacer(),
                                Visibility(
                                  visible: !_nicknameExist,
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
                                          '- Between 4 and 12 characters long',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: _warningsColorText1,
                                            fontSize: _textSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '- Not yet in use',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: _warningsColorText2,
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
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: _screenSize.width / 7,
                                            ),
                                            child: CustomHeader(
                                              text: ' $_nickname ',
                                              heightRatio: 7.5,
                                            ),
                                          ),
                                          Visibility(
                                            visible: !_nicknameExist,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    _screenSize.width / 5,
                                              ),
                                              child: TextField(
                                                autofocus: _nicknameExist
                                                    ? false
                                                    : true,
                                                keyboardType:
                                                    TextInputType.name,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                // maxLength: 12,
                                                style: TextStyle(
                                                  fontSize: _textSize * 1.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                                controller:
                                                    messageTextController,
                                                onChanged: (value) {
                                                  /// between 4 and 12 letters
                                                  if (value.length >= 4 &&
                                                      value.length <= 12) {
                                                    setState(() {
                                                      _warningsColorText1 =
                                                          Colors.white;
                                                      vNickname = value;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _warningsColorText1 =
                                                          kColorRed;
                                                    });
                                                  }

                                                  /// is already a used name and player has no name
                                                  if (!listOfAllNames
                                                          .contains(value) &&
                                                      !_nicknameExist) {
                                                    setState(() {
                                                      _warningsColorText2 =
                                                          Colors.white;
                                                      vNickname = value;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _warningsColorText2 =
                                                          kColorRed;
                                                    });
                                                  }
                                                  if (_warningsColorText1 ==
                                                          Colors.white &&
                                                      _warningsColorText2 ==
                                                          Colors.white) {
                                                    _warningsColor =
                                                        Colors.white;
                                                    vNickname = value;
                                                  } else {
                                                    setState(() {
                                                      vNickname = '';
                                                      if (_warningsColor ==
                                                          Colors.white) {
                                                        _warningsColor =
                                                            kColorRed;
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    MyButton(
                                      onTap: () {},
                                      active: false,
                                      text: _highScore.toString(),
                                      widthRatio: 2,
                                      // heightRatio: 5,
                                      textRatio: 1.5,
                                      colorPrimary: levelColor(),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
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
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: _textSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                MyButton(
                                  text: ' Upload ',
                                  active: vNickname == '' ? false : true,
                                  onTap: () {
                                    print('nickname1: $vNickname');
                                    print('Internet: $vInternetConnection');

                                    if (vInternetConnection) {
                                      if (listOfAllNames.contains(vNickname) &&
                                          _nicknameExist) {
                                        // Update existing score
                                        try {
                                          _firebase.doc(vNickname).update({
                                            'name': vNickname,
                                            'score': _highScore,
                                          });
                                        } catch (e) {
                                          _firebase.doc(vNickname).update({
                                            // 'name': vNickname,
                                            'score': _highScore,
                                          });
                                        }
                                      } else {
                                        // Add new score
                                        _firebase.doc(vNickname).set({
                                          'score': _highScore,
                                          'name': vNickname,
                                        });
                                      }
                                      TaskHive().saveNickname(vNickname);
                                      TaskHive().uploadScore(value: false);
                                    } else {
                                      // true to update on restart
                                      TaskHive().uploadScore(value: true);
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
                                SizedBox(
                                  height: _screenSize.height / 30,
                                ),
                              ],
                            ),
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
