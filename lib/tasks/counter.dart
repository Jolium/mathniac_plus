import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';
import 'package:mathniac_plus/tasks/task_hive.dart';
import 'package:mathniac_plus/widgets/level_up.dart';

import 'providers.dart';
import 'tasks_functions.dart';

void counter(BuildContext context) {
  bool _playAudio = true;
  const oneMilli = Duration(milliseconds: 100);

  /// Get the Goal score for the respective level
  final int _scorePointsLevel = listOfScorePoints[vMagicLevel - 1];

  Timer.periodic(oneMilli, (Timer timer) {

    /// If counter is less or equal to '0'
    final int counter = context.read(countdownProvider.state);
    if (counter <= 0) {
      /// PLay audio
      AudioPlayer().soundPlayer('beep_end.mp3');

      /// Plays sound during game just 1 time when player pass level
      final int actualScore = context.read(scoreProvider.state);

      /// If Magic level is '15' and actual score is > than Goal level
      if (vMagicLevel == 15 &&
          actualScore > _scorePointsLevel &&
          actualScore != 0) {

        /// Set Start button text to ' Next '
        context.read(textProvider).set(' Next ');

        /// If Magic level is NOT '15'
      } else {

        /// Set Start button text to ' Again '
        context.read(textProvider).set(' Again ');
      }

      /// Stop Timer Ticking
      context.read(gameTickingProvider).stopTicking();

      /// Stop Timer
      timer.cancel();

      /// If counter is NOT '0'
    } else {

      /// Decrease counter by '1'
      context.read(countdownProvider).decrease();

      /// Play audio on the last 5 seconds
      if (counter == 50 ||
          counter == 40 ||
          counter == 30 ||
          counter == 20 ||
          counter == 10) {
        AudioPlayer().soundPlayer('beep.mp3');
      }

      /// Get the Goal score for the respective level
      final int _scorePointsLevel = listOfScorePoints[vMagicLevel - 1];

      /// Plays sound during game just 1 time when player pass level
      final int actualScore = context.read(scoreProvider.state);

      /// Magic level is less than 15 and actual score is >= to the Goal level score
      if (vMagicLevel != 15 &&
          actualScore >= _scorePointsLevel &&
          actualScore != 0) {
        /// Play audio
        AudioPlayer().soundPlayer('level_up.mp3');

        /// Set countdownCancel to TRUE (play reached level score)
        context.read(countdownCancelProvider).set(cancelTimer: true);

        /// Stop timer
        timer.cancel();

        /// Set Start button text to ' Next '
        context.read(textProvider).set(' Next ');

        /// Stop Timer Ticking
        context.read(gameTickingProvider).stopTicking();

        /// Change gradient of Start button
        context.read(gradientProvider).set(value: true);

        /// Show PopUp with Level Up warning
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return LevelUp();
            });

        /// Update level
        UpdateValues().getNewLevelValue();

        /// Magic level is equal 15 and actual score is > to the Goal level score
      } else if (vMagicLevel == 15 &&
          actualScore > _scorePointsLevel &&
          actualScore != 0) {
        /// If _playAudio is TRUE (to play audio only once)
        if (_playAudio) {
          /// Play audio
          AudioPlayer().soundPlayer('level_up.mp3');
        }

        /// Set _playAudio to false to prevent it to play more than once
        _playAudio = false;

        // /// Save new best score on storage
        // TaskHive().uploadScore(value: true);

        /// Save new best score on storage
        TaskHive().updateHighScore(actualScore);
      }
    }
    // }
  });
  // return context.read(countdownProvider.state);
}
