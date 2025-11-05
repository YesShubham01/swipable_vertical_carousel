import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cred_assignment_by_shubham_puhal/core/extensions/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_circular_button.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';

/// Displays two circular control buttons for swiping the vertical carousel.
///
/// - "Swipe Up" triggers [ControllerProvider.carouselSwipeUp]
/// - "Swipe Down" triggers [ControllerProvider.carouselSwipeDown]
class CarouselSwipeControlButtons extends StatefulWidget {
  const CarouselSwipeControlButtons({super.key});

  @override
  State<CarouselSwipeControlButtons> createState() =>
      _CarouselSwipeControlButtonsState();
}

class _CarouselSwipeControlButtonsState
    extends State<CarouselSwipeControlButtons> {
  @override
  Widget build(BuildContext context) {
    final controllerProvider = context.watch<ControllerProvider>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // swipe up button
          CustomCircularButton(
            icon: Icons.keyboard_arrow_up_rounded,
            label: "Swipe Up",
            onTap: () => controllerProvider.carouselSwipeUp(),
            isEnabled: controllerProvider.swipeUpEnabled,
          ),
          const Spacer(),
          // swipe down button
          CustomCircularButton(
            icon: Icons.keyboard_arrow_down_rounded,
            label: "Swipe Down",
            onTap: () => controllerProvider.carouselSwipeDown(),
            isEnabled: controllerProvider.swipeDownEnabled,
          ),
        ],
      ),
    );
  }
}
