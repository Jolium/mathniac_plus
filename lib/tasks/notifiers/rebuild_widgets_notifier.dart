import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Change the text of the start button ///
class RebuildWidgetsNotifier extends StateNotifier<bool> {
  RebuildWidgetsNotifier() : super(false);

  bool rebuild() => state = !state;
}
