import 'package:flutter/material.dart';

import './constants.dart';

/// Image of the day
DecorationImage _imageTheme() {
  String _date = DateTime.now().toString();
  DateTime dateTime = DateTime.parse(_date);
  String _month = dateTime.month.toString().padLeft(2, '0');
  String _day = dateTime.day.toString().padLeft(2, '0');

  print('$_month - $_day');

  if (_month == '12' && _day == '25') {
    return DecorationImage(
      image: AssetImage(
        'images/themes/christmas.png',
      ),
      fit: BoxFit.cover,
    );
  } else if (_month == '01' && _day == '01') {
    return DecorationImage(
      image: AssetImage(
        'images/themes/new_year.png',
      ),
      fit: BoxFit.cover,
    );
  } else
    return null;
}

/// Screens background
BoxDecoration kBackgroundOn = BoxDecoration(
  gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.black,
        Colors.black,
        kColorRed,
        Colors.yellow,
        kColorRed,
        Colors.black,
        Colors.black,
        kColorBlue,
        Colors.white,
        kColorBlue,
        Colors.black,
        Colors.black,
      ]),
  image: _imageTheme(),
);

BoxDecoration kBackground15 = BoxDecoration(
  gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.black,
        Colors.black,
        kColorBronze,
        Colors.yellow,
        kColorBronze,
        Colors.black,
        kColorSilver,
        Colors.black,
        kColorBronze,
        Colors.yellow,
        kColorBronze,
        Colors.black,
        Colors.black,
      ]),
  image: _imageTheme(),
);

BoxDecoration kBackgroundOff = const BoxDecoration(
  color: Colors.black,
);
