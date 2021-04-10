import 'dart:io';
import 'dart:math';

// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../settings/constants.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import 'task_hive.dart';

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
        final int _value = 1 + _random.nextInt(9);
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

      /// Check if player already have nickname (ex: reset game)
      if (vMagicLevel == 15) {
        try {
          vNickname = TaskHive().nickname;
        } on SocketException catch (_) {
          vNickname = '';
        }
        if (vNickname != '') {
          listOfScorePoints[14] = TaskHive().highScore;
          vNickname = TaskHive().nickname;
          vUploadScore = TaskHive().getUploadScore;
        }
      }
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

// class AudioPlayer {
//   final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer();
//
//   // void checkPlatform() {
//   //   if (kIsWeb) {
//   //     // Calls to Platform.isIOS fails on web
//   //     return;
//   //   }
//   //   // if (Platform.isIOS) {
//   //   //   if (_audioCache.fixedPlayer != null) {
//   //   //     _audioCache.fixedPlayer.startHeadlessService();
//   //   //   }
//   //   // }
//   // }
//
//   void soundPlayer(String sound) {
//     /// Sound Player
//
//     final String path = 'assets/sounds/$sound';
//
//     if (vPlaySound!) {
//       _audioPlayer.open(Audio(path));
//     }
//   }
// }


// class AudioAssetsPlayer {
//   static final AudioCache _audioCache =
//       // AudioCache(prefix: 'assets/sounds/', respectSilence: true);
//       // fixedPlayer: AudioPlayer()
//       AudioCache(
//     prefix: 'assets/sounds/',
//     respectSilence: true,
//     fixedPlayer: AudioPlayer(),
//   );
//
//   void checkPlatform() {
//     if (kIsWeb) {
//       // Calls to Platform.isIOS fails on web
//       return;
//     }
//     if (Platform.isIOS) {
//       if (_audioCache.fixedPlayer != null) {
//         _audioCache.fixedPlayer!.startHeadlessService();
//       }
//     }
//   }
//
//   void soundPlayer(String sound) {
//     /// Sound Player ///
//     if (vPlaySound) {
//       _audioCache.play(sound);
//       _audioCache.clear(sound);
//     }
//   }
// }

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

