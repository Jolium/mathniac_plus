import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:audioplayers/audio_cache.dart';
// import 'package:flutter/services.dart';

import 'package:mathniac_plus/tasks/task_hive.dart';
import 'package:mathniac_plus/tasks/tasks_provider.dart';

import 'package:mathniac_plus/settings/vars.dart';
import 'package:mathniac_plus/settings/constants.dart';
import 'package:mathniac_plus/settings/lists.dart';

class ClearOnlyButtons {
  /// Deselect ONLY selected buttons and only UPDATE the list of selected buttons

  final _random = Random();

  List<int> _randomsList = listOfRandoms;

  List<int> get randomsList => _randomsList;

  void resetSelectedButtons() {
    vListOfSelectedValues.clear();

    for (int index = 0; index < listIsSelected.length; index++) {
      if (listIsSelected[index] == true) {
        listIsSelected[index] = false;
      }
    }
  }

  void setRandomsList(List<int> randomsList) {
    vListOfSelectedValues.clear();

    for (int index = 0; index < listIsSelected.length; index++) {
      if (listIsSelected[index] == true) {
        int _value = 1 + _random.nextInt(9);
        randomsList[index] = _value;
        listIsSelected[index] = false;
      }
    }
    _randomsList = randomsList;
  }
}

class UpdateValues {
  void getStartTimerValue() {
    /// Update Timer value

    vStartCountdownValue = listOfSeconds[vMagicLevel - 1];
    updateUnlockedLevels();
  }

  void getNewLevelValue() {
    /// Update Magic level

    if (vMagicLevel < 15) {
      vMagicLevel = vMagicLevel + 1;
      if (!kIsWeb) {
        TaskHive().updateLevel(vMagicLevel);
      }
      vGoalValue = vGoalValue + 1;
      getStartTimerValue();
    }
  }

  void updateUnlockedLevels() {
    /// Recreate listGotLevel[]

    for (int index = 0; index < 15; index++) {
      if (index < vMagicLevel) {
        listGotLevel[index] = true;
      } else {
        listGotLevel[index] = false;
      }
    }
  }
}

class UpdateGoalValues {
  void getGoalValue() {
    vGoalValue = 10 + vMagicLevel - 1;
  }
}

void clearSelectedButtons(List<int> randomsList) {
  /// ONLY deselect the selected buttons ///

  vListOfSelectedValues.clear();

  for (int index = 0; index < listIsSelected.length; index++) {
    if (listIsSelected[index] == true) {
      listIsSelected[index] = false;
    }
  }
}

class AudioPlayer {
  AudioCache _audioCache =
      AudioCache(prefix: 'assets/sounds/', respectSilence: true);

  void checkPlatform() {
    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (_audioCache.fixedPlayer != null) {
        _audioCache.fixedPlayer.startHeadlessService();
      }
    }
  }

  void soundPlayer(String sound) {
    /// Sound Player ///
    if (vPlaySound) {
      _audioCache.play(sound);
    }
  }
}

void clearAllGameScreen() {
  /// Set Game screen to starting point
  vActualScoreValue = 0;
  vCountdownValue = vStartCountdownValue;
  GameTimer().stopTimerTicking();
  ClearAllButtons().setIsSelectedList();
  GoalValue().setStartingValue();
  Randoms().setZerosRandomsList();
}

Color levelColor() {
  if (vMagicLevel <= 3) {
    return kColorGreen;
  } else if (vMagicLevel <= 7) {
    return kColorBlue;
  } else if (vMagicLevel <= 11) {
    return kColorViolet;
  } else if (vMagicLevel <= 14) {
    return kColorRed;
  } else {
    return kColorSilver;
  }
}
