import 'package:flutter/material.dart';

// extension to access height and width of the screen from any widget.
extension ContextSizeExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
