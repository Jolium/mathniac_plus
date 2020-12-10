import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../settings/vars.dart';
import '../settings/constants.dart';
import '../settings/lists.dart';

import 'tasks_provider.dart';
import 'tasks_functions.dart';
import 'score_system.dart';

class ButtonsLayout extends StatefulWidget {
  final double size = 1;

  @override
  _ButtonsLayoutState createState() => _ButtonsLayoutState();
}

class _ButtonsLayoutState extends State<ButtonsLayout> {
  double _widthRatio = 5;
  double _heightRatio = 5;
  double _borderRatio = 3;
  double _marginRatio = 20;
  double _textRatio = 2;

  List<Widget> rowElements = [];

  @override
  void initState() {
    AudioPlayer().checkPlatform();
    super.initState();
  }

  List<Widget> generateRowElements() {
    double _sizedBox = widget.size;

    rowElements.clear();
    var _screenSize = MediaQuery.of(context).size;
    double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    double _borderRadius = _buttonSize / _borderRatio * _sizeRatio;
    double _edgeInsets = _buttonSize / _marginRatio * _sizeRatio;
    double _shadowRadius = _buttonSize / _marginRatio * _sizeRatio;
    double _textSize = _buttonSize / _textRatio * _sizedBox;

    for (int i = 0; i < listIsSelected.length; i++) {
      int _textValue = Provider.of<Randoms>(context).randomsList[i];
      bool _isSelected =
          Provider.of<ClearAllButtons>(context).isSelectedList[i];

      Color _color = listIsSelected[i] ? kColor2 : kColor1;
      Color _shadow = listIsSelected[i]
          ? kShadow2.withOpacity(kShadowOpacity2)
          : kShadow1.withOpacity(kShadowOpacity1);

      List<Color> _colorsList = vMagicLevel <= 14
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

      void _onTapDown(TapDownDetails details) {
        if (vIsTimerTicking) {
          setState(() {
            // decreases the button size
            _sizedBox = 0.9;
          });

          // check if button is already selected
          if (_isSelected) {
            AudioPlayer().soundPlayer('pressed_button.mp3');

            listIsSelected[i] = false;
            vListOfSelectedValues.remove(_textValue);

            // Updates the goal value (MagicValue - SelectedValues)
            var _updateGoal = Provider.of<GoalValue>(context, listen: false);
            _updateGoal.setNewValue();

            // if button is not selected
          } else {
            // check if value is already selected
            if (vListOfSelectedValues.contains(_textValue)) {
              AudioPlayer().soundPlayer('repeated_number_value.mp3');

              clearSelectedButtons(listOfRandoms);

              // Set GoalValue text to start value
              var _resetGoalValue =
                  Provider.of<GoalValue>(context, listen: false);
              _resetGoalValue.setStartingValue();

              // if value is not selected
            } else {
              AudioPlayer().soundPlayer('pressed_button.mp3');
              listIsSelected[i] = true;
              vListOfSelectedValues.add(_textValue);

              // Updates the goal value (MagicValue - SelectedValues)
              var _updateGoal = Provider.of<GoalValue>(context, listen: false);
              _updateGoal.setNewValue();

              // check if sum of selected values is equal to the magic number
              int sum =
                  vListOfSelectedValues.fold(0, (prev, cur) => prev + cur);

              if (sum > vGoalValue) {
                AudioPlayer().soundPlayer('repeated_number_value.mp3');

                // Clear only the selected buttons
                ClearOnlyButtons().resetSelectedButtons();

                // Set GoalValue text to start value
                var _resetGoalValue =
                    Provider.of<GoalValue>(context, listen: false);
                _resetGoalValue.setStartingValue();
              } else if (sum == vGoalValue) {
                AudioPlayer().soundPlayer('correct_sum.mp3');

                // Update Score Value
                ScoreSystem().getScoreValue();

                // Clear the selected buttons and set new random number
                ClearOnlyButtons().setRandomsList(listOfRandoms);

                // Set GoalValue text to start value
                var _resetGoalValue =
                    Provider.of<GoalValue>(context, listen: false);
                _resetGoalValue.setStartingValue();
              }
            }
          }
        }
      }

      void _onTapUp(TapUpDetails details) {
        setState(() {
          // increases the button size
          _sizedBox = 1;
        });
      }

      Widget elementTile = GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Container(
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
                _textValue == 0 ? '?' : _textValue.toString(),
                style: TextStyle(
                  color: _color,
                  fontSize: _textSize,
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
        ),
      );
      rowElements.add(elementTile);
    }
    return rowElements;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = generateRowElements();

    if (vMagicLevel <= 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [for (int i = 0; i <= 1; i++) list[i]],
              ),
              Row(
                children: [for (int i = 2; i <= 5; i++) list[i]],
              ),
              Row(
                children: [for (int i = 6; i <= 9; i++) list[i]],
              ),
              Row(
                children: [for (int i = 10; i <= 11; i++) list[i]],
              ),
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
              Row(
                children: [for (int i = 0; i <= 2; i++) list[i]],
              ),
              Row(
                children: [for (int i = 3; i <= 6; i++) list[i]],
              ),
              Row(
                children: [for (int i = 7; i <= 10; i++) list[i]],
              ),
              Row(
                children: [for (int i = 11; i <= 13; i++) list[i]],
              ),
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
              Row(
                children: [for (int i = 0; i <= 1; i++) list[i]],
              ),
              Row(
                children: [for (int i = 2; i <= 5; i++) list[i]],
              ),
              Row(
                children: [for (int i = 6; i <= 9; i++) list[i]],
              ),
              Row(
                children: [for (int i = 10; i <= 13; i++) list[i]],
              ),
              Row(
                children: [for (int i = 14; i <= 15; i++) list[i]],
              ),
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
              Row(
                children: [for (int i = 0; i <= 2; i++) list[i]],
              ),
              Row(
                children: [for (int i = 3; i <= 6; i++) list[i]],
              ),
              Row(
                children: [for (int i = 7; i <= 10; i++) list[i]],
              ),
              Row(
                children: [for (int i = 11; i <= 14; i++) list[i]],
              ),
              Row(
                children: [for (int i = 15; i <= 17; i++) list[i]],
              ),
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
              Row(
                children: [for (int i = 0; i <= 3; i++) list[i]],
              ),
              Row(
                children: [for (int i = 4; i <= 7; i++) list[i]],
              ),
              Row(
                children: [for (int i = 8; i <= 11; i++) list[i]],
              ),
              Row(
                children: [for (int i = 12; i <= 15; i++) list[i]],
              ),
              Row(
                children: [for (int i = 16; i <= 19; i++) list[i]],
              ),
            ],
          ),
        ],
      );
    }
  }
}
