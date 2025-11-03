import 'package:flutter/material.dart';

class SwipableCarouselController {
  VoidCallback? _onSwipeUp;
  VoidCallback? _onSwipeDown;

  void swipeUp() => _onSwipeUp?.call();
  void swipeDown() => _onSwipeDown?.call();

  // internal: used by the widget to attach its methods
  void attach(VoidCallback onSwipeUp, VoidCallback onSwipeDown) {
    _onSwipeUp = onSwipeUp;
    _onSwipeDown = onSwipeDown;
  }
}
