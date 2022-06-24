import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class IconColorSize extends StateNotifier<IconColor> {
  IconColorSize() : super(const IconColor());

  void minMaxSize(double val) {
    final newState = state.copy(sizes: val.toInt());
    state = newState;
  }

  void colorIcon(String colorName) {
    final newState = colorName == 'Red'
        ? state.copy(newColor: Colors.red)
        : colorName == 'Blue'
            ? state.copy(newColor: Colors.blue)
            : colorName == 'Green'
                ? state.copy(newColor: Colors.green)
                : colorName == 'Orange'
                    ? state.copy(newColor: Colors.orange)
                    : colorName == 'Indigo'
                        ? state.copy(newColor: Colors.indigo)
                        : colorName == 'Brown'
                            ? state.copy(newColor: Colors.brown)
                            : state.copy(newColor: Colors.black);
    state = newState;
  }

  void fromLocal(Color? colourName, int? iconS) {
    final newState = state.copy(newColor: colourName, sizes: iconS);
    state = newState;
  }
}

class IconColor {
  final int sizes;
  final Color newColor;

  const IconColor({
    this.sizes = 20,
    this.newColor = Colors.black,
  });

  IconColor copy({
    int? sizes,
    Color? newColor,
  }) =>
      IconColor(
        sizes: sizes ?? this.sizes,
        newColor: newColor ?? this.newColor,
      );
}
