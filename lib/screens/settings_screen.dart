import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../settings/backgrounds.dart';
import '../settings/constants.dart';
// import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/task_hive.dart';
import '../tasks/tasks_functions.dart';
import '../widgets/custom_header.dart';
import '../widgets/my_button2.dart';
import 'home_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final double _widthRatio = 1.1;
  final double _heightRatio = 1.1;
  final double _borderRatio = 10;
  final double _marginRatio = 20;
  final double _textRatio = 10;

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    final double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    final double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _textSize = _buttonSize / _textRatio;
    final double _borderRadius = _buttonSize / _borderRatio;
    final double _edgeInsets = _buttonSize / _marginRatio;

    final Widget _alertDialog = AlertDialog(
      elevation: 24.0,
      buttonPadding: EdgeInsets.all(_borderRadius / 4),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(_borderRadius / 2),
        ),
        side: BorderSide(color: Colors.white60, width: _edgeInsets / 4),
      ),
      title: Text(
        'Reset values?',
        style: TextStyle(
          color: Colors.white,
          fontSize: _textSize / 1.8,
          fontFamily: kLetterType1,
        ),
      ),
      content: Text(
        vMagicLevel == 15
            ? 'Do you really want to return to level 1\n'
                'Nickname and highest score will be saved.'
            : 'Do you really want to return to level 1?',
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.white,
          fontSize: _textSize / 2,
        ),
      ),
      actions: [
        TextButton(
          /// TODO: on production delete from here ///
          onLongPress: () {
            setState(() {
              vMagicLevel = 15;
              // listOfScorePoints[14] = 0;
              if (!kIsWeb) {
                TaskHive().updateLevel(15);
                // TaskHive().updateHighScore(0);
              }
              vBackground = true;
              UpdateValues().getStartTimerValue();
              UpdateGoalValues().getGoalValue();
            });
            Navigator.of(context).pop();
          },

          /// TODO: on production delete till here ///
          onPressed: () {
            setState(() {
              /// High score and nickname will be saved
              vMagicLevel = 1;
              // listOfScorePoints[14] = 0;
              if (!kIsWeb) {
                TaskHive().updateLevel(1);
                // TaskHive().updateHighScore(0);
                // TaskHive().saveNickname('');
              }
              vBackground = true;
              UpdateValues().getStartTimerValue();
              UpdateGoalValues().getGoalValue();
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Yes',
            style: TextStyle(
              fontSize: _textSize / 1.5,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'No',
            style: TextStyle(
              fontSize: _textSize / 1.5,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: vBackground
            ? vMagicLevel == 15
                ? kBackground15
                : kBackgroundOn
            : kBackgroundOff,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _screenSize.width / 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: _screenSize.height / 30),
                const CustomHeader(text: ' Settings '),
                SizedBox(height: _screenSize.height / 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: _screenSize.width / 2,
                      child: const CustomHeader(
                        text: ' Sound ',
                        heightRatio: 8,
                      ),
                    ),
                    SizedBox(width: _screenSize.width / 30),
                    MyButton(
                      widthRatio: 5,
                      icon: vPlaySound ? Icons.volume_up : Icons.volume_off,
                      contentColor:
                          vPlaySound ? Colors.yellowAccent : Colors.black,
                      shadow: vPlaySound ? Colors.yellowAccent : Colors.black,
                      onTap: () {
                        setState(() {
                          if (vPlaySound) {
                            vPlaySound = false;
                          } else {
                            vPlaySound = true;
                          }
                        });
                        if (!kIsWeb) {
                          TaskHive().updateSound(value: vPlaySound);
                        }
                      },
                    )
                  ],
                ),
                SizedBox(height: _screenSize.height / 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: _screenSize.width / 2,
                      child: const CustomHeader(
                        text: ' Background ',
                        heightRatio: 8,
                      ),
                    ),
                    SizedBox(width: _screenSize.width / 30),
                    MyButton(
                      widthRatio: 5,
                      icon: vBackground ? Icons.check : Icons.close,
                      contentColor:
                          vBackground ? Colors.yellowAccent : Colors.black,
                      shadow: vBackground ? Colors.yellowAccent : Colors.black,
                      onTap: () {
                        setState(() {
                          if (vBackground) {
                            vBackground = false;
                          } else {
                            vBackground = true;
                          }
                        });
                        if (!kIsWeb) {
                          TaskHive().updateBackground(value: vBackground);
                        }
                      },
                    )
                  ],
                ),
                SizedBox(height: _screenSize.height / 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: _screenSize.width / 2,
                      child: const CustomHeader(
                        text: ' Reset ',
                        heightRatio: 8,
                      ),
                    ),
                    SizedBox(width: _screenSize.width / 30),
                    MyButton(
                      widthRatio: 5,
                      icon: Icons.restore,
                      contentColor: kColorRed,
                      shadow: kColorRed,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _alertDialog;
                            });
                      },
                    )
                  ],
                ),
                const Spacer(),
                MyButton(
                  onTap: () {},
                  text: ' Home ',
                  navigator: HomeScreen(),
                ),
                SizedBox(height: _screenSize.height / 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
