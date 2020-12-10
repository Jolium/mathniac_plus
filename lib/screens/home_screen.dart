import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../settings/constants.dart';
import '../settings/vars.dart';

import '../tasks/tasks_functions.dart';
import '../tasks/tasks_provider.dart';

import '../widgets/my_button.dart';
import '../widgets/custom_header.dart';

import 'reward_screen.dart';
import 'settings_screen.dart';
import 'levels_screen.dart';
import 'intro_screen.dart';
import 'scores_screen.dart';
import 'game_screen.dart';
import 'authentication.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool checkLeaderboard() {
    if (vMagicLevel == 15 && vUploadScore) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hide bottom bar and top bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    var _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: vBackground
            ? vMagicLevel == 15
                ? kBackground15
                : kBackgroundOn
            : kBackgroundOff,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenSize.width / 30),
            child: Column(
              children: [
                SizedBox(
                  height: _screenSize.height / 30,
                ),
                CustomHeader(text: ' Mathniac '),
                SizedBox(
                  height: _screenSize.height / 20,
                ),
                MyButton(
                  onTap: () {},
                  text: ' Intro ',
                  navigator: IntroScreen(),
                ),
                MyButton(
                  onTap: () {},
                  text: ' Levels ',
                  navigator: LevelsScreen(),
                ),
                MyButton(
                  onTap: () {},
                  text: ' Settings ',
                  navigator: SettingsScreen(),
                  // navigator: UploadScreen(),
                ),
                MyButton(
                  onTap: () async {
                    // Check internet connection
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        print('connected');
                        vInternetConnection = true;
                      }
                    } on SocketException catch (_) {
                      print('not connected');
                      vInternetConnection = false;
                    }
                  },
                  text: ' Scores ',
                  navigator: ScoresScreen(),
                ),
                Spacer(),
                MyButton(
                  contentColor: Colors.yellowAccent,
                  onTap: () async {
                    // Check internet connection
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        print('connected');
                        vInternetConnection = true;
                      }
                    } on SocketException catch (_) {
                      print('not connected');
                      vInternetConnection = false;
                    }
                  },
                  text: ' Level Up ',
                  navigator: RewardScreen(),
                ),
                Spacer(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: _screenSize.width / 5),
                  child: CustomHeader(
                    text: ' Level $vMagicLevel ',
                    widthRatio: 2,
                    colorText: levelColor(),
                    shadowText: levelColor(),
                  ),
                ),
                SizedBox(
                  height: _screenSize.width / 30,
                ),
                MyButton(
                  onTap: checkLeaderboard()
                      ? () {}
                      : () {
                          vButtonText = ' Start ';
                          vButtonGradient = true;
                          vCountdownValue = vStartCountdownValue;
                          vActualScoreValue = 0;

                          // Set listOfRandoms with zeros => '?'
                          var _model =
                              Provider.of<Randoms>(context, listen: false);
                          _model.setZerosRandomsList();

                          // Set GoalValue text to start value
                          var _resetGoalValue =
                              Provider.of<GoalValue>(context, listen: false);
                          _resetGoalValue.setStartingValue();

                          // Update isSelected List
                          var _isSelected = Provider.of<ClearAllButtons>(
                              context,
                              listen: false);
                          _isSelected.setIsSelectedList();
                        },
                  text: ' Play ',
                  navigator:
                      checkLeaderboard() ? Authentication() : GameScreen(),
                ),
                SizedBox(
                  height: _screenSize.height / 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
