import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Changes Score value ///
class ScoreNotifier extends StateNotifier<int> {
  ScoreNotifier() : super(0);

  int set(int value) => state = value;

  int add(int value) => state = state + value;
}