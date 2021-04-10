import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/lists.dart';

/// Creates a new list with random integers ///
class RandomsNotifier extends StateNotifier<List<int>> {
  RandomsNotifier() : super(listOfRandoms);

  final Random _random = Random();
  final List<int> _randomsList = listOfRandoms;

  List<int> setRandomsList() {
    for (int index = 0; index < listIsSelected.length; index++) {
      final int _value = 1 + _random.nextInt(9);
      _randomsList[index] = _value;
    }
    return state = _randomsList;
  }

  List<int> setZerosRandomsList() {
    for (int index = 0; index < listIsSelected.length; index++) {
      _randomsList[index] = 0;
    }
    return state = _randomsList;
  }

  List<int> setOnlySelected() {
    for (int index = 0; index < listIsSelected.length; index++) {
      if (listIsSelected[index] == true) {
        final int _value = 1 + _random.nextInt(9);
        _randomsList[index] = _value;
      }
    }
    return state = _randomsList;
  }

  int set(int index) {
    final int _value = 1 + _random.nextInt(9);
    _randomsList[index] = _value;
    return state[index] = _value;
  }
}
