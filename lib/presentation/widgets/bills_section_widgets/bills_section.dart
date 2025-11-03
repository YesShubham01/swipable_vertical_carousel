import 'package:cred_assignment_by_shubham_puhal/core/controllers/swipable_carousel_controller.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_section_header.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/swipable_vertical_carousel.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
    final provider = context.watch<BillsSectionProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text('Error: ${provider.error}'));
    }

    SectionModel? sectionData = provider.billsSection;
    if (sectionData == null) {
      return const Center(child: Text('No data available'));
    }

    SectionBodyModel sectionBody = sectionData.templateProperties.body;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          BillSectionHeader(title: sectionBody.title),
          Gap(height * 0.03),
          SwipableVerticalCarousel(
            widgets: List.generate(10, (_) => _card()),
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
