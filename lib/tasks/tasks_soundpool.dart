import 'dart:io';

import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

import '../settings/vars.dart';

enum SOUND_ACTIONS {
  beep,
  beepIOS,
  beepEnd,
  correctSum,
  levelUp,
  pressedButton,
  repeatedNumber,
  startAllButtons,
}

Map<SOUND_ACTIONS, String> actionMapping = {
  SOUND_ACTIONS.beep: "assets/sounds/beep.mp3",
  SOUND_ACTIONS.beepIOS: "assets/sounds/beep.mp3",
  SOUND_ACTIONS.beepEnd: "assets/sounds/beep_end.mp3",
  SOUND_ACTIONS.correctSum: "assets/sounds/correct_sum.mp3",
  SOUND_ACTIONS.levelUp: "assets/sounds/level_up.mp3",
  SOUND_ACTIONS.pressedButton: "assets/sounds/pressed_button.mp3",
  SOUND_ACTIONS.repeatedNumber: "assets/sounds/repeated_number.mp3",
  SOUND_ACTIONS.startAllButtons: "assets/sounds/start_all_buttons.mp3",
};

class SoundManager {
  Map<String, int> sounds = {};
  SoundManager._internal();
  bool even = true;

  Future initSounds() async {
    await Future.forEach(actionMapping.keys, (element) async {
      final String path = actionMapping[element]!;
      final ByteData soundData = await rootBundle.load(path);
      int soundId;
      soundId = await pool.load(soundData);
      sounds[path] = soundId;
    });
  }

  Soundpool pool = Soundpool(streamType: StreamType.alarm);
  static final SoundManager instance = SoundManager._internal();

  Future<void> playSound(SOUND_ACTIONS action) async {
    if (vPlaySound) {
      /// Permits faster sounds on IOS
      if (Platform.isIOS && action == SOUND_ACTIONS.beep) {
        if (even) {
          await pool.play(sounds[actionMapping[SOUND_ACTIONS.beep]]!);
        } else {
          await pool.play(sounds[actionMapping[SOUND_ACTIONS.beepIOS]]!);
        }
        even = !even;

        /// For Android and all IOS sounds not beep
      } else {
        await pool.play(sounds[actionMapping[action]]!);
      }
    }
  }
}
