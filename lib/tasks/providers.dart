import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifiers/clear_all_buttons_notifier.dart';
import 'notifiers/game_timer_notifier.dart';
import 'notifiers/goal_value_notifier.dart';
import 'notifiers/randoms_notifier.dart';
import 'notifiers/rebuild_widgets_notifier.dart';

final rebuildWidgetsProvider =
    StateNotifierProvider((ref) => RebuildWidgetsNotifier());

final goalValueNotifier = StateNotifierProvider((ref) => GoalValueNotifier());

final gameTimerNotifier = StateNotifierProvider((ref) => GameTimerNotifier());

final gameTickingNotifier =
    StateNotifierProvider((ref) => GameTickingNotifier());

final clearAllButtonsNotifier =
    StateNotifierProvider((ref) => ClearAllButtonsNotifier());

final randomsNotifier = StateNotifierProvider((ref) => RandomsNotifier());
