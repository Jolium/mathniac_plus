import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:mathniac_plus/settings/constants.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';

import 'package:mathniac_plus/tasks/task_hive.dart';
import 'package:mathniac_plus/tasks/tasks_functions.dart';

import 'package:mathniac_plus/widgets/my_button.dart';
import 'package:mathniac_plus/widgets/custom_header.dart';

import 'package:mathniac_plus/screens/home_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _widthRatio = 1.1;
  double _heightRatio = 1.1;
  double _borderRatio = 10;
  double _marginRatio = 20;
  double _textRatio = 10;

  @override
  Widget build(BuildContext context) {
    var _screenSize = MediaQuery.of(context).size;
    double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    double _buttonHeight = _screenSize.width / _heightRatio * _sizeRatio;
    double _buttonWidth = _screenSize.width / _widthRatio * _sizeRatio;
    double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    double _textSize = _buttonSize / _textRatio;
    double _borderRadius = _buttonSize / _borderRatio;
    double _edgeInsets = _buttonSize / _marginRatio;

    Widget _alertDialog = AlertDialog(
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
        'Do you really want to return to level 1?',
        style: TextStyle(
          color: Colors.white,
          fontSize: _textSize / 2,
        ),
      ),
      actions: [
        FlatButton(

            /// TODO: on production delete from here ///
            onLongPress: () {
              setState(() {
                vMagicLevel = 15;
                listOfScorePoints[14] = 0;
                if (!kIsWeb) {
                  TaskHive().updateLevel(15);
                  TaskHive().updateHighScore(0);
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
                vMagicLevel = 1;
                listOfScorePoints[14] = 0;
                if (!kIsWeb) {
                  TaskHive().updateLevel(1);
                  TaskHive().updateHighScore(0);
                }
                vBackground = true;
                UpdateValues().getStartTimerValue();
                UpdateGoalValues().getGoalValue();
              });
              Navigator.of(context).pop();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(_borderRadius),
              ),
            ),
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: _textSize / 1.5,
              ),
            )),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(_borderRadius),
            ),
          ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: _screenSize.height / 30,
              ),
              CustomHeader(
                text: ' Settings ',
              ),
              SizedBox(
                height: _screenSize.height / 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomHeader(
                    text: ' Sound ',
                    widthRatio: 2,
                    heightRatio: 8,
                  ),
                  SizedBox(
                    width: _screenSize.width / 30,
                  ),
                  MyButton(
                    widthRatio: 5,
                    icon: vPlaySound ? Icons.volume_up : Icons.volume_off,
                    contentColor:
                        vPlaySound ? Colors.yellowAccent : Colors.white,
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
                        TaskHive().updateSound(vPlaySound);
                      }
                    },
                  )
                ],
              ),
              SizedBox(
                height: _screenSize.height / 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomHeader(
                    text: ' Background ',
                    widthRatio: 2,
                    heightRatio: 8,
                  ),
                  SizedBox(
                    width: _screenSize.width / 30,
                  ),
                  MyButton(
                    widthRatio: 5,
                    icon: vBackground ? Icons.check : Icons.close,
                    contentColor:
                        vBackground ? Colors.yellowAccent : Colors.white,
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
                        TaskHive().updateBackground(vBackground);
                      }
                    },
                  )
                ],
              ),
              SizedBox(
                height: _screenSize.height / 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomHeader(
                    text: ' Reset ',
                    widthRatio: 2,
                    heightRatio: 8,
                  ),
                  SizedBox(
                    width: _screenSize.width / 30,
                  ),
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
              Spacer(),
              MyButton(
                onTap: () {},
                text: ' Home ',
                navigator: HomeScreen(),
              ),
              SizedBox(
                height: _screenSize.height / 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
