import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/authentication.dart';
import '../screens/levels_screen.dart';
import '../settings/constants.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/counter.dart';
import '../tasks/custom_route.dart';
import '../tasks/providers.dart';
import '../tasks/tasks_functions.dart';
import '../tasks/tasks_soundpool.dart';

class StartButton extends StatelessWidget {
  final int _goalLevel = listOfScorePoints[vMagicLevel - 1];
  final int _scoreLevelPoints = listOfScorePoints[vMagicLevel - 1];
  final int _magicLevel = vMagicLevel;

  final Color _contentColor = Colors.white;
  final double _widthRatio = 3.5;
  final double _borderRatio = 3;
  final double _marginRatio = 20;
  final bool _diagonal = true;
  final double _heightRatio = 5;
  final double _textRatio = 2.6;

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;

    final double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    final double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _borderRadius = _buttonSize / _borderRatio * _sizeRatio;
    final double _edgeInsets = _buttonSize / _marginRatio * _sizeRatio;
    final double _shadowRadius = _buttonSize / _marginRatio * _sizeRatio;
    final double _textSize = _buttonSize / _textRatio;

    final Color _colorSecondary = levelColor();

    void _onTapDown(_) {
      /// Player have to play at least one time to watch ads again
      if (!vWatchAds) {
        /// Change Watch Ads to true
        vWatchAds = true;
      }

      /// If countdown is not started or not reached '0'
      final int countdown = context.read(countdownProvider.state);
      if (countdown != 0) {
        /// cancelTimer is true (player reached level score and countdown is stopped)
        final bool cancelTimer = context.read(countdownCancelProvider.state);
        if (cancelTimer) {
          /// Play audio
          SoundManager.instance.playSound(SOUND_ACTIONS.pressedButton);

          /// Set cancelTimer back to false
          context.read(countdownCancelProvider).set(cancelTimer: false);

          /// If Magic Level is NOT 15 and actual score is greater or equal score level points
          final int actualScore = context.read(scoreProvider.state);
          if (_magicLevel != 15 && actualScore >= _scoreLevelPoints) {
            /// Change screen to Levels screen
            /// Show screen with archived levels
            Navigator.of(context).pushReplacement(
                CustomRoute(builder: (context) => LevelsScreen()));

            /// Resets actual score to '0'
            context.read(scoreProvider).set(0);
          }

          /// cancelTimer is false (player still NOT reached level score and countdown is NOT stopped)
        } else {
          /// Play audio
          SoundManager.instance.playSound(SOUND_ACTIONS.startAllButtons);

          /// Decreases the button size
          context.read(sizedBoxProvider).set(0.95);

          /// Set button text to 'Refresh'
          context.read(textProvider).set(' Refresh ');

          /// Change gradient of button
          context.read(gradientProvider).set(value: false);

          /// Set listOfRandoms with random numbers
          context.read(randomsProvider).setRandomsList();

          /// Update isSelected List
          context.read(clearAllButtonsProvider).setIsSelectedList();

          /// Set GoalValue text to start value
          context.read(goalProvider).setStartingValue();

          /// Starts countdown only if it is false to prevent restart during count down
          final bool isTicking = context.read(gameTickingProvider.state);
          if (!isTicking) {
            /// Start countdown
            counter(context);

            /// Change isTicking to true
            context.read(gameTickingProvider).startTicking();
          }
        }

        /// If countdown is equal to 0
      } else {
        /// Play audio
        SoundManager.instance.playSound(SOUND_ACTIONS.pressedButton);

        /// If Magic Level is NOT 15 and actual score is greater or equal score level points
        final int actualScore = context.read(scoreProvider.state);
        if (_magicLevel != 15 && actualScore >= _scoreLevelPoints) {
          /// Change screen to Levels screen
          /// Show screen with archived levels
          Navigator.of(context).pushReplacement(
              CustomRoute(builder: (context) => LevelsScreen()));

          /// Resets actual score to '0'
          context.read(scoreProvider).set(0);
        }

        /// If Magic Level is 15 and score is own best score
        if (_magicLevel == 15 && actualScore > _scoreLevelPoints) {
          /// New best score on level 15
          /// Change screen to Authentication screen
          Navigator.of(context).pushReplacement(
              CustomRoute(builder: (context) => Authentication()));
        }

        /// If Magic Level is 15 or actual score less than score level points
        if (_magicLevel == 15 || actualScore < _scoreLevelPoints) {
          /// Set button text to 'Start'
          context.read(textProvider).set(' Start ');

          /// Change gradient of button
          context.read(gradientProvider).set(value: true);

          /// Resets countdown to start value
          context.read(countdownProvider).reset();

          /// Set listOfRandoms with zeros => '?'
          context.read(randomsProvider).setZerosRandomsList();

          /// Set GoalValue text to start value
          context.read(goalProvider).setStartingValue();

          /// Update isSelected List
          context.read(clearAllButtonsProvider).setIsSelectedList();

          /// Resets actual score to '0'
          context.read(scoreProvider).set(0);
        }
      }
    }

    void _onTapUp(_) {
      /// Restore/Increase the button size
      context.read(sizedBoxProvider).set(1.0);
    }

    return Center(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Consumer(builder: (context, watch, child) {
          final String _text = watch(textProvider.state);
          final bool _gradient = watch(gradientProvider.state);
          final double _sizedBox = watch(sizedBoxProvider.state);
          final int actualScore = context.read(scoreProvider.state);

          final bool isTicking = context.read(gameTickingProvider.state);
          final double _widthRatio = isTicking
              ? 2.5
              : actualScore >= _goalLevel && _magicLevel != 15 ||
                      actualScore > _goalLevel && _magicLevel == 15
                  ? 2.5
                  : 3.5;

          return Container(
            margin: EdgeInsets.all(_edgeInsets),
            alignment: Alignment.center,
            width: _screenSize.width / _widthRatio * _sizeRatio,
            height: _screenSize.width / _heightRatio * _sizeRatio,
            child: SizedBox(
              width: _screenSize.width / _widthRatio * _sizedBox * _sizeRatio,
              height: _screenSize.width / _heightRatio * _sizedBox * _sizeRatio,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      _borderRadius,
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: _diagonal ? Alignment.topLeft : Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: _gradient
                        ? [
                            Colors.black,
                            kColorSilver,
                            Colors.black,
                          ]
                        : [
                            Colors.black,
                            _colorSecondary,
                            Colors.black,
                          ],
                  ),
                  border: Border.all(
                    color: _contentColor,
                    width: _edgeInsets,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kShadow1.withOpacity(0.8),
                      spreadRadius: _shadowRadius / 2,
                      blurRadius: _shadowRadius,
                    ),
                  ],
                ),
                child: Text(
                  _text,
                  style: TextStyle(
                    fontSize: _textSize * _sizedBox,
                    fontWeight: FontWeight.bold,
                    color: _contentColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
