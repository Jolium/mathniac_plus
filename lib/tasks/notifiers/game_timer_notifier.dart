import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Starts the countdown ///
class GameTimerNotifier extends StateNotifier<bool> {
  GameTimerNotifier() : super(false);

  bool startTimer() => state = true;

  bool stopTimer() => state = false;
}
