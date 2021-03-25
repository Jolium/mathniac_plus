import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Starts the countdown ///
class GameTickingNotifier extends StateNotifier<bool> {
  GameTickingNotifier() : super(false);

  bool startTicking() => state = true;

  bool stopTicking() => state = false;
}