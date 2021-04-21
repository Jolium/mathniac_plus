import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/constants.dart';
import '../settings/vars.dart';
import '../tasks/providers.dart';
import '../tasks/score.dart';
import '../tasks/tasks_soundpool.dart';

class ButtonsLayout extends StatelessWidget {
  final double _widthRatio = 5;
  final double _heightRatio = 5;
  final double _borderRatio = 3;
  final double _marginRatio = 20;
  final double _textRatio = 2;

  final List<Widget> rowElements = [];

  List<Widget> generateRowElements(BuildContext context) {
    final List<bool> listIsSelected = context.read(selectedListProvider.state);

    rowElements.clear();
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

    for (int i = 0; i < listIsSelected.length; i++) {
      void _onTapDown(_) {
        final bool _isSelected = context.read(clearAllButtonsProvider.state)[i];
        final int _textValue = context.read(randomsProvider.state)[i];
        final bool isTicking = context.read(gameTickingProvider.state);

        /// Check if timer is already started to prevent restart
        if (isTicking) {
          /// Decrease button size
          context.read(gameSizedBoxProvider).set(index: i, size: 0.95);

          /// check if button is already selected
          if (_isSelected) {
            /// Play audio
            SoundManager.instance.playSound(SOUND_ACTIONS.pressedButton);

            /// Deselect button
            context.read(selectedListProvider).set(index: i, isSelected: false);

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

              /// Clear all selected values (repeated button)
              vListOfSelectedValues.clear();

              /// Set GoalValue text to start value
              context.read(goalProvider).setStartingValue();

              /// if value is not selected
            } else {
              /// Play audio
              SoundManager.instance.playSound(SOUND_ACTIONS.pressedButton);

              /// Turn true the selected button
              context
                  .read(selectedListProvider)
                  .set(index: i, isSelected: true);

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

                /// Clear list of selected values
                vListOfSelectedValues.clear();

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

                /// Clear list of selected values
                vListOfSelectedValues.clear();

                /// Clear the selected buttons
                context.read(selectedListProvider).clear();
              }
            }
          }
        }
      }

      void _onTapUp(_) {
        /// increases the button size
        context.read(gameSizedBoxProvider).set(index: i, size: 1.0);
      }

      final Widget elementTile = GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Consumer(builder: (context, watch, child) {
          final int value = watch(randomsProvider.state)[i];
          final double _sizedBox = watch(gameSizedBoxProvider.state)[i];
          final Color _color = listIsSelected[i] ? kColor2 : kColor1;
          final Color _shadow = listIsSelected[i]
              ? kShadow2.withOpacity(kShadowOpacity2)
              : kShadow1.withOpacity(kShadowOpacity1);
          final List<Color> _colorsList = vMagicLevel <= 14
              ? listIsSelected[i]
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
              : listIsSelected[i]
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
      rowElements.add(elementTile);
    }
    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    /// Create list/grid of buttons
    final List<Widget> list = generateRowElements(context);

    if (vMagicLevel <= 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(children: [for (int i = 0; i <= 1; i++) list[i]]),
              Row(children: [for (int i = 2; i <= 5; i++) list[i]]),
              Row(children: [for (int i = 6; i <= 9; i++) list[i]]),
              Row(children: [for (int i = 10; i <= 11; i++) list[i]]),
            ],
          ),
        ],
      );
    } else if (vMagicLevel <= 7) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(children: [for (int i = 0; i <= 2; i++) list[i]]),
              Row(children: [for (int i = 3; i <= 6; i++) list[i]]),
              Row(children: [for (int i = 7; i <= 10; i++) list[i]]),
              Row(children: [for (int i = 11; i <= 13; i++) list[i]]),
            ],
          ),
        ],
      );
    } else if (vMagicLevel <= 11) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(children: [for (int i = 0; i <= 1; i++) list[i]]),
              Row(children: [for (int i = 2; i <= 5; i++) list[i]]),
              Row(children: [for (int i = 6; i <= 9; i++) list[i]]),
              Row(children: [for (int i = 10; i <= 13; i++) list[i]]),
              Row(children: [for (int i = 14; i <= 15; i++) list[i]]),
            ],
          ),
        ],
      );
    } else if (vMagicLevel <= 15) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(children: [for (int i = 0; i <= 2; i++) list[i]]),
              Row(children: [for (int i = 3; i <= 6; i++) list[i]]),
              Row(children: [for (int i = 7; i <= 10; i++) list[i]]),
              Row(children: [for (int i = 11; i <= 14; i++) list[i]]),
              Row(children: [for (int i = 15; i <= 17; i++) list[i]]),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(children: [for (int i = 0; i <= 3; i++) list[i]]),
              Row(children: [for (int i = 4; i <= 7; i++) list[i]]),
              Row(children: [for (int i = 8; i <= 11; i++) list[i]]),
              Row(children: [for (int i = 12; i <= 15; i++) list[i]]),
              Row(children: [for (int i = 16; i <= 19; i++) list[i]]),
            ],
          ),
        ],
      );
    }
  }
}
