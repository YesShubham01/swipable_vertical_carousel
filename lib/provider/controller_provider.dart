import 'package:cred_assignment_by_shubham_puhal/core/controllers/swipable_carousel_controller.dart';
import 'package:flutter/material.dart';

class ControllerProvider extends ChangeNotifier {
  final SwipableCarouselController carouselController =
      SwipableCarouselController();

  // variables
  bool _swipeUpEnabled = true;
  bool _swipeDownEnabled = false;

  // getters
  bool get swipeUpEnabled => _swipeUpEnabled;
  bool get swipeDownEnabled => _swipeDownEnabled;

  void carouselSwipeUp() {
    carouselController.swipeUp();
  }

  void carouselSwipeDown() {
    carouselController.swipeDown();
  }

  void attach(VoidCallback onSwipeUp, VoidCallback onSwipeDown) {
    carouselController.attach(onSwipeUp, onSwipeDown);
  }

  void modifySwipeUpFlag({required bool isEnabled}) {
    _swipeUpEnabled = isEnabled;
    notifyListeners();
  }

  void modifySwipeDownFlag({required bool isEnabled}) {
    _swipeDownEnabled = isEnabled;
    notifyListeners();
  }
}
