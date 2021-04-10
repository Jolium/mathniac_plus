import 'package:hive/hive.dart';

import '../settings/constants.dart';
import '../settings/lists.dart';
import '../settings/vars.dart';

Box<String> tasksBox = Hive.box<String>(kHiveBoxName);

class TaskHive {
  void updateLevel(int value) {
    tasksBox.put('level', '$value');
    vMagicLevel = value;
  }

  int get level {
    final String? _level = tasksBox.get('level');
    if (_level == null) {
      tasksBox.put('level', '1');
      return 1;
    } else {
      return int.parse(_level);
    }
  }

  void updateSound({required bool value}) {
    tasksBox.put('sound', '$value');
    vPlaySound = value;
  }

  bool get sound {
    final String? _sound = tasksBox.get('sound');
    if (_sound == null) {
      tasksBox.put('sound', 'true');
      return true;
    } else {
      if (_sound == 'true') {
        return true;
      } else {
        return false;
      }
    }
  }

  void updateBackground({required bool value}) {
    tasksBox.put('background', '$value');
    vBackground = value;
  }

  bool get background {
    final String? _background = tasksBox.get('background');
    if (_background == null) {
      tasksBox.put('background', 'true');
      return true;
    } else {
      if (_background == 'true') {
        return true;
      } else {
        return false;
      }
    }
  }

  void updateHighScore(int value) {
    tasksBox.put('highScore', '$value');
    listOfScorePoints[14] = value;
  }

  int get highScore {
    final String? _highScore = tasksBox.get('highScore');
    if (_highScore == null) {
      tasksBox.put('highScore', '0');
      return 0;
    } else {
      return int.parse(_highScore);
    }
  }

  void saveNickname(String nickname) {
    tasksBox.put('nickname', nickname);
    vNickname = nickname;
  }

  String get nickname {
    final String? _nickname = tasksBox.get('nickname');
    if (_nickname == null) {
      tasksBox.put('nickname', '');
      return '';
    } else {
      return _nickname;
    }
  }

  void uploadScore({required bool value}) {
    /// If no internet connection it should be TRUE to upload later
    /// If internet connection it should be FALSE and it was already uploaded
    tasksBox.put('uploadScore', '$value');
    vUploadScore = value;
  }

  bool get getUploadScore {
    final String? _uploadScore = tasksBox.get('uploadScore');
    if (_uploadScore == null) {
      tasksBox.put('uploadScore', 'false');
      return false;
    } else if (_uploadScore == 'false') {
      vUploadScore = false;
      return false;
    } else {
      vUploadScore = true;
      return true;
    }
  }
}
