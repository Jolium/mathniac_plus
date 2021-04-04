import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/lists.dart';

class GameSizedBoxNotifier extends StateNotifier<List<double>> {
  GameSizedBoxNotifier() : super(listOfSizedBoxes);

  List<double> set({int index, double size}) {
    listOfSizedBoxes[index] = size;
    return state = listOfSizedBoxes;
  }
}

class GameTextNotifier extends StateNotifier<String> {
  GameTextNotifier() : super(' Start ');

  String set(String value) => state = value;
}

class SelectedListNotifier extends StateNotifier<List<bool>> {
  SelectedListNotifier() : super(listIsSelected);

  bool set({int index, bool isSelected}) => state[index] = isSelected;

  List<bool> clear() {
    for (int index = 0; index < listIsSelected.length; index++) {
      if (listIsSelected[index] == true) {
        listIsSelected[index] = false;
      }
    }
    return state = listIsSelected;
  }
}