import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/vars.dart';

import 'providers.dart';


// int _extraTime = 0;

void getScoreValue(BuildContext context) {
  final int _sumSelected =
      vListOfSelectedValues.fold(0, (prev, cur) => prev + cur);
  final int _lengthSelected = vListOfSelectedValues.length;

  int _newValue = 0;
  double _extraTime = 0.0;

  void _updateValues() {
    // vActualScoreValue = vActualScoreValue + _newValue;
    context.read(scoreProvider).add(_newValue);

    _extraTime = _extraTime + (_newValue / vPointsToWinSecond);

    if (_extraTime >= 1 && _extraTime < 2) {
      _extraTime--;
      // vCountdownValue = vCountdownValue + 10;
      // print(context.read(countdownProvider.state));
      context.read(countdownProvider).add(10);
      // print(context.read(countdownProvider.state));
      // _extraTime++;
    } else if (_extraTime >= 2) {
      _extraTime = _extraTime - 2;
      // vCountdownValue = vCountdownValue + 20;
      // print(context.read(countdownProvider.state));
      context.read(countdownProvider).add(20);
      // print(context.read(countdownProvider.state));
      // _extraTime = _extraTime + 2;
    }

    // print('_extraTime: $_extraTime');
    // print('vExtraTime: $vExtraTime');
  }

  if (_sumSelected == vGoalValue) {
    if (_lengthSelected == 2) {
      /// 2 * 5 = 10
      _newValue = 10;
    } else if (_lengthSelected == 3) {
      /// 3 * 6 = 18
      _newValue = 18;
    } else if (_lengthSelected == 4) {
      /// 4 * 7 = 28
      _newValue = 28;
    } else if (_lengthSelected == 5) {
      /// 5 * 8 = 40;
      _newValue = 40;
    } else if (_lengthSelected == 6) {
      /// 6 * 9 = 54
      _newValue = 54;
    } else if (_lengthSelected == 7) {
      /// 7 * 10 = 70
      _newValue = 70;
    }
  } else {
    _newValue = 0;
  }
  _updateValues();
}
