import 'package:flutter/services.dart';
import 'package:mathniac_plus/settings/vars.dart';
import 'package:soundpool/soundpool.dart';

enum SOUND_ACTIONS {
  beep,
  beepEnd,
  correctSum,
  levelUp,
  pressedButton,
  repeatedNumber,
  startAllButtons,
}

class SoundManager {
  Map<SOUND_ACTIONS, String> actionMapping = {
    SOUND_ACTIONS.beep: "assets/sounds/beep.mp3",
    SOUND_ACTIONS.beepEnd: "assets/sounds/beep_end.mp3",
    SOUND_ACTIONS.correctSum: "assets/sounds/correct_sum.mp3",
    SOUND_ACTIONS.levelUp: "assets/sounds/level_up.mp3",
    SOUND_ACTIONS.pressedButton: "assets/sounds/pressed_button.mp3",
    SOUND_ACTIONS.repeatedNumber: "assets/sounds/repeated_number.mp3",
    SOUND_ACTIONS.startAllButtons: "assets/sounds/start_all_buttons.mp3",
  };

  Map<String, int> sounds = {};
  SoundManager._internal();

  Future initSounds() async {
    // if (sounds.isNotEmpty) {
    //   return;
    // }
    await Future.forEach(actionMapping.keys, (element) async {
      final String path = actionMapping[element]!;
      final ByteData soundData = await rootBundle.load(path);
      int soundId;
      soundId = await pool.load(soundData);
      sounds[path] = soundId;
    });
  }

  Soundpool pool = Soundpool(streamType: StreamType.notification);
  static final SoundManager instance = SoundManager._internal();

  Future<void> playSound(SOUND_ACTIONS action) async {
    if (vPlaySound){
      await pool.play(sounds[actionMapping[action]]!);
    }
  }

  Future<void> sound(SOUND_ACTIONS action, StreamType streamType) async {
    final Soundpool _pool = Soundpool(streamType: streamType);

    if (vPlaySound){
      await _pool.play(sounds[actionMapping[action]]!);
    }
  }


  // Future<void>attachToCity(Sloboda city) async {
  //   await initSounds();
  //   city.changes.where((event) => actionMapping[event] != null).listen((event) {
  //     playSound(event as SOUND_ACTIONS);
  //   });
  // }
  //
  // dynamic subscribeSoundManager() {
  //   return SoundManager.instance.attachToCity(this);
  // }
}




