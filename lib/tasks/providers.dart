import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifiers/clear_all_buttons_notifier.dart';
import 'notifiers/countdown_notifier.dart';
import 'notifiers/game_ticker_notifier.dart';
import 'notifiers/game_timer_notifier.dart';
import 'notifiers/goal_value_notifier.dart';
import 'notifiers/randoms_notifier.dart';
import 'notifiers/rebuild_widgets_notifier.dart';
import 'notifiers/startButton/start_button_notifiers.dart';

final rebuildWidgetsProvider =
    StateNotifierProvider((ref) => RebuildWidgetsNotifier());

final goalValueProvider = StateNotifierProvider((ref) => GoalValueNotifier());

final gameTimerProvider = StateNotifierProvider((ref) => GameTimerNotifier());

final gameTickingProvider =
    StateNotifierProvider((ref) => GameTickingNotifier());

final clearAllButtonsProvider =
    StateNotifierProvider((ref) => ClearAllButtonsNotifier());

final randomsProvider = StateNotifierProvider((ref) => RandomsNotifier());

final countdownProvider = StateNotifierProvider((ref) => CountdownNotifier());

/// Start Button Providers
final sizedBoxProvider = StateNotifierProvider((ref) => SizedBoxNotifier());
final textProvider = StateNotifierProvider((ref) => TextNotifier());
final gradientProvider = StateNotifierProvider((ref) => GradientNotifier());