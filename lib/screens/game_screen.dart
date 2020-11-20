import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:provider/provider.dart';

import 'package:mathniac_plus/settings/constants.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';

import 'package:mathniac_plus/tasks/layout_buttons.dart';
import 'package:mathniac_plus/tasks/tasks_functions.dart';
import 'package:mathniac_plus/tasks/tasks_provider.dart';

import 'package:mathniac_plus/widgets/custom_header.dart';
import 'package:mathniac_plus/widgets/my_button.dart';
import 'package:mathniac_plus/widgets/start_button.dart';
import 'package:mathniac_plus/widgets/countdown.dart';

import 'package:mathniac_plus/screens/home_screen.dart';
import 'package:mathniac_plus/screens/levels_screen.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer _timer;

  @override
  void initState() {
    // Check Unlocked Levels and update Timer value
    UpdateValues().getStartTimerValue();
    super.initState();
  }

  void startTimer() {
    const oneMilli = const Duration(milliseconds: 100);
    _timer = Timer.periodic(
      oneMilli,
      (Timer timer) => setState(
        () {
          if (vCountdownValue <= 0) {
            timer.cancel();
          } else {
            vCountdownValue = vCountdownValue - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GameTimer>(context).isTimerTicking;

    // Hide bottom bar and top bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    var _goalValue = Provider.of<GoalValue>(context).newValue;

    var _screenSize = MediaQuery.of(context).size;
    // double _buttonWidth = _screenSize.height / _widthRatio;

    int _score = listOfScorePoints[vMagicLevel - 1];
    int _scorePointsLevel = listOfScorePoints[vMagicLevel - 1];

    if (vStartTimer && vIsTimerTicking) {
      startTimer();
      GameTimer().stopTimer();
    }

    return Scaffold(
      body: Container(
        decoration: vBackground
            ? vMagicLevel == 15
                ? kBackground15
                : kBackgroundOn
            : kBackgroundOff,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: _screenSize.height / 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: _screenSize.width / 5,
                        child: CustomHeader(
                          text: ' Timer ',
                        ),
                      ),
                      CountDown(),
                    ],
                  ),
                  // CountDown(),
                  Column(
                    children: [
                      Container(
                        width: _screenSize.width / 3,
                        child: CustomHeader(
                          text: _scorePointsLevel.toString(),
                        ),
                      ),
                      MyButton(
                        onTap: () {},
                        active: false,
                        widthRatio: 3,
                        textRatio: 2,
                        text: vActualScoreValue.toString(),
                        colorPrimary: levelColor(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: _screenSize.width / 5,
                        child: CustomHeader(
                          text: ' Goal ',
                        ),
                      ),
                      MyButton(
                        onTap: () {},
                        active: false,
                        widthRatio: 5,
                        textRatio: 2,
                        text: _goalValue.toString(),
                        colorPrimary: levelColor(),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              ButtonsLayout(),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    onTap: () {},
                    text: ' Home ',
                    widthRatio: vIsTimerTicking ||
                            vActualScoreValue >= _score && vMagicLevel != 15
                        ? 7
                        : 3.5,
                    heightRatio: vIsTimerTicking ||
                            vActualScoreValue >= _score && vMagicLevel != 15
                        ? 10
                        : 5,
                    active: vIsTimerTicking ||
                            vActualScoreValue >= _score && vMagicLevel != 15
                        ? false
                        : true,
                    navigator: HomeScreen(),
                  ),
                  StartButton(),
                  MyButton(
                    onTap: () {},
                    text: ' Levels ',
                    navigator: LevelsScreen(),
                    widthRatio: vIsTimerTicking ||
                            vActualScoreValue >= _score && vMagicLevel != 15
                        ? 7
                        : 3.5,
                    heightRatio: vIsTimerTicking ||
                            vActualScoreValue >= _score && vMagicLevel != 15
                        ? 10
                        : 5,
                    active: vIsTimerTicking ||
                            vActualScoreValue >= _score && vMagicLevel != 15
                        ? false
                        : true,
                  ),
                ],
              ),
              SizedBox(
                height: _screenSize.height / 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
