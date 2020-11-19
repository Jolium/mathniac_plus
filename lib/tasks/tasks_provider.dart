import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

import 'package:mathniac_plus/settings/vars.dart';
import 'package:mathniac_plus/settings/lists.dart';

class Randoms extends ChangeNotifier {
  /// Creates a new list with random integers ///

  final _random = Random();
  List<int> _randomsList = listOfRandoms;
  List<int> get randomsList => _randomsList;

  void setRandomsList() {
    for (int index = 0; index < listIsSelected.length; index++) {
      int _value = 1 + _random.nextInt(9);
      _randomsList[index] = _value;
    }
    notifyListeners();
  }

  void setZerosRandomsList() {
    // randomsList.clear();

    for (int index = 0; index < listIsSelected.length; index++) {
      _randomsList[index] = 0;
    }
    notifyListeners();
  }
}

class ClearAllButtons extends ChangeNotifier {
  /// Deselect ALL buttons and clear the list of selected buttons ///

  List<bool> _isSelectedList = listIsSelected;

  List<bool> get isSelectedList => _isSelectedList;

  void setIsSelectedList() {
    vListOfSelectedValues.clear();

    for (int index = 0; index < listIsSelected.length; index++) {
      _isSelectedList[index] = false;
    }
    notifyListeners();
  }
}

class GameTimer extends ChangeNotifier {
  /// Starts the countdown ///

  bool _isTimerTicking = vIsTimerTicking;
  bool get isTimerTicking => _isTimerTicking;

  bool _startTimer = vStartTimer;
  bool get startTimer => _startTimer;

  void startTimerAndTicking() {
    _isTimerTicking = true;
    vIsTimerTicking = true;

    _startTimer = true;
    vStartTimer = true;

    notifyListeners();
  }

  void stopTimerTicking() {
    _isTimerTicking = false;
    vIsTimerTicking = false;

    notifyListeners();
  }

  void stopTimer() {
    _startTimer = false;
    vStartTimer = false;

    notifyListeners();
  }
}

class GoalValue extends ChangeNotifier {
  /// Starts the countdown ///

  int _newValue = vGoalValue;

  int get newValue => _newValue;

  void setNewValue() {
    int _sumSelected = vListOfSelectedValues.fold(0, (prev, cur) => prev + cur);
    _newValue = vGoalValue - _sumSelected;
    notifyListeners();
  }

  void setStartingValue() {
    _newValue = vGoalValue;
    notifyListeners();
  }
}

class RebuildWidgets extends ChangeNotifier {
  /// Change the text of the start button ///

  bool _rebuildWidget = false;

  bool get rebuildWidget => _rebuildWidget;

  void rebuild() {
    _rebuildWidget = _rebuildWidget ? false : true;
    notifyListeners();
  }
}
