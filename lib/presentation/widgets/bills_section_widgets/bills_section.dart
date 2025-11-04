import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/bill_section_shimmer.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_section_header.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/swipable_vertical_carousel.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class BillsSection extends StatefulWidget {
  const BillsSection({super.key});

  @override
  State<BillsSection> createState() => BillsSectionState();
}

class BillsSectionState extends State<BillsSection> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BillsSectionProvider>();
    if (provider.isLoading) {
      return const BillsSectionShimmer();
    }
    if (provider.error != null) {
      return Center(child: Text('Error: ${provider.error}'));
    }
    SectionModel? sectionData = provider.billsSection;
    if (sectionData == null) {
      return const Center(child: Text('No data available'));
    }
    SectionBodyModel sectionBody = sectionData.templateProperties.body;
    int billsCountInt = int.tryParse(sectionBody.billsCount.toString()) ?? 1;
    List<SectionChildModel> listOfChildCards =
        sectionData.templateProperties.childList;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: Column(
        children: [
          BillSectionHeader(
            title: sectionBody.title,
            billsCount: sectionBody.billsCount,
          ),
          Gap(context.height * 0.03),
          SwipableVerticalCarousel(
            cardDataList: List.generate(
              billsCountInt,
              (int index) => listOfChildCards[index].templateProperties,
            ),
          ),
        ],
      ),
    );
  }
}
