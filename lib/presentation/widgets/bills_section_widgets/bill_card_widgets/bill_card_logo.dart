import 'package:cred_assignment_by_shubham_puhal/core/utils/string_to_color_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:flutter/material.dart';

class BillCardLogo extends StatelessWidget {
  final Logo logoData;
  const BillCardLogo({super.key, required this.logoData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: logoData.bgColor.toColor(),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsetsGeometry.all(10),
        child: Image.network(
          logoData.url,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 20),
        ),
      ),
    );
  }
}
