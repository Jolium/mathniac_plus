import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import 'package:mathniac_plus/settings/vars.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/constants.dart';

import 'package:mathniac_plus/tasks/tasks_provider.dart';
import 'package:mathniac_plus/tasks/tasks_functions.dart';
import 'package:mathniac_plus/tasks/my_splash.dart';
import 'package:mathniac_plus/tasks/task_hive.dart';

import 'package:mathniac_plus/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  assert(app != null);

  // Admob.initialize(testDeviceIds: listOfTestDevices);
  // Admob.initialize();

  // Check internet connection
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      vInternetConnection = true;
    }
  } on SocketException catch (_) {
    print('not connected');
    vInternetConnection = false;
  }

  if (!kIsWeb) {
    Directory document = await getApplicationDocumentsDirectory();
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hide bottom bar and top bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Randoms>(create: (context) => Randoms()),
        ChangeNotifierProvider<GoalValue>(create: (context) => GoalValue()),
        ChangeNotifierProvider<RebuildWidgets>(
            create: (context) => RebuildWidgets()),
        ChangeNotifierProvider<ClearAllButtons>(
            create: (context) => ClearAllButtons()),
        ChangeNotifierProvider<GameTimer>(create: (context) => GameTimer()),
      ],
      child: kSplashScreen
          ? MaterialApp(
              color: Colors.black,
              title: kAppName,
              debugShowCheckedModeBanner: false,
              home: MySplash(
                logoSize: 300.0,
                imagePath: 'images/launch_image.png',
                backGroundColor: Colors.black,
                animationEffect: 'zoom-out',
                home: HomeScreen(),
                duration: 1600,
                type: MySplashType.StaticDuration,
              ),
            )
          : MaterialApp(
              color: Colors.black,
              title: kAppName,
              debugShowCheckedModeBanner: false,
              // initialRoute: kHomeScreen,
              // onGenerateRoute: ScreensRouter.onGenerateRoute,
              home: HomeScreen(),
            ),
    );
  }
}
