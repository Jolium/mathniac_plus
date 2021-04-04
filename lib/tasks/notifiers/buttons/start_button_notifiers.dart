import 'package:flutter_riverpod/flutter_riverpod.dart';

class SizedBoxNotifier extends StateNotifier<double> {
  SizedBoxNotifier() : super(1.0);

  double set(double value) => state = value;
}

class TextNotifier extends StateNotifier<String> {
  TextNotifier() : super(' Start ');

  String set(String value) => state = value;
}

class GradientNotifier extends StateNotifier<bool> {
  GradientNotifier() : super(true);

  bool set({bool value}) => state = value;
}