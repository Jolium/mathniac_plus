import 'package:flutter/material.dart';
import 'package:mathniac_plus/tasks/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/constants.dart';
import '../tasks/tasks_functions.dart';

class CountDown extends StatelessWidget {
  final double _widthRatio = 5;
  final double _heightRatio = 5;
  final double _textRatio = 2;
  final double _borderRatio = 3;
  final double _marginRatio = 20;

  @override
  Widget build(BuildContext context) {
    print('== CountDown ==');

    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    final double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    final double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _borderRadius = _buttonSize / _borderRatio * _sizeRatio;
    final double _edgeInsets = _buttonSize / _marginRatio * _sizeRatio;
    final double _shadowRadius = _buttonSize / _marginRatio * _sizeRatio;
    final double _textSize = _buttonSize / _textRatio;

    return Consumer(builder: (context, watch, child) {

      final int countdown = watch(countdownProvider.state);

      final int _intValue =
          int.parse(countdown.toString().padLeft(3, '0').substring(0, 2));

      final int _stringValue10 =
          int.parse(countdown.toString().padLeft(3, '0').substring(2, 3));
      return Container(
        margin: EdgeInsets.all(_edgeInsets),
        alignment: Alignment.center,
        width: _screenSize.width / _widthRatio * _sizeRatio,
        height: _screenSize.width / _heightRatio * _sizeRatio,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              _borderRadius,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, levelColor(), Colors.black],
          ),
          border: Border.all(
            color: _intValue <= 10 && _intValue >= 3 && _intValue.isEven
                ? kColorRed
                : _intValue < 3 && _stringValue10.isEven
                    ? kColorRed
                    : Colors.white,
            width: _edgeInsets,
          ),
          boxShadow: [
            BoxShadow(
              color: kShadow1.withOpacity(0.8),
              spreadRadius: _shadowRadius / 2,
              blurRadius: _shadowRadius,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_intValue >= 10)
                Text(
                  _intValue.toString(),
                  style: TextStyle(
                    fontSize: _textSize,
                    fontWeight: FontWeight.bold,
                    color: _intValue <= 10 && _intValue.isEven
                        ? kColorRed
                        : Colors.white,
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _intValue.toString(),
                      style: TextStyle(
                        fontSize: _textSize,
                        fontWeight: FontWeight.bold,
                        color: _intValue <= 10 &&
                                _intValue >= 3 &&
                                _intValue.isEven
                            ? kColorRed
                            : _intValue < 3 && _stringValue10.isEven
                                ? kColorRed
                                : Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: _screenSize.height / 60,
                        ),
                        Text(
                          '.$_stringValue10',
                          style: TextStyle(
                            fontSize: _textSize / 2,
                            fontWeight: FontWeight.bold,
                            color: _intValue <= 10 &&
                                    _intValue >= 3 &&
                                    _intValue.isEven
                                ? kColorRed
                                : _intValue < 3 && _stringValue10.isEven
                                    ? kColorRed
                                    : Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      );
    });
  }
}
