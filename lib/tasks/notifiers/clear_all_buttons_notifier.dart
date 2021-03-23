import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/lists.dart';
import 'package:mathniac_plus/settings/vars.dart';

/// Deselect ALL buttons and clear the list of selected buttons ///
class ClearAllButtonsNotifier extends StateNotifier<List<bool>> {
  ClearAllButtonsNotifier() : super(listIsSelected);

  List<bool> setIsSelectedList() {
    vListOfSelectedValues.clear();
    final List<bool> _isSelectedList = listIsSelected;

    for (int index = 0; index < listIsSelected.length; index++) {
      _isSelectedList[index] = false;
    }

    return state = _isSelectedList;
  }
}
