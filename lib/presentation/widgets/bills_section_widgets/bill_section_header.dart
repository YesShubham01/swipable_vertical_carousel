import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BillSectionHeader extends StatelessWidget {
  final String? title;
  final String? billsCount;
  const BillSectionHeader({super.key, this.title, this.billsCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            text: "${title ?? 'UPCOMING BILLS'} (${billsCount ?? 9})",
            size: 18,
            weight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const CustomText(
          text: "view all",
          size: 18,
          weight: FontWeight.bold,
          color: Colors.black54,
        ),
        const Icon(Icons.navigate_next_rounded),
      ],
    );
  }
}
