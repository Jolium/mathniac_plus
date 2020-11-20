import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mathniac_plus/tasks/task_hive.dart';
import 'package:mathniac_plus/tasks/tasks_provider.dart';
import 'package:mathniac_plus/tasks/tasks_functions.dart';

import 'package:mathniac_plus/settings/constants.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';

class CountDown extends StatefulWidget {
  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  int _scoreLevelPoints = listOfScorePoints[vMagicLevel - 1];
  double _widthRatio = 5;
  double _heightRatio = 5;
  double _textRatio = 2;
  double _borderRatio = 3;
  double _marginRatio = 20;

  @override
  Widget build(BuildContext context) {
    Provider.of<RebuildWidgets>(context).rebuildWidget;

    var _screenSize = MediaQuery.of(context).size;
    double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    double _borderRadius = _buttonSize / _borderRatio * _sizeRatio;
    double _edgeInsets = _buttonSize / _marginRatio * _sizeRatio;
    double _shadowRadius = _buttonSize / _marginRatio * _sizeRatio;
    double _textSize = _buttonSize / _textRatio;
    // double _iconSize = _buttonSize / _iconRatio * _sizeRatio;

    int _scorePointsLevel = listOfScorePoints[vMagicLevel - 1];

    // Beep the last 5 seconds
    if (vCountdownValue == 50 ||
        vCountdownValue == 40 ||
        vCountdownValue == 30 ||
        vCountdownValue == 20 ||
        vCountdownValue == 10 && vIsTimerTicking == true) {
      AudioPlayer().soundPlayer('beep.mp3');
    }

    if (vCountdownValue == 0 && vIsTimerTicking == true) {
      AudioPlayer().soundPlayer('beep_end.mp3');
      vIsTimerTicking = false;
      if (vActualScoreValue >= _scorePointsLevel && vMagicLevel != 15) {
        vButtonText = ' Next ';
        vButtonGradient = true;
      } else {
        // If score is own high score
        if (vMagicLevel == 15 && vActualScoreValue > _scoreLevelPoints) {
          TaskHive().updateHighScore(vActualScoreValue);
          TaskHive().uploadScore(true);
          listOfScorePoints[14] = vActualScoreValue;
          vButtonText = ' Next ';
          vButtonGradient = true;
        } else {
          vButtonText = ' Again ';
          vButtonGradient = false;
        }
      }
    }

    // Plays sound during game just 1 time when player pass level
    if (vMagicLevel != 15 &&
        vActualScoreValue >= _scorePointsLevel &&
        vPlayLevelUp &&
        vActualScoreValue != 0) {
      AudioPlayer().soundPlayer('level_up.mp3');
      vPlayLevelUp = false;
    } else if (vMagicLevel == 15 &&
        vActualScoreValue > _scorePointsLevel &&
        vPlayLevelUp &&
        vActualScoreValue != 0) {
      AudioPlayer().soundPlayer('level_up.mp3');
      vPlayLevelUp = false;
    }

    int _intValue =
        int.parse(vCountdownValue.toString().padLeft(3, '0').substring(0, 2));

    int _stringValue10 =
        int.parse(vCountdownValue.toString().padLeft(3, '0').substring(2, 3));

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _intValue >= 10
                ? Text(
                    _intValue.toString(),
                    style: TextStyle(
                      fontSize: _textSize,
                      fontWeight: FontWeight.bold,
                      color: _intValue <= 10 && _intValue.isEven
                          ? kColorRed
                          : Colors.white,
                    ),
                  )
                : Row(
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
  }
}
