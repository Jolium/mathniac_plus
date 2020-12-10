import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../settings/constants.dart';
import '../settings/lists.dart';

class LevelsLayout extends StatefulWidget {
  @override
  _LevelsLayoutState createState() => _LevelsLayoutState();
}

class _LevelsLayoutState extends State<LevelsLayout> {
  double _widthRatio = 5; // 1.1
  double _heightRatio = 5; // 1.1
  double _borderRatio = 3; // 10
  double _marginRatio = 20;
  double _textRatio = 3;
  double _shadowRatio = 15;

  List<Widget> rowElements = [];

  List<Widget> generateRowElements(double size) {
    var _screenSize = MediaQuery.of(context).size;
    double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    double _textSize = _buttonSize / _textRatio;
    double _borderRadius = _buttonSize / _borderRatio * _sizeRatio;
    double _edgeInsets = _buttonSize / _marginRatio * _sizeRatio;
    double _shadowRadius = _buttonHeight / 5 / _shadowRatio;

    rowElements.clear();

    for (int i = 0; i < listGotLevel.length; i++) {
      Color _starColor;
      Color _lastLevelColor = kColorSilver;

      if (i <= 2) {
        _starColor = kColorGreen;
      } else if (i <= 6) {
        _starColor = kColorBlue;
      } else if (i <= 10) {
        _starColor = kColorViolet;
      } else if (i <= 13) {
        _starColor = kColorRed;
      } else {
        _starColor = _lastLevelColor;
      }

      int _text = i + 1;
      double _buttonRatio = size;
      double _sizeShape = _screenSize.width;
      Color _color = listGotLevel[i] ? kColor2 : Colors.black;
      Color _shadow = listGotLevel[i]
          ? kShadow2.withOpacity(kShadowOpacity2)
          : kShadow1.withOpacity(kShadowOpacity1);

      Widget elementTile = Container(
        margin: EdgeInsets.all(_edgeInsets), // Between buttons
        width: _screenSize.width / _widthRatio * _sizeRatio * _buttonRatio,
        height: _screenSize.width / _heightRatio * _sizeRatio * _buttonRatio,
        child: Stack(alignment: AlignmentDirectional.topEnd, children: [
          Container(
            alignment: Alignment.center,
            width: _screenSize.width / _widthRatio * _sizeRatio * _buttonRatio -
                10,
            height:
                _screenSize.width / _heightRatio * _sizeRatio * _buttonRatio -
                    10,
            margin: EdgeInsets.all(_edgeInsets),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(_sizeShape),
                topRight: Radius.circular(_sizeShape),
                bottomLeft:
                    Radius.circular(_borderRadius - (_borderRadius / 10)),
                bottomRight: Radius.circular(_sizeShape),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: listGotLevel[i]
                    ? [
                        Colors.white,
                        _starColor,
                        Colors.black,
                        Colors.black,
                      ]
                    : [
                        Colors.white,
                        Colors.black,
                        _starColor,
                      ],
              ),
              border: Border.all(
                color: _color,
                width: _edgeInsets,
              ),
              boxShadow: [
                BoxShadow(
                  color: _shadow.withOpacity(0.8),
                  spreadRadius: _shadowRadius / 2,
                  blurRadius: _shadowRadius,
                ),
              ],
            ),
            child: Text(
              ' $_text ',
              style: TextStyle(
                color: listGotLevel[i] ? Colors.yellowAccent : Colors.grey,
                fontSize: _textSize * _buttonRatio,
                fontWeight: FontWeight.bold,
                shadows: [
                  BoxShadow(
                    color: _shadow,
                    spreadRadius: _shadowRadius / 2,
                    blurRadius: _shadowRadius,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: _screenSize.width /
                _widthRatio *
                _sizeRatio *
                _buttonRatio /
                2.5,
            height: _screenSize.width /
                _heightRatio *
                _sizeRatio *
                _buttonRatio /
                2.5,
            decoration: BoxDecoration(
              color: _color,
              boxShadow: [
                BoxShadow(
                  color: _shadow,
                  spreadRadius: _shadowRadius / 2,
                  blurRadius: _shadowRadius,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(_sizeShape)),
            ),
          ),
          Icon(
            listGotLevel[i] ? Icons.check_circle : Icons.close,
            size: _screenSize.width /
                _widthRatio *
                _sizeRatio *
                _buttonRatio /
                2.5,
            color: listGotLevel[i] ? Colors.green : kColorRed,
          ),
        ]),
      );
      rowElements.add(elementTile);
    }
    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    double _buttonHeight = _screenSize.width * _sizeRatio;
    double _buttonWidth = _screenSize.width * _sizeRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    List<Widget> list = [];

    for (int i = 0; i <= 14; i++)
      if (i == 14) {
        list.add(generateRowElements(3)[i]);
      } else {
        list.add(generateRowElements(1)[i]);
      }

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      child: Stack(children: [
        Center(
          child: list[14],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [for (int i = 0; i <= 2; i++) list[i]],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [for (int i = 3; i <= 6; i++) list[i]],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [for (int i = 7; i <= 10; i++) list[i]],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 11; i <= 13; i++) list[i],
              ],
            ),
          ],
        ),
        Center(
          child: listGotLevel[14] ? list[14] : null,
        ),
      ]),
    );
  }
}
