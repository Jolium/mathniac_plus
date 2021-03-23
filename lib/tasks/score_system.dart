import '../settings/vars.dart';

class ScoreSystem {
  int _newValue = 0;

  void _updateValues(int value) {
    vActualScoreValue = vActualScoreValue + value;
    vExtraTime = vExtraTime + (value / vPointsToWinSecond);

    if (vExtraTime >= 1 && vExtraTime < 2) {
      vExtraTime = vExtraTime - 1;
      vCountdownValue = vCountdownValue + 10;
    } else if (vExtraTime >= 2) {
      vExtraTime = vExtraTime - 2;
      vCountdownValue = vCountdownValue + 20;
    }
  }

  void getScoreValue() {
    final int _sumSelected = vListOfSelectedValues.fold(0, (prev, cur) => prev + cur);
    final int _lengthSelected = vListOfSelectedValues.length;

    if (_sumSelected == vGoalValue) {
      if (_lengthSelected == 2) {
        // 2 * 5 = 10
        _newValue = 10;
        _updateValues(_newValue);
      } else if (_lengthSelected == 3) {
        // 3 * 6 = 18
        _newValue = 18;
        _updateValues(_newValue);
      } else if (_lengthSelected == 4) {
        // 4 * 7 = 28notifyListeners();
        _newValue = 28;
        _updateValues(_newValue);
      } else if (_lengthSelected == 5) {
        // 5 * 8 = 40
        _newValue = 40;
        _updateValues(_newValue);
      } else if (_lengthSelected == 6) {
        // 6 * 9 = 54
        _newValue = 54;
        _updateValues(_newValue);
      } else if (_lengthSelected == 7) {
        // 7 * 10 = 70
        _newValue = 70;
        _updateValues(_newValue);
      }
    } else {
      _newValue = 0;
    }
  }
}
