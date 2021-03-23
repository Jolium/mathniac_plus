import 'package:flutter/material.dart';

import '../settings/constants.dart';
import '../tasks/custom_route.dart';
import '../tasks/tasks_functions.dart';

class MyButton extends StatefulWidget {
  const MyButton({
    this.icon,
    this.text,
    @required this.onTap, // () {}
    this.navigator,
    this.contentColor = Colors.white,
    this.colorPrimary = kColorBronze,
    this.colorSecondary = Colors.black,
    this.shadow = Colors.black,
    this.iconRatio = 2,
    this.widthRatio = 2.8, // 2.8
    this.heightRatio = 5, // 5
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

  final IconData icon;
  final String text;
  final Color contentColor;
  final Function onTap;
  final Color colorPrimary;
  final Color colorSecondary;
  final Color shadow;
  final Widget navigator;
  final double iconRatio;
  final double widthRatio;
  final double heightRatio;
  final double textRatio;
  final double borderRatio;
  final double marginRatio;
  final bool active;
  final bool diagonal;
  final bool decreaseSizeOnTap;

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  double _sizedBox = 1;

  @override
  void initState() {
    AudioPlayer().checkPlatform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    final double _sizeRatio = _screenSize.height / _screenSize.width / 2;
    final double _buttonHeight =
        _screenSize.width / widget.heightRatio * _sizeRatio;
    final double _buttonWidth =
        _screenSize.width / widget.widthRatio * _sizeRatio;
    final double _buttonSize =
        _buttonHeight <= _buttonWidth ? _buttonHeight : _buttonWidth;

    final double _borderRadius = _buttonSize / widget.borderRatio * _sizeRatio;
    final double _edgeInsets = _buttonSize / widget.marginRatio * _sizeRatio;
    final double _shadowRadius = _buttonSize / widget.marginRatio * _sizeRatio;
    final double _textSize = _buttonSize / widget.textRatio * _sizedBox;
    final double _iconSize =
        _buttonSize / widget.iconRatio * _sizedBox * _sizeRatio;

    void _onTapDown(TapDownDetails details) {
      if (widget.active) {
        widget.onTap();
        AudioPlayer().soundPlayer('pressed_button.mp3');

        setState(() {
          if (widget.decreaseSizeOnTap) {
            // decreases the button size
            _sizedBox = 0.95;
          }

          if (widget.navigator != null) {
            Navigator.of(context).pushReplacement(
                CustomRoute(builder: (context) => widget.navigator));
          }
        });
      }
    }

    void _onTapUp(TapUpDetails details) {
      setState(() {
        if (widget.active) {
          // increases the button size
          _sizedBox = 1;
        }
      });
    }

    return Center(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Container(
          margin: EdgeInsets.all(_edgeInsets),
          alignment: Alignment.center,
          width: _screenSize.width / widget.widthRatio * _sizeRatio,
          height: _screenSize.width / widget.heightRatio * _sizeRatio,
          child: SizedBox(
            width:
                _screenSize.width * _sizedBox / widget.widthRatio * _sizeRatio,
            height:
                _screenSize.width * _sizedBox / widget.heightRatio * _sizeRatio,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    _borderRadius,
                  ),
                ),
                gradient: LinearGradient(
                  begin:
                      widget.diagonal ? Alignment.topLeft : Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.colorSecondary,
                    widget.colorPrimary,
                    widget.colorSecondary,
                  ],
                ),
                border: Border.all(
                  color: widget.contentColor,
                  width: _edgeInsets,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.shadow.withOpacity(0.8),
                    spreadRadius: _shadowRadius / 2,
                    blurRadius: _shadowRadius,
                  ),
                ],
              ),
              child: widget.icon != null && widget.text == null
                  ? Icon(
                      widget.icon,
                      size: _iconSize,
                      color: widget.contentColor,
                    )
                  : Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: _textSize,
                        fontWeight: FontWeight.bold,
                        color: widget.contentColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
