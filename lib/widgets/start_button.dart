import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../settings/constants.dart';
import '../settings/vars.dart';
import '../settings/lists.dart';

import '../tasks/tasks_functions.dart';
import '../tasks/tasks_provider.dart';
import '../tasks/task_hive.dart';
import '../tasks/custom_route.dart';

import '../screens/levels_screen.dart';
import '../screens/authentication.dart';

class StartButton extends StatefulWidget {
  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  int _score = listOfScorePoints[vMagicLevel - 1];
  int _scoreLevelPoints = listOfScorePoints[vMagicLevel - 1];
  double _sizedBox = 1;
  Color _contentColor = Colors.white;
  double _borderRatio = 3;
  double _marginRatio = 20;
  bool _diagonal = true;

  @override
  void initState() {
    AudioPlayer().checkPlatform();
    // Allows play sound when level up
    vPlayLevelUp = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    double _sizeRatio = _screenSize.height / _screenSize.width / 2;

    double _widthRatio = vIsTimerTicking
        ? 2.5
        : vActualScoreValue >= _score && vMagicLevel != 15
            ? 2.5
            : 3.5;
    double _heightRatio = 5;
    double _textRatio = 2.6;

    double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    double _borderRadius = _buttonSize / _borderRatio * _sizeRatio;
    double _edgeInsets = _buttonSize / _marginRatio * _sizeRatio;
    double _shadowRadius = _buttonSize / _marginRatio * _sizeRatio;
    double _textSize = _buttonSize / _textRatio;

    String _text = vButtonText;
    Color _colorPrimary = kColorSilver;
    Color _colorSecondary = levelColor();
    Color _shadow = kShadow1;

    void _onTapDown(TapDownDetails details) {
      // Player have to play at least one time to watch ads again
      if (!vWatchAds) {
        vWatchAds = true;
      }

      // Update Randoms List
      if (vCountdownValue != 0) {
        AudioPlayer().soundPlayer('start_all_buttons.mp3');

        var _model = Provider.of<Randoms>(context, listen: false);
        _model.setRandomsList();

        // Update isSelected List
        var _isSelected = Provider.of<ClearAllButtons>(context, listen: false);
        _isSelected.setIsSelectedList();

        // Set GoalValue text to start value
        var _resetGoalValue = Provider.of<GoalValue>(context, listen: false);
        _resetGoalValue.setStartingValue();

        // Starts countdown only if it is false to prevent restart during count down
        if (!vIsTimerTicking && !vStartTimer) {
          var _startCountDown = Provider.of<GameTimer>(context, listen: false);
          _startCountDown.startTimerAndTicking();
        }

        setState(() {
          // decreases the button size
          _sizedBox = 0.9;
          vButtonText = ' Refresh ';
          vButtonGradient = false;
        });
      } else if (vCountdownValue == 0) {
        AudioPlayer().soundPlayer('pressed_button.mp3');

        if (vActualScoreValue >= _scoreLevelPoints && vMagicLevel != 15) {
          // Change screen
          Navigator.of(context).pushReplacement(
              CustomRoute(builder: (context) => LevelsScreen()));

          // Update level
          UpdateValues().getNewLevelValue();

          vActualScoreValue = 0;
        }

        // If score is own best score
        if (vMagicLevel == 15 && vActualScoreValue > _scoreLevelPoints) {
          TaskHive().uploadScore(true);

          // Change screen
          Navigator.of(context).pushReplacement(
              CustomRoute(builder: (context) => Authentication()));
        }

        if (vMagicLevel == 15 || vActualScoreValue < _scoreLevelPoints) {
          setState(() {
            vButtonText = ' Start ';
            vButtonGradient = true;
          });

          vCountdownValue = vStartCountdownValue;
          vActualScoreValue = 0;
          vPlayLevelUp = true;

          // Set listOfRandoms with zeros => '?'
          var _model = Provider.of<Randoms>(context, listen: false);
          _model.setZerosRandomsList();

          // Set GoalValue text to start value
          var _resetGoalValue = Provider.of<GoalValue>(context, listen: false);
          _resetGoalValue.setStartingValue();

          // Update isSelected List
          var _isSelected =
              Provider.of<ClearAllButtons>(context, listen: false);
          _isSelected.setIsSelectedList();

          // Rebuild widgets
          var _rebuildWidgets =
              Provider.of<RebuildWidgets>(context, listen: false);
          _rebuildWidgets.rebuild();
        }
      }
    }

    void _onTapUp(TapUpDetails details) {
      setState(() {
        // increases the button size
        _sizedBox = 1;
      });
    }

    return Center(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Container(
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
                  colors: vButtonGradient
                      ? [
                          Colors.black,
                          _colorPrimary,
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
                    color: _shadow.withOpacity(0.8),
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
        ),
      ),
    );
  }
}
