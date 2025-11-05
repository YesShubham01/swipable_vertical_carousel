import 'package:cred_assignment_by_shubham_puhal/core/utils/get_size_of_custom_text_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/shimmer_container.dart';
import 'package:flutter/material.dart';

/// This widget takes a CustomText widget and calculate it's size without rendering it.
///
/// This approach gives performace boost. Since we are not actually rendering the Widget.
class ShimmerText extends StatelessWidget {
  final CustomText child;
  final double extraWidth;
  final double extraHeight;

  const ShimmerText({
    super.key,
    required this.child,
    this.extraWidth = 0,
    this.extraHeight = 0,
  });

  @override
  Widget build(BuildContext context) {
    final size = child.measureSize(context);

    return ShimmerContainer(
      width: size.width + extraWidth,
      height: size.height + extraHeight,
    );
  }
}
