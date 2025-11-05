import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/shimmer_text.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';

class FooterTextResponseToggleButtonShimmer extends StatelessWidget {
  const FooterTextResponseToggleButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: const Column(
        children: [
          Gap(3),
          ShimmerText(
            child: CustomText(
              text: "Displaying data from Response 1",
              size: 18,
            ),
          ),
          Gap(3),
          ShimmerText(child: CustomText(text: "(9 items)", size: 18)),
        ],
      ),
    );
  }
}
