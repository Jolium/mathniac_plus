import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/constants.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/providers.dart';
import '../tasks/score.dart';
import '../tasks/tasks_soundpool.dart';

class GameButton extends StatelessWidget {
  static const double _widthRatio = 5;
  static const double _heightRatio = 5;
  static const double _borderRatio = 3;
  static const double _marginRatio = 20;
  static const double _textRatio = 2;

  final int index;

  const GameButton(this.index);

  @override
  Widget build(BuildContext context) {
    final StateProvider<double> _sizedBoxProvider =
        StateProvider<double>((ref) => 1.0);

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

    void _onTapDown(_) {
      final bool _isSelected =
          context.read(clearAllButtonsProvider.state)[index];
      final int _textValue = context.read(randomsProvider.state)[index];
      final bool isTicking = context.read(gameTickingProvider.state);

      /// Check if timer is already started to prevent restart
      if (isTicking) {
        /// Decrease button size
        context.read(_sizedBoxProvider).state = 0.95;

        /// check if button is already selected
        if (_isSelected) {
          /// Play audio
          SoundManager.instance.playSound(SOUND_ACTIONS.pressedButton);

          /// Deselect button
          context
              .read(selectedListProvider)
              .set(index: index, isSelected: false);

          /// Remove value from selected values
          vListOfSelectedValues.remove(_textValue);

          /// Updates the goal value (MagicValue - SelectedValues)
          context.read(goalProvider).setNewValue();

          /// If button is not selected
        } else {
          /// check if value is already selected
          if (vListOfSelectedValues.contains(_textValue)) {
            /// Play audio
            SoundManager.instance.playSound(SOUND_ACTIONS.repeatedNumber);

            /// Clear all selected buttons (repeated button)
            context.read(selectedListProvider).clear();

            /// Set GoalValue text to start value
            context.read(goalProvider).setStartingValue();

            /// if value is not selected
          } else {
            /// Play audio
            SoundManager.instance.playSound(SOUND_ACTIONS.pressedButton);

            /// Turn true the selected button
            context
                .read(selectedListProvider)
                .set(index: index, isSelected: true);

            /// Add to list of selected values
            vListOfSelectedValues.add(_textValue);

            /// Updates the goal value (MagicValue - SelectedValues)
            context.read(goalProvider).setNewValue();

            /// check if sum of selected values is equal to the magic number
            final int sum =
                vListOfSelectedValues.fold(0, (prev, cur) => prev + cur);

            /// Check if sum of selected numbers is equal to Goal Value
            if (sum > vGoalValue) {
              /// Play audio
              SoundManager.instance.playSound(SOUND_ACTIONS.repeatedNumber);

              /// Clear only the selected buttons
              context.read(selectedListProvider).clear();

              /// Set GoalValue text to start value
              context.read(goalProvider).setStartingValue();

              /// If sum of selected values is greater tha Goal Value
            } else if (sum == vGoalValue) {
              /// PLay audio
              SoundManager.instance.playSound(SOUND_ACTIONS.correctSum);

              /// Update Score Value
              getScoreValue(context);

              ///  set new random number
              context.read(randomsProvider).setOnlySelected();

              /// Set GoalValue text to start value
              context.read(goalProvider).setStartingValue();

              /// Clear the selected buttons
              context.read(selectedListProvider).clear();
            }
          }
        }
      }
    }

    void _onTapUp(_) {
      /// increases the button size
      context.read(_sizedBoxProvider).state = 1.0;
    }

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Consumer(builder: (context, watch, _) {
        final int value = watch(randomsProvider.state)[index];
        final double _sizedBox = watch(_sizedBoxProvider).state;
        final bool _isSelected = watch(selectedListProvider.state)[index];

        final Color _color = _isSelected ? kColor2 : kColor1;
        final Color _shadow = _isSelected
            ? kShadow2.withOpacity(kShadowOpacity2)
            : kShadow1.withOpacity(kShadowOpacity1);
        final List<Color> _colorsList = vMagicLevel <= 14
            ? _isSelected
                ? [
                    kColorBlue,
                    kColorRed,
                    kColorBlue,
                  ]
                : [
                    kColorRed,
                    kColorBlue,
                    kColorRed,
                  ]
            : listIsSelected[index]
                ? [
                    Colors.black,
                    kColorSilver,
                    Colors.black,
                  ]
                : [
                    Colors.black,
                    kColorBronze,
                    Colors.black,
                  ];

        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(_edgeInsets),
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
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _colorsList,
                ),
                border: Border.all(
                  color: _color,
                  width: _edgeInsets,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _shadow.withOpacity(0.8),
                    spreadRadius: _shadowRadius / 2,
                    blurRadius: _shadowRadius,
                  ),
                ],
              ),
              child: Text(
                value == 0 ? '?' : value.toString(),
                style: TextStyle(
                  color: _color,
                  fontSize: _textSize * _sizedBox,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      color: _shadow,
                      spreadRadius: _shadowRadius / 2,
                      blurRadius: _shadowRadius,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
