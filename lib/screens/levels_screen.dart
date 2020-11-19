// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:mathniac_plus/screens/game_screen.dart';
import 'package:mathniac_plus/screens/home_screen.dart';

import 'package:mathniac_plus/settings/constants.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';

import 'package:mathniac_plus/tasks/layout_level.dart';
import 'package:mathniac_plus/tasks/tasks_functions.dart';
import 'package:mathniac_plus/tasks/tasks_provider.dart';

import 'package:mathniac_plus/widgets/my_button.dart';
import 'package:mathniac_plus/widgets/custom_header.dart';

class LevelsScreen extends StatefulWidget {
  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  double _widthRatio = 2;

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    double _buttonWidth = _screenSize.height / _widthRatio;

    String _stringValue = vStartCountdownValue.toString().substring(0, 2);
    int _scoreLevel = listOfScorePoints[vMagicLevel - 1];

    return Scaffold(
      body: Container(
        decoration: vBackground
            ? vMagicLevel == 15
                ? kBackground15
                : kBackgroundOn
            : kBackgroundOff,
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: _screenSize.height / 30,
            ),
            CustomHeader(text: ' Unlocked Levels '),
            Spacer(),
            LevelsLayout(),
            Spacer(),
            Container(
              width: _buttonWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CustomHeader(
                        text: ' Timer ',
                        widthRatio: 5,
                      ),
                      MyButton(
                        onTap: () {},
                        active: false,
                        text: _stringValue,
                        widthRatio: 5,
                        textRatio: 2,
                        colorPrimary: levelColor(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomHeader(
                        text: ' Score ',
                        widthRatio: 3,
                      ),
                      MyButton(
                        onTap: () {},
                        active: false,
                        text: _scoreLevel.toString(),
                        widthRatio: 3,
                        textRatio: 2,
                        colorPrimary: levelColor(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomHeader(
                        text: ' Goal ',
                        widthRatio: 5,
                      ),
                      MyButton(
                        onTap: () {},
                        active: false,
                        text: vGoalValue.toString(),
                        widthRatio: 5,
                        textRatio: 2,
                        colorPrimary: levelColor(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  onTap: () {
                    vButtonText = ' Start ';
                    vButtonGradient = true;
                    vCountdownValue = vStartCountdownValue;
                    vActualScoreValue = 0;

                    // Set listOfRandoms with zeros => '?'
                    var _model = Provider.of<Randoms>(context, listen: false);
                    _model.setZerosRandomsList();

                    // Set GoalValue text to start value
                    var _resetGoalValue =
                        Provider.of<GoalValue>(context, listen: false);
                    _resetGoalValue.setStartingValue();

                    // Update isSelected List
                    var _isSelected =
                        Provider.of<ClearAllButtons>(context, listen: false);
                    _isSelected.setIsSelectedList();
                  },
                  text: ' Play ',
                  navigator: GameScreen(),
                ),
                MyButton(
                  onTap: () {},
                  text: ' Home ',
                  navigator: HomeScreen(),
                ),
              ],
            ),
            SizedBox(
              height: _screenSize.height / 30,
            ),
          ]),
        ),
      ),
    );
  }
}
