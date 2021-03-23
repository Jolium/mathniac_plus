import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/backgrounds.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/layout_level.dart';
import '../tasks/tasks_functions.dart';
import '../tasks/tasks_provider.dart';
import '../widgets/custom_header.dart';
import '../widgets/my_button.dart';
import 'game_screen.dart';
import 'home_screen.dart';

class LevelsScreen extends StatefulWidget {
  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;

    final String _stringValue = vStartCountdownValue.toString().substring(0, 2);
    final int _scoreLevel = listOfScorePoints[vMagicLevel - 1];

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _screenSize.width / 30),
              child: const CustomHeader(text: ' Unlocked Levels '),
            ),
            const Spacer(),
            LevelsLayout(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: _screenSize.width / 5,
                      child: const CustomHeader(
                        text: ' Timer ',
                      ),
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
                    SizedBox(
                      width: _screenSize.width / 3,
                      child: const CustomHeader(
                        text: ' Score ',
                      ),
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
                    SizedBox(
                      width: _screenSize.width / 5,
                      child: const CustomHeader(
                        text: ' Goal ',
                      ),
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
            const Spacer(),
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
                    final Randoms _model =
                        Provider.of<Randoms>(context, listen: false);
                    _model.setZerosRandomsList();

                    // Set GoalValue text to start value
                    final GoalValue _resetGoalValue =
                        Provider.of<GoalValue>(context, listen: false);
                    _resetGoalValue.setStartingValue();

                    // Update isSelected List
                    final ClearAllButtons _isSelected =
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
