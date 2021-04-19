import 'package:flutter/material.dart';

import '../settings/vars.dart';
import '../widgets/game_button.dart';

class ButtonsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (vMagicLevel <= 3) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(children: [for (int i = 0; i <= 1; i++) GameButton(i)]),
              Row(children: [for (int i = 2; i <= 5; i++) GameButton(i)]),
              Row(children: [for (int i = 6; i <= 9; i++) GameButton(i)]),
              Row(children: [for (int i = 10; i <= 11; i++) GameButton(i)]),
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
              Row(children: [for (int i = 0; i <= 2; i++) GameButton(i)]),
              Row(children: [for (int i = 3; i <= 6; i++) GameButton(i)]),
              Row(children: [for (int i = 7; i <= 10; i++) GameButton(i)]),
              Row(children: [for (int i = 11; i <= 13; i++) GameButton(i)]),
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
              Row(children: [for (int i = 0; i <= 1; i++) GameButton(i)]),
              Row(children: [for (int i = 2; i <= 5; i++) GameButton(i)]),
              Row(children: [for (int i = 6; i <= 9; i++) GameButton(i)]),
              Row(children: [for (int i = 10; i <= 13; i++) GameButton(i)]),
              Row(children: [for (int i = 14; i <= 15; i++) GameButton(i)]),
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
              Row(children: [for (int i = 0; i <= 2; i++) GameButton(i)]),
              Row(children: [for (int i = 3; i <= 6; i++) GameButton(i)]),
              Row(children: [for (int i = 7; i <= 10; i++) GameButton(i)]),
              Row(children: [for (int i = 11; i <= 14; i++) GameButton(i)]),
              Row(children: [for (int i = 15; i <= 17; i++) GameButton(i)]),
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
              Row(children: [for (int i = 0; i <= 3; i++) GameButton(i)]),
              Row(children: [for (int i = 4; i <= 7; i++) GameButton(i)]),
              Row(children: [for (int i = 8; i <= 11; i++) GameButton(i)]),
              Row(children: [for (int i = 12; i <= 15; i++) GameButton(i)]),
              Row(children: [for (int i = 16; i <= 19; i++) GameButton(i)]),
            ],
          ),
        ],
      );
    }
  }
}
