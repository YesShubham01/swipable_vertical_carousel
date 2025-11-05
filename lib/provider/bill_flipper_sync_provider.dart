import 'dart:async';
import 'package:flutter/material.dart';

class FlipperSyncProvider extends ChangeNotifier {
  int currentIndex = 0;
  Timer? _timer;

  void startFlipping({int intervalMs = 2000, int maxItems = 1}) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: intervalMs), (_) {
      currentIndex = (currentIndex + 1) % maxItems;
      notifyListeners();
    });
  }

  void stopFlipping() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    stopFlipping();
    super.dispose();
  }
}
