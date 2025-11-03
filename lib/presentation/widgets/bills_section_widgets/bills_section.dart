import 'package:cred_assignment_by_shubham_puhal/core/controllers/swipable_carousel_controller.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_section_header.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/swipable_vertical_carousel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BillsSection extends StatefulWidget {
  final SwipableCarouselController? controller;
  const BillsSection({super.key, this.controller});

  @override
  State<BillsSection> createState() => BillsSectionState();
}

class BillsSectionState extends State<BillsSection> {
  // screen size
  Size get screenSize => MediaQuery.of(context).size;
  double get height => screenSize.height;
  double get width => screenSize.width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          const BillSectionHeader(),
          Gap(height * 0.03),
          SwipableVerticalCarousel(
            widgets: List.generate(20, (_) => _card()),
            controller: widget.controller,
          ),
        ],
      ),
    );
  }

  // remove this later!
  _card() {
    return Container();
  }
}
