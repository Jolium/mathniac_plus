import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock/wakelock.dart';

/// Starts the countdown ///
class GameTickingNotifier extends StateNotifier<bool> {
  GameTickingNotifier() : super(false);

  bool startTicking() {
    /// Wakelock keeps the device awake
    /// Prevents the screen from turning off automatically
    Wakelock.enable();

    return state = true;
  }

  bool stopTicking() {
    /// Wakelock disable the device from keeping awake
    /// Allows the screen turning off automatically
    Wakelock.disable();

    return state = false;
  }
}
