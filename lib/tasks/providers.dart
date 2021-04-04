import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notifiers/buttons/game_button_notifiers.dart';
import 'notifiers/buttons/start_button_notifiers.dart';
import 'notifiers/clear_all_buttons_notifier.dart';
import 'notifiers/countdown_notifier.dart';
import 'notifiers/game_ticker_notifier.dart';
import 'notifiers/goal_value_notifier.dart';
import 'notifiers/randoms_notifier.dart';
import 'notifiers/score_notifier.dart';

final goalProvider = StateNotifierProvider((ref) => GoalNotifier());

final gameTickingProvider =
    StateNotifierProvider((ref) => GameTickingNotifier());

final clearAllButtonsProvider =
    StateNotifierProvider((ref) => ClearAllButtonsNotifier());

final randomsProvider = StateNotifierProvider((ref) => RandomsNotifier());

final countdownProvider =
    StateNotifierProvider.autoDispose((ref) => CountdownNotifier());
final countdownCancelProvider =
    StateNotifierProvider((ref) => CountdownCancelNotifier());

final scoreProvider =
    StateNotifierProvider.autoDispose((ref) => ScoreNotifier());

/// Start Button Providers
final sizedBoxProvider = StateNotifierProvider((ref) => SizedBoxNotifier());
final textProvider = StateNotifierProvider.autoDispose((ref) => TextNotifier());
final gradientProvider =
    StateNotifierProvider.autoDispose((ref) => GradientNotifier());

/// Game Button Providers
final gameSizedBoxProvider =
    StateNotifierProvider((ref) => GameSizedBoxNotifier());
final gameTextProvider =
    StateNotifierProvider.autoDispose((ref) => GameTextNotifier());
final selectedListProvider =
    StateNotifierProvider((ref) => SelectedListNotifier());
