import 'package:flutter/material.dart';

const String kTestDevice = 'd6191d4a-9b03-4074-af7a-7c65f6662c94';

const String kAppName = 'Mathniac';

const int kTopScores = 10;
const String kHiveBoxName = 'tasks';
const bool kAnimation = true;
const bool kSplashScreen = true;

const double kMaxSize = 700;
const double kSizeRatio = 1.2;
const double kButtonsSizeRatio = 5.0;

const Color kColorGreen = Color(0xFF008000);
const Color kColorBlue = Color(0xFF0000FF);
const Color kColorViolet = Color(0xFF9400D3);
const Color kColorRed = Color(0xFFFF0000);
const Color kColorPurple = Color(0xFFFF00FF);
const Color kColorBronze = Color(0xFFCD7F32);
const Color kColorSilver = Color(0xFFC0C0C0);

const Color kColor1 = Colors.white;
const Color kColor2 = Colors.yellowAccent;
const Color kShadow1 = Colors.black;
const Color kShadow2 = Colors.yellowAccent;
const double kShadowOpacity1 = 0.8;
const double kShadowOpacity2 = 0.8;

/// Type of letter
const kLetterType1 = 'Courgette';
const kLetterType2 = 'Dancing';
const kLetterType3 = 'Niconne';

/// Screens background
const BoxDecoration kBackgroundOn = BoxDecoration(
  gradient: LinearGradient(
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
);

const BoxDecoration kBackgroundOff = BoxDecoration(
  color: Colors.black,
);

const BoxDecoration kBackground15 = BoxDecoration(
  gradient: LinearGradient(
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
);

// const String kHomeScreen = '/';
// const String kGameScreen = '/game';
// const String kLevelScreen = '/level';
// const String kSettingsScreen = '/settings';
// const String kIntroScreen = '/intro';
// const String kScoresScreen = '/scores';
// const String kUploadScreen = '/upload';
// const String kUpload2Screen = '/upload2';
