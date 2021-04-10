import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:mathniac_plus/screens/test_screen.dart';
import 'package:mathniac_plus/tasks/tasks_soundpool.dart';
import 'package:path_provider/path_provider.dart';

import './screens/home_screen.dart';
import './settings/constants.dart';
import './settings/lists.dart';
import './settings/vars.dart';
import './tasks/my_splash2.dart';
import './tasks/task_hive.dart';
import './tasks/tasks_functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // final FirebaseApp app = await Firebase.initializeApp();
  // assert(app != null);

  /// Check internet connection
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      if (kShowPrints) print('connected');
      vInternetConnection = true;
    }
  } on SocketException catch (_) {
    if (kShowPrints) print('not connected');
    vInternetConnection = false;
  }

  if (!kIsWeb) {
    final Directory document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    await Hive.openBox<String>(kHiveBoxName);
    vMagicLevel = TaskHive().level;
    vPlaySound = TaskHive().sound;
    vBackground = TaskHive().background;

    if (vMagicLevel == 15) {
      listOfScorePoints[14] = TaskHive().highScore;
      vNickname = TaskHive().nickname;
      vUploadScore = TaskHive().getUploadScore;
    }
  }
  UpdateValues().getStartTimerValue();
  UpdateGoalValues().getGoalValue();
  await SoundManager.instance.initSounds();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Hide bottom bar and top bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return kSplashScreen
        ? MaterialApp(
            color: Colors.black,
            title: kAppName,
            debugShowCheckedModeBanner: false,
            home: MySplash(
              imagePath: 'images/launch_image.png',
              home: HomeScreen(),
              // home: TestScreen(),
              // backGroundColor: Colors.black,
              // animationEffect: 'zoom-out',
              // logoSize: 300.0,
              // duration: 1600,
              // type: MySplashType.backgroundProcess,
            ),
          )
        : MaterialApp(
            color: Colors.black,
            title: kAppName,
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
            // initialRoute: kHomeScreen,
            // onGenerateRoute: ScreensRouter.onGenerateRoute,
          );
  }
}
