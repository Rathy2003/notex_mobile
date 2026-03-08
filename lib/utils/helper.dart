import 'package:flutter/material.dart';

class Helper {
  static Color getOnBackgroundColor(Color background) {
    return background.computeLuminance() < 0.5 ? Colors.white : Colors.black;
  }
}
