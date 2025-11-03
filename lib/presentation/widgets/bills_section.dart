import 'package:cred_assignment_by_shubham_puhal/core/controllers/swipable_carousel_controller.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/swipable_vertical_carousal.dart';
import 'package:flutter/material.dart';

class BillsSection extends StatefulWidget {
  final SwipableCarouselController? controller;
  const BillsSection({super.key, this.controller});

  @override
  State<BillsSection> createState() => BillsSectionState();
}

class BillsSectionState extends State<BillsSection> {
  final GlobalKey<SwipableVerticalCarousalState> _carouselKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SwipableVerticalCarousal(
      widgets: List.generate(10, (_) => _card()),
      controller: widget.controller,
    );
  }

  // remove this later!
  _card() {
    return Container();
  }
}
