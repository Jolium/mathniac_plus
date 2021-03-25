import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/vars.dart';

/// Changes Goal value ///
class GoalValueNotifier extends StateNotifier<int> {
  GoalValueNotifier() : super(vGoalValue);

  int setNewValue() {
    final int _sumSelected =
        vListOfSelectedValues.fold(0, (prev, cur) => prev + cur);
    return state = vGoalValue - _sumSelected;
  }

  int setStartingValue() => state = vGoalValue;
}
