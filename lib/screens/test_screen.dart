import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathniac_plus/tasks/tasks_soundpool.dart';
import 'package:soundpool/soundpool.dart';

import '../settings/backgrounds.dart';
import '../settings/vars.dart';

import '../widgets/custom_header.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Hide bottom bar and top bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    final Size _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: vBackground
            ? vMagicLevel == 15
                ? kBackground15
                : kBackgroundOn
            : kBackgroundOff,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenSize.width / 30),
            child: Column(
              children: [
                SizedBox(
                  height: _screenSize.height / 30,
                ),
                const CustomHeader(text: ' Mathniac '),
                SizedBox(
                  height: _screenSize.height / 20,
                ),
                TextButton(
                  onPressed: () {
                    SoundManager.instance.playSound(SOUND_ACTIONS.beep);
                  },
                  child: const Text(' notification '),
                ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance.sound(SOUND_ACTIONS.beep, StreamType.alarm);
                //   },
                //   child: const Text(' alarm '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance.sound(SOUND_ACTIONS.beep, StreamType.music);
                //   },
                //   child: const Text(' music '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance.sound(SOUND_ACTIONS.beep, StreamType.ring);
                //   },
                //   child: const Text(' ring '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance.playSound(SOUND_ACTIONS.beepEnd);
                //   },
                //   child: const Text(' Beep End '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance.playSound(SOUND_ACTIONS.correctSum);
                //   },
                //   child: const Text(' Correct Sum '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance.playSound(SOUND_ACTIONS.levelUp);
                //   },
                //   child: const Text(' Level Up '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance
                //         .playSound(SOUND_ACTIONS.pressedButton);
                //   },
                //   child: const Text(' Pressed Button '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance
                //         .playSound(SOUND_ACTIONS.repeatedNumber);
                //   },
                //   child: const Text(' Repeated Button '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     SoundManager.instance
                //         .playSound(SOUND_ACTIONS.startAllButtons);
                //   },
                //   child: const Text(' Start All '),
                // ),
                // TextButton(
                //   onPressed: () {
                //     // SoundManager.instance.playSound(SOUND_ACTIONS.beep);
                //     // SoundManager.instance.playSound(SOUND_ACTIONS.beepEnd);
                //     SoundManager.instance.playSound(SOUND_ACTIONS.correctSum);
                //     SoundManager.instance.playSound(SOUND_ACTIONS.levelUp);
                //     // SoundManager.instance
                //     //     .playSound(SOUND_ACTIONS.pressedButton);
                //     // SoundManager.instance
                //     //     .playSound(SOUND_ACTIONS.repeatedNumber);
                //     // SoundManager.instance
                //     //     .playSound(SOUND_ACTIONS.startAllButtons);
                //   },
                //   child: const Text(' All Buttons'),
                //   // navigator: UploadScreen(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
