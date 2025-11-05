import 'dart:ui';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';
import 'package:flutter/material.dart';

/// A small overlay widget that shows real-time FPS and dropped frame info.
class FPSMonitorOverlay extends StatefulWidget {
  const FPSMonitorOverlay({super.key});

  @override
  State<FPSMonitorOverlay> createState() => _FPSMonitorOverlayState();
}

class _FPSMonitorOverlayState extends State<FPSMonitorOverlay>
    with WidgetsBindingObserver {
  List<FrameTiming> _frameTimings = [];
  double _fps = 0;
  double _droppedPercent = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addTimingsCallback(_onFrameTimings);
  }

  void _onFrameTimings(List<FrameTiming> timings) {
    _frameTimings.addAll(timings);
    if (_frameTimings.length > 30) {
      // Keep only recent 30 frames
      _frameTimings = _frameTimings.sublist(_frameTimings.length - 30);
    }

    final durations = _frameTimings.map((f) => f.totalSpan.inMicroseconds);
    if (durations.isNotEmpty) {
      final avgFrameTime = durations.reduce((a, b) => a + b) / durations.length;
      _fps = 1e6 / avgFrameTime; // Hz (frames per second)
      final dropped = _frameTimings
          .where((f) => f.totalSpan.inMilliseconds > 16)
          .length;
      _droppedPercent = (dropped / _frameTimings.length) * 100;
      setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeTimingsCallback(_onFrameTimings);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      right: 10,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _fps >= 55
                ? Colors.green.withOpacity(0.8)
                : _fps >= 40
                ? Colors.orange.withOpacity(0.8)
                : Colors.red.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'FPS: ${_fps.toStringAsFixed(1)}'),
              CustomText(text: 'Drops: ${_droppedPercent.toStringAsFixed(1)}%'),
            ],
          ),
        ),
      ),
    );
  }
}
