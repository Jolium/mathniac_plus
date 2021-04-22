import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/constants.dart';
import '../tasks/custom_route.dart';
import '../tasks/tasks_soundpool.dart';

class MyButton extends StatelessWidget {
  MyButton({
    this.icon,
    this.text,
    required this.onTap, // () {}
    this.navigator,
    this.contentColor = Colors.white,
    this.colorPrimary = kColorBronze,
    this.colorSecondary = Colors.black,
    this.shadow = Colors.black,
    this.iconRatio = 2,
    this.widthRatio = 2.8,
    this.heightRatio = 5,
    this.textRatio = 3,
    this.borderRatio = 3,
    this.marginRatio = 20,
    this.active = true,
    this.diagonal = true,
    this.decreaseSizeOnTap = true,
  }) : assert(
          icon != null || text != null,
          'One of the parameters must be provided ("icon" or "text")',
        );

  final IconData? icon;
  final String? text;
  final Color contentColor;
  final Function onTap;
  final Color colorPrimary;
  final Color colorSecondary;
  final Color shadow;
  final Widget? navigator;
  final double iconRatio;
  final double widthRatio;
  final double heightRatio;
  final double textRatio;
  final double borderRatio;
  final double marginRatio;
  final bool active;
  final bool diagonal;
  final bool decreaseSizeOnTap;

  final StateProvider<double> _sizedBoxProvider =
      StateProvider<double>((ref) => 1.0);

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    final double _buttonHeight = _screenSize.width / heightRatio * _sizeRatio;
    final double _buttonWidth = _screenSize.width / widthRatio * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _borderRadius = _buttonSize / borderRatio * _sizeRatio;
    final double _edgeInsets = _buttonSize / marginRatio * _sizeRatio;
    final double _shadowRadius = _buttonSize / marginRatio * _sizeRatio;
    final double _textSize = _buttonSize / textRatio;
    final double _iconSize = _buttonSize / iconRatio * _sizeRatio;

    void _onTapDown(_) {
      if (active) {
        /// Action on tap
        /// Action must to come before sound to work properly when muting
        onTap();

        /// Play audio
        SoundManager.instance.playSound(SOUND_ACTIONS.pressedButton);

        /// Check if button is supposed to decrease size
        if (decreaseSizeOnTap) {
          /// decreases the button size
          context.read(_sizedBoxProvider).state = 0.95;
        }

        /// Check if should navigate to other page
        if (navigator != null) {
          Navigator.of(context)
              .pushReplacement(CustomRoute(builder: (context) => navigator!));
        }
      }
    }

    void _onTapUp(_) {
      /// Check if button is active and is supposed to decrease size
      if (active && decreaseSizeOnTap) {
        /// Restore/Increase the button size
        context.read(_sizedBoxProvider).state = 1.0;
      }
    }

    return Center(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Container(
          margin: EdgeInsets.all(_edgeInsets),
          alignment: Alignment.center,
          width: _screenSize.width / widthRatio * _sizeRatio,
          height: _screenSize.width / heightRatio * _sizeRatio,
          child: Consumer(builder: (context, watch, child) {
            final double _sizedBox = watch(_sizedBoxProvider).state;
            return SizedBox(
              width: _screenSize.width * _sizedBox / widthRatio * _sizeRatio,
              height: _screenSize.width * _sizedBox / heightRatio * _sizeRatio,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      _borderRadius,
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: diagonal ? Alignment.topLeft : Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [
                      colorSecondary,
                      colorPrimary,
                      colorSecondary,
                    ],
                  ),
                  border: Border.all(
                    color: contentColor,
                    width: _edgeInsets,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: shadow.withOpacity(0.8),
                      spreadRadius: _shadowRadius / 2,
                      blurRadius: _shadowRadius,
                    ),
                  ],
                ),
                child: icon != null && text == null
                    ? Icon(
                        icon,
                        size: _iconSize * _sizedBox,
                        color: contentColor,
                      )
                    : Text(
                        text!,
                        style: TextStyle(
                          fontSize: _textSize * _sizedBox,
                          fontWeight: FontWeight.bold,
                          color: contentColor,
                        ),
                      ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
