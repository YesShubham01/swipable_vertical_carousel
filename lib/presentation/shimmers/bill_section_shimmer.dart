import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer placeholder displayed while the Bills section is loading.
class BillsSectionShimmer extends StatefulWidget {
  const BillsSectionShimmer({super.key});

  @override
  State<BillsSectionShimmer> createState() => _BillsSectionShimmerState();
}

class _BillsSectionShimmerState extends State<BillsSectionShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerShimmer(),
            Gap(context.height * 0.03),
            _cardListShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _headerShimmer() {
    const containerHeight = 30.0;
    return Row(
      children: [
        ShimmerContainer(height: containerHeight, width: context.width * 0.35),
        const Gap(10),
        ShimmerContainer(height: containerHeight, width: context.width * 0.05),
        const Spacer(),
        ShimmerContainer(height: containerHeight, width: context.width * 0.2),
      ],
    );
  }

  Widget _cardListShimmer() {
    const cardHeight = 95.0;
    const cardRadius = 5.0;
    return Column(
      children: [
        ShimmerContainer(
          height: cardHeight,
          width: context.width,
          radius: BorderRadius.circular(cardRadius),
        ),
        const Gap(3),
        ShimmerContainer(
          height: cardHeight,
          width: context.width,
          radius: BorderRadius.circular(cardRadius),
        ),
        ShimmerContainer(
          height: 25,
          width: context.width * 0.8,
          radius: const BorderRadius.only(
            bottomLeft: Radius.circular(cardRadius),
            bottomRight: Radius.circular(cardRadius),
          ),
        ),
        ShimmerContainer(
          height: 12,
          width: context.width * 0.7,
          radius: const BorderRadius.only(
            bottomLeft: Radius.circular(cardRadius),
            bottomRight: Radius.circular(cardRadius),
          ),
        ),
      ],
    );
  }
}
