import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathniac_plus/settings/vars.dart';

/// Countdown value ///
class CountdownNotifier extends StateNotifier<int> {
  CountdownNotifier() : super(vStartCountdownValue);

  int start() {
    const oneMilli = Duration(milliseconds: 100);
    // int _timer = state;
    Timer.periodic(oneMilli, (Timer timer) {
      if (state <= 0) {
        timer.cancel();
        state = 0;
      } else {
        state--;
      }
    });
    return state;
  }

  // int start() => state--;

  int reset() => state = vStartCountdownValue;
}
