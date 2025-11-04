import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class FooterTextResponseToggleButtonShimmer extends StatelessWidget {
  const FooterTextResponseToggleButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          const Gap(3),
          ShimmerContainer(height: 17, width: context.width * 0.5),
          const Gap(3),
          ShimmerContainer(height: 17, width: context.width * 0.2),
        ],
      ),
    );
  }
}
