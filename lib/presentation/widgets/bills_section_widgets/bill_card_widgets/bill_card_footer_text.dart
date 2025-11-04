import 'dart:async';

import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BillCardFooterText extends StatefulWidget {
  final SectionChildBody cardData;

  const BillCardFooterText({super.key, required this.cardData});

  @override
  State<BillCardFooterText> createState() => _BillCardFooterTextState();
}

class _BillCardFooterTextState extends State<BillCardFooterText> {
  // screen size
  Size get screenSize => MediaQuery.of(context).size;
  double get height => screenSize.height;
  double get width => screenSize.width;

  late bool flippingText;
  FlipperConfig? flipperData;

  int currentIndex = 0;
  int completedFlips = 0;
  late String currentText;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    flippingText =
        widget.cardData.footerText == null &&
        widget.cardData.flipperConfig != null;

    if (flippingText) {
      flipperData = widget.cardData.flipperConfig!;
      _startFlipping();
    }
  }

  /// Display static text if cardData.footerText is not empty.
  /// Else display use FlipperConfig to display flipping text.
  @override
  Widget build(BuildContext context) {
    if (!flippingText) {
      return CustomText(
        text: widget.cardData.footerText ?? "AUTOPAY IN 3 DAYS",
        size: 10,
        color: const Color.fromARGB(255, 57, 177, 123),
        weight: FontWeight.bold,
      );
    } else {
      // Else, flip between texts in flipper config.
      if (currentIndex != -1) {
        // For non flinal states
        currentText = flipperData!.items[currentIndex].text;
      }

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeInCirc,
        switchOutCurve: Curves.easeInCirc,
        transitionBuilder: (child, animation) {
          final inAnimation = Tween<Offset>(
            begin: const Offset(0, 0.6),
            end: Offset.zero,
          ).animate(animation);

          final outAnimation = Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0, -0.10),
          ).animate(animation);

          final isNewChild = child.key == ValueKey(currentText);

          return SlideTransition(
            position: isNewChild ? inAnimation : outAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Align(
          key: ValueKey(currentText),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width * 0.25),
            child: CustomText(
              key: ValueKey(currentText),
              text: currentText,
              size: 10,
              maxLines: 2,
              color: const Color.fromARGB(255, 57, 177, 123),
              weight: FontWeight.bold,
              alignment: TextAlign.center,
            ),
          ),
        ),
      );
    }
  }

  void _startFlipping() {
    final delay = Duration(milliseconds: flipperData?.flipDelay ?? 2000);
    final maxFlips = flipperData?.flipCount ?? 0;

    _timer = Timer.periodic(delay, (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % flipperData!.items.length;
        completedFlips++;
        if (maxFlips > 0 && completedFlips >= maxFlips) {
          _timer?.cancel();
          currentIndex = -1;
          if (flipperData?.finalStage.text != null) {
            currentText = flipperData?.finalStage.text as String;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
