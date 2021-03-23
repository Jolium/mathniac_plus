import 'package:flutter/material.dart';

import '../settings/constants.dart';

class CustomHeader extends StatefulWidget {
  const CustomHeader({
    @required this.text,
    this.colorPrimary = Colors.black,
    this.colorSecondary = Colors.white,
    this.shadow = Colors.black,
    this.colorText = Colors.white,
    this.shadowText = Colors.black,
    this.widthRatio = 1, // 1.2
    this.heightRatio = 10,
    this.textRatio = 2,
    // this.borderRatio = 3,
    this.marginRatio = 10,
  });

  final String text;
  final Color colorPrimary;
  final Color colorSecondary;
  final Color shadow;
  final Color colorText;
  final Color shadowText;
  final double widthRatio;
  final double heightRatio;
  final double textRatio;
  // final double borderRatio;
  final double marginRatio;

  @override
  _CustomHeaderState createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
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

    final double _edgeInsets = _buttonSize / widget.marginRatio * _sizeRatio;
    final double _shadowRadius = _buttonSize / widget.marginRatio * _sizeRatio;
    final double _textSize = _screenSize.height / 20 / widget.textRatio;

    return Container(
      // width: _screenSize.width / widget.widthRatio * _sizeRatio,
      height: _screenSize.width / widget.heightRatio * _sizeRatio,
      decoration: BoxDecoration(
        color: widget.colorSecondary,
        boxShadow: [
          BoxShadow(
            color: widget.shadow.withOpacity(kShadowOpacity1),
            spreadRadius: _shadowRadius / 2,
            blurRadius: _shadowRadius,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(_screenSize.width),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(_edgeInsets),
        decoration: BoxDecoration(
          color: widget.colorPrimary,
          boxShadow: [
            BoxShadow(
              color: widget.shadow.withOpacity(kShadowOpacity1),
              spreadRadius: _shadowRadius / 2,
              blurRadius: _shadowRadius,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(_screenSize.width),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: _textSize,
            fontWeight: FontWeight.bold,
            fontFamily: kLetterType1,
            color: widget.colorText,
          ),
        ),
      ),
    );
  }
}
