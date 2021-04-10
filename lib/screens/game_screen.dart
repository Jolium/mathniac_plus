import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/backgrounds.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';
import '../tasks/layout_buttons.dart';
import '../tasks/providers.dart';
import '../tasks/tasks_functions.dart';
import '../widgets/countdown.dart';
import '../widgets/custom_header.dart';
import '../widgets/my_button.dart';
import '../widgets/start_button.dart';
import 'home_screen.dart';
import 'levels_screen.dart';

class GameScreen extends StatelessWidget {
  final Color _colorLevel = levelColor();
  final int _goalLevel = listOfScorePoints[vMagicLevel - 1];

  @override
  Widget build(BuildContext context) {
    /// Get all starting level values
    UpdateValues().getStartTimerValue();

    /// Check game ticking provider and stop it
    final bool isTicking = context.read(gameTickingProvider.state);
    if (isTicking) {
      context.read(gameTickingProvider).stopTicking();
    }

    /// Hide bottom bar and top bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    final Size _screenSize = MediaQuery.of(context).size;

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
                      SizedBox(
                        width: _screenSize.width / 5,
                        child: const CustomHeader(
                          text: ' Timer ',
                        ),
                      ),
                      CountDown(),
                    ],
                  ),
                  // CountDown(),
                  Column(
                    children: [
                      SizedBox(
                        width: _screenSize.width / 3,
                        child: CustomHeader(
                          text: _goalLevel.toString(),
                        ),
                      ),
                      Consumer(
                          builder: (context, watch, child) {
                        final int _score = watch(scoreProvider.state);
                        return MyButton(
                          onTap: () {},
                          active: false,
                          widthRatio: 3,
                          textRatio: 2,
                          text: _score.toString(),
                          colorPrimary: _colorLevel,
                        );
                      }),
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
                      Consumer(
                          builder: (context, watch, child) {
                        final int _goalValue = watch(goalProvider.state);
                        return MyButton(
                          onTap: () {},
                          active: false,
                          widthRatio: 5,
                          textRatio: 2,
                          text: _goalValue.toString(),
                          colorPrimary: _colorLevel,
                        );
                      }),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              ButtonsLayout(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer(
                      builder: (context, watch, child) {
                    final bool isTicking = watch(gameTickingProvider.state);
                    final int actualScore = context.read(scoreProvider.state);
                    return MyButton(
                      onTap: () {},
                      text: ' Home ',
                      widthRatio: isTicking ||
                              actualScore >= _goalLevel && vMagicLevel != 15 ||
                              actualScore > _goalLevel && vMagicLevel == 15
                          ? 7
                          : 3.5,
                      heightRatio: isTicking ||
                              actualScore >= _goalLevel && vMagicLevel != 15 ||
                              actualScore > _goalLevel && vMagicLevel == 15
                          ? 10
                          : 5,
                      active: isTicking ||
                              actualScore >= _goalLevel && vMagicLevel != 15 ||
                              actualScore > _goalLevel && vMagicLevel == 15
                          ? false
                          : true,
                      navigator: HomeScreen(),
                    );
                  }),
                  StartButton(),
                  Consumer(
                      builder: (context, watch, child) {
                    final bool isTicking = watch(gameTickingProvider.state);
                    final int actualScore = context.read(scoreProvider.state);
                    return MyButton(
                      onTap: () {},
                      text: ' Levels ',
                      navigator: LevelsScreen(),
                      widthRatio: isTicking ||
                              actualScore >= _goalLevel && vMagicLevel != 15 ||
                              actualScore > _goalLevel && vMagicLevel == 15
                          ? 7
                          : 3.5,
                      heightRatio: isTicking ||
                              actualScore >= _goalLevel && vMagicLevel != 15 ||
                              actualScore > _goalLevel && vMagicLevel == 15
                          ? 10
                          : 5,
                      active: isTicking ||
                              actualScore >= _goalLevel && vMagicLevel != 15 ||
                              actualScore > _goalLevel && vMagicLevel == 15
                          ? false
                          : true,
                    );
                  }),
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
