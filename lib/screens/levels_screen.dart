import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/backgrounds.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/layout_level.dart';
import '../tasks/providers.dart';
import '../tasks/tasks_functions.dart';
import '../widgets/custom_header.dart';
import '../widgets/my_button2.dart';
import 'game_screen.dart';
import 'home_screen.dart';

class LevelsScreen extends StatelessWidget {
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
                    /// Set listOfRandoms with zeros => '?'
                    context.read(randomsProvider).setZerosRandomsList();

                    /// Set GoalValue text to start value
                    context.read(goalProvider).setStartingValue();

                    /// Update isSelected List
                    context.read(clearAllButtonsProvider).setIsSelectedList();
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
