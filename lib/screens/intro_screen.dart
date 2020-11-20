import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:mathniac_plus/settings/vars.dart';
import 'package:mathniac_plus/settings/constants.dart';
import 'package:mathniac_plus/settings/intro_content.dart';

import 'package:mathniac_plus/widgets/my_button.dart';
import 'package:mathniac_plus/widgets/custom_header.dart';

import 'package:mathniac_plus/screens/home_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  double _widthRatio = 1.15;
  double _heightRatio = 1.1;
  double _borderRatio = 10;
  double _marginRatio = 20;
  double _textRatio = 20;

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

    return Scaffold(
      body: Container(
        decoration: vBackground
            ? vMagicLevel == 15
                ? kBackground15
                : kBackgroundOn
            : kBackgroundOff,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _screenSize.width / 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _screenSize.height / 30,
                  ),
                  CustomHeader(text: ' Introduction '),
                  SizedBox(
                    height: _screenSize.height / 30,
                  ),
                  Container(
                    // width: _buttonWidth,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(_edgeInsets),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: _edgeInsets / 6,
                      ),
                      color: Colors.black.withAlpha(155),
                      borderRadius: BorderRadius.all(
                        Radius.circular(_borderRadius),
                      ),
                    ),
                    child: Text(
                      text1,
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
                  Container(
                    // width: _buttonWidth,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(_edgeInsets),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: _edgeInsets / 6,
                      ),
                      color: Colors.black.withAlpha(155),
                      borderRadius: BorderRadius.all(
                        Radius.circular(_borderRadius),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          text2_1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _textSize * 1.1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          text2_2,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _textSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _screenSize.height / 30,
                  ),
                  Container(
                    // width: _buttonWidth,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(_edgeInsets),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: _edgeInsets / 6,
                      ),
                      color: Colors.black.withAlpha(155),
                      borderRadius: BorderRadius.all(
                        Radius.circular(_borderRadius - (_borderRadius / 10)),
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            _borderRadius - (_borderRadius / 5),
                          ),
                          child: Image.asset('images/game_screen.png'),
                        ),
                        Text(
                          text3,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _textSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _screenSize.height / 30,
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
      ),
    );
  }
}
