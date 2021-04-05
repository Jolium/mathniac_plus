import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/vars.dart';

/// Countdown value ///
class CountdownNotifier extends StateNotifier<int> {
  CountdownNotifier() : super(vStartCountdownValue);

  int decrease() => state--;

  int add(int value) => state = state + value;

  // int set(int value) => state = value;

  int reset() => state = vStartCountdownValue;
}

class CountdownCancelNotifier extends StateNotifier<bool> {
  CountdownCancelNotifier() : super(false);

  bool set({bool cancelTimer}) => state = cancelTimer;
}
