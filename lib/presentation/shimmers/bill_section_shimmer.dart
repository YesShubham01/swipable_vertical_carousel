import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class BillsSectionShimmer extends StatefulWidget {
  const BillsSectionShimmer({super.key});

  @override
  State<BillsSectionShimmer> createState() => _BillsSectionShimmerState();
}

class _BillsSectionShimmerState extends State<BillsSectionShimmer> {
  // screen size
  Size get screenSize => MediaQuery.of(context).size;
  double get height => screenSize.height;
  double get width => screenSize.width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header shimmer
            _headerShimmer(),
            Gap(height * 0.03),

            // card list shimmer
            _cardListShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _headerShimmer() {
    double containerHeight = 30;
    return Row(
      children: [
        ShimmerContainer(height: containerHeight, width: width * 0.35),
        const Gap(10),
        ShimmerContainer(height: containerHeight, width: width * 0.05),
        const Spacer(),
        ShimmerContainer(height: containerHeight, width: width * 0.2),
      ],
    );
  }

  Widget _cardListShimmer() {
    double cardHeight = 95;
    double cardRadius = 5;
    return Column(
      children: [
        ShimmerContainer(
          height: cardHeight,
          width: width,
          radius: BorderRadius.circular(cardRadius),
        ),
        const Gap(3),
        ShimmerContainer(
          height: cardHeight,
          width: width,
          radius: BorderRadius.circular(cardRadius),
        ),
        ShimmerContainer(
          height: 25,
          width: width * 0.8,
          radius: BorderRadius.only(
            bottomLeft: Radius.circular(cardRadius),
            bottomRight: Radius.circular(cardRadius),
          ),
        ),
        ShimmerContainer(
          height: 12,
          width: width * 0.7,
          radius: BorderRadius.only(
            bottomLeft: Radius.circular(cardRadius),
            bottomRight: Radius.circular(cardRadius),
          ),
        ),
      ],
    );
  }
}
