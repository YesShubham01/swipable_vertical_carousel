import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_flipper_sync_provider.dart';

class BillCardFooterText extends StatefulWidget {
  final SectionChildBody cardData;

  const BillCardFooterText({super.key, required this.cardData});

  @override
  State<BillCardFooterText> createState() => _BillCardFooterTextState();
}

class _BillCardFooterTextState extends State<BillCardFooterText> {
  late bool flippingText;
  FlipperConfig? flipperData;

  @override
  void initState() {
    super.initState();

    flippingText =
        widget.cardData.footerText == null &&
        widget.cardData.flipperConfig != null;

    if (flippingText) {
      flipperData = widget.cardData.flipperConfig!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<FlipperSyncProvider>().startFlipping(
          intervalMs: flipperData!.flipDelay,
          maxItems: flipperData!.items.length,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Display static footer text if cardData.footerText is not empty.
    if (!flippingText) {
      return CustomText(
        text: widget.cardData.footerText ?? "AUTOPAY IN 3 DAYS",
        size: 10,
        color: const Color.fromARGB(255, 57, 177, 123),
        weight: FontWeight.bold,
      );
    }

    // Else, flip between texts in flipper config.
    final provider = context.watch<FlipperSyncProvider>();
    final index = provider.currentIndex % flipperData!.items.length;
    final currentText = flipperData!.items[index].text;

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
          constraints: BoxConstraints(maxWidth: context.width * 0.25),
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
