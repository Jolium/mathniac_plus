import 'package:flutter/material.dart';

import '../settings/constants.dart';
import '../settings/vars.dart';
import '../tasks/tasks_soundpool.dart';

class LevelUp extends StatelessWidget {
  final double _widthRatio = 5; // 1.1
  final double _heightRatio = 5; // 1.1
  final double _borderRatio = 3; // 10
  final double _marginRatio = 20;
  final double _textRatio = 3;
  final double _shadowRatio = 15;

  @override
  Widget build(BuildContext context) {
    /// Play audio
    SoundManager.instance.playSound(SOUND_ACTIONS.levelUp);

    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    final double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    final double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _textSize = _buttonSize / _textRatio;
    final double _borderRadius = _buttonSize / _borderRatio * _sizeRatio;
    final double _edgeInsets = _buttonSize / _marginRatio * _sizeRatio;
    final double _shadowRadius = _buttonHeight / 5 / _shadowRatio;
    final double _sizeShape = _screenSize.width;

    final int level = vMagicLevel;
    Color _starColor;

    if (level <= 3) {
      _starColor = kColorGreen;
    } else if (level <= 7) {
      _starColor = kColorBlue;
    } else if (level <= 11) {
      _starColor = kColorViolet;
    } else if (level <= 14) {
      _starColor = kColorRed;
    } else {
      _starColor = kColorSilver;
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: AlertDialog(
        elevation: 24.0,
        buttonPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.black.withOpacity(0.7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
          side: BorderSide(color: Colors.yellowAccent, width: 4),
        ),
        title: Center(
          child: Text(
            'Congratulations!',
            style: TextStyle(
              color: Colors.yellowAccent,
              fontSize: _textSize,
              fontWeight: FontWeight.bold,
              fontFamily: kLetterType1,
              shadows: [
                BoxShadow(
                  color: kShadow2.withOpacity(kShadowOpacity2),
                  spreadRadius: _shadowRadius / 2,
                  blurRadius: _shadowRadius,
                ),
              ],
            ),
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Level',
              style: TextStyle(
                fontSize: _textSize * 2,
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold,
                fontFamily: kLetterType1,
                shadows: [
                  BoxShadow(
                    color: kShadow2.withOpacity(kShadowOpacity2),
                    spreadRadius: _shadowRadius / 2,
                    blurRadius: _shadowRadius,
                  ),
                ],
              ),
            ),
            Container(
              // Between buttons
              margin: EdgeInsets.all(_edgeInsets),
              width: _screenSize.width / _widthRatio * _sizeRatio,
              height: _screenSize.width / _heightRatio * _sizeRatio,
              child: Stack(alignment: AlignmentDirectional.topEnd, children: [
                Container(
                  alignment: Alignment.center,
                  width: _screenSize.width / _widthRatio * _sizeRatio - 10,
                  height: _screenSize.width / _heightRatio * _sizeRatio - 10,
                  margin: EdgeInsets.all(_edgeInsets),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_sizeShape),
                      topRight: Radius.circular(_sizeShape),
                      bottomLeft: Radius.circular(
                        _borderRadius - (_borderRadius / 10),
                      ),
                      bottomRight: Radius.circular(_sizeShape),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        _starColor,
                        Colors.black,
                        Colors.black,
                      ],
                    ),
                    border: Border.all(
                      color: kColor2,
                      width: _edgeInsets,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: kShadow2.withOpacity(kShadowOpacity2),
                        spreadRadius: _shadowRadius / 2,
                        blurRadius: _shadowRadius,
                      ),
                    ],
                  ),
                  child: Text(
                    ' $level ',
                    style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: _textSize,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(
                          color: kShadow2.withOpacity(kShadowOpacity2),
                          spreadRadius: _shadowRadius / 2,
                          blurRadius: _shadowRadius,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: _screenSize.width / _widthRatio * _sizeRatio / 2.5,
                  height: _screenSize.width / _heightRatio * _sizeRatio / 2.5,
                  decoration: BoxDecoration(
                    color: kColor2,
                    boxShadow: [
                      BoxShadow(
                        color: kShadow2.withOpacity(kShadowOpacity2),
                        spreadRadius: _shadowRadius / 2,
                        blurRadius: _shadowRadius,
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(_sizeShape),
                    ),
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  size: _screenSize.width / _widthRatio * _sizeRatio / 2.5,
                  color: Colors.green,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
