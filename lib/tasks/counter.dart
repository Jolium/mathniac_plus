import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';
import 'package:mathniac_plus/widgets/level_up.dart';

import 'providers.dart';
import 'tasks_functions.dart';

// bool cancelTimer = false;
//
// void cancelCounter({bool cancel}) => cancelTimer = cancel;

int counter(BuildContext context) {
  int counter = vStartCountdownValue;
  const oneMilli = Duration(milliseconds: 100);
  Timer.periodic(oneMilli, (Timer timer) {
    // if (cancelTimer) {
    //   timer.cancel();
    //   context.read(textProvider).set(' Next ');
    //   context.read(gameTickingProvider).stopTicking();
    //   context.read(gradientProvider).set(value: true);
    // } else {
    if (counter <= 0) {
      AudioPlayer().soundPlayer('beep_end.mp3');
      context.read(textProvider).set(' Again ');
      context.read(gameTickingProvider).stopTicking();
      timer.cancel();
    } else {
      counter--;
      context.read(countdownProvider).set(counter);

      if (counter == 50 ||
          counter == 40 ||
          counter == 30 ||
          counter == 20 ||
          counter == 10) {
        AudioPlayer().soundPlayer('beep.mp3');
      }

      final int _scorePointsLevel = listOfScorePoints[vMagicLevel - 1];

      /// Plays sound during game just 1 time when player pass level
      final int actualScore = context.read(scoreProvider.state);
      print('actualScore: $actualScore');
      print('_scorePointsLevel: $_scorePointsLevel');
      // print('vPlayLevelUp: $vPlayLevelUp');
      if (vMagicLevel != 15 &&
          actualScore >= _scorePointsLevel &&
          ///TODO
          // vPlayLevelUp &&
          actualScore != 0) {
        AudioPlayer().soundPlayer('level_up.mp3');
        ///TODO
        // vPlayLevelUp = false;
        print('=== Sett cancelTimer to TRUE');
        context.read(countdownCancelProvider).set(cancelTimer: true);
        timer.cancel();
        context.read(textProvider).set(' Next ');
        context.read(gameTickingProvider).stopTicking();
        context.read(gradientProvider).set(value: true);

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return LevelUp();
            });

        /// Update level
        UpdateValues().getNewLevelValue();

        // cancelCounter2(context: context, cancel: true);
        // cancelCounter(cancel: true);
        // print('cancelTimer: ${context.read(countdownCancelProvider.state)}');
      } else if (vMagicLevel == 15 &&
          actualScore > _scorePointsLevel &&
          ///TODO
          // vPlayLevelUp &&
          actualScore != 0) {
        AudioPlayer().soundPlayer('level_up.mp3');
        ///TODO
        // vPlayLevelUp = false;
      }
    }
    // }
  });
  return counter;
}
