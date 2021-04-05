import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../settings/constants.dart';
import '../settings/lists.dart';

class LevelsLayout extends StatelessWidget {
  final double _widthRatio = 5; // 1.1
  final double _heightRatio = 5; // 1.1
  final double _borderRatio = 3; // 10
  final double _marginRatio = 20;
  final double _textRatio = 3;
  final double _shadowRatio = 15;

  List<Widget> generateRowElements(BuildContext context, double size) {
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

    final List<Widget> rowElements = [];

    for (int i = 0; i < listGotLevel.length; i++) {
      Color _starColor;

      if (i <= 2) {
        _starColor = kColorGreen;
      } else if (i <= 6) {
        _starColor = kColorBlue;
      } else if (i <= 10) {
        _starColor = kColorViolet;
      } else if (i <= 13) {
        _starColor = kColorRed;
      } else {
        _starColor = kColorSilver;
      }

      final int _text = i + 1;
      final double _buttonRatio = size;
      final double _sizeShape = _screenSize.width;
      final Color _color = listGotLevel[i] ? kColor2 : Colors.black;
      final Color _shadow = listGotLevel[i]
          ? kShadow2.withOpacity(kShadowOpacity2)
          : kShadow1.withOpacity(kShadowOpacity1);

      final Widget elementTile = Container(
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
    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    final double _buttonHeight = _screenSize.width * _sizeRatio;
    final double _buttonWidth = _screenSize.width * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final List<Widget> list = [];

    /// Create list/grid of level elements
    for (int i = 0; i <= 14; i++) {
      if (i == 14) {
        list.add(generateRowElements(context, 3)[i]);
      } else {
        list.add(generateRowElements(context, 1)[i]);
      }
    }

    return SizedBox(
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
