// import 'dart:io';
//
// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/services.dart';
// import 'package:mathniac_plus/settings/vars.dart';
// import 'package:soundpool/soundpool.dart';
//
// enum TypeAudio {
//   beep,
//   beepEnd,
//   correctSum,
//   levelUp,
//   pressedButton,
//   repeatedNumber,
//   startAllButtons,
// }
//
// Map<TypeAudio, String> audioMapping = {
//   TypeAudio.beep: "assets/sounds/beep.mp3",
//   TypeAudio.beepEnd: "assets/sounds/beep_end.mp3",
//   TypeAudio.correctSum: "assets/sounds/correct_sum.mp3",
//   TypeAudio.levelUp: "assets/sounds/level_up.mp3",
//   TypeAudio.pressedButton: "assets/sounds/pressed_button.mp3",
//   TypeAudio.repeatedNumber: "assets/sounds/repeated_number.mp3",
//   TypeAudio.startAllButtons: "assets/sounds/start_all_buttons.mp3",
// };
//
// class Sound{
//   Map<String, int> sounds = {};
//   Sound._internal();
//
//   Soundpool pool = Soundpool(streamType: StreamType.alarm);
//   static final Sound instance = Sound._internal();
//
//   Future initSounds() async {
//     await Future.forEach(audioMapping.keys, (element) async {
//       final String path = audioMapping[element]!;
//       final ByteData soundData = await rootBundle.load(path);
//       int soundId;
//       soundId = await pool.load(soundData);
//       sounds[path] = soundId;
//     });
//   }
//
//   Future<void> play(TypeAudio audio) async {
//     await pool.play(sounds[audioMapping[audio]]!);
//     // if (vPlaySound) {
//     //   if (Platform.isIOS) {
//     //     final assetsAudioPlayer = AssetsAudioPlayer();
//     //     assetsAudioPlayer.open(Audio(audioMapping[audio]!));
//     //   } else {
//     //     // SoundManager.instance.playSound(audio);
//     //     await pool.play(sounds[audioMapping[audio]]!);
//     //   }
//     // }
//   }
// }
//
// // class AudioAssetsPlayer {
// // //create a new player
// //   final assetsAudioPlayer = AssetsAudioPlayer();
// //
// //   void playSound(String sound) {
// //
// //     final String path = 'assets/sounds/$sound';
// //
// //     if (vPlaySound) {
// //       assetsAudioPlayer.open(Audio(path));
// //     }
// //   }
// // }
//
// // class SoundManager {
// //   Map<String, int> sounds = {};
// //   SoundManager._internal();
// //
// //   Future initSounds() async {
// //     // if (sounds.isNotEmpty) {
// //     //   return;
// //     // }
// //     await Future.forEach(audioMapping.keys, (element) async {
// //       final String path = audioMapping[element]!;
// //       final ByteData soundData = await rootBundle.load(path);
// //       int soundId;
// //       soundId = await pool.load(soundData);
// //       sounds[path] = soundId;
// //     });
// //   }
// //
// //   Soundpool pool = Soundpool(streamType: StreamType.alarm);
// //   static final SoundManager instance = SoundManager._internal();
// //
// //   Future<void> playSound(TypeAudio audio) async {
// //     if (vPlaySound){
// //       await pool.play(sounds[audioMapping[audio]]!);
// //     }
// //   }
// // }