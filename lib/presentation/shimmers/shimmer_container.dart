import 'package:flutter/material.dart';

/// A container used with shimmer.
class ShimmerContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadiusGeometry? radius;
  const ShimmerContainer({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius ?? BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
