import 'package:cred_assignment_by_shubham_puhal/presentation/entities/carousel_layout_config_entity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import 'package:cred_assignment_by_shubham_puhal/core/extensions/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/shimmer_container.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/shimmer_text.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';

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
    return const Row(
      children: [
        Expanded(
          child: Row(
            children: [
              ShimmerText(
                child: CustomText(
                  text: "UPCOMING BILLS",
                  size: 18,
                  weight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              Gap(10),
              ShimmerText(
                child: CustomText(
                  text: "(9)",
                  size: 18,
                  weight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        ShimmerText(
          extraWidth: 30, // for icon
          child: CustomText(
            text: "view all",
            size: 18,
            weight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _cardListShimmer({
    CarouselLayoutConfig config = const CarouselLayoutConfig(),
  }) {
    final cardHeight = config.secondCardOffset;
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
