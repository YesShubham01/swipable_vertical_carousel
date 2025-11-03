import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BillSectionHeader extends StatefulWidget {
  const BillSectionHeader({super.key});

  @override
  State<BillSectionHeader> createState() => _BillSectionHeaderState();
}

class _BillSectionHeaderState extends State<BillSectionHeader> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CustomText(
          text: "UPCOMING BILLS (9)",
          size: 18,
          weight: FontWeight.bold,
          color: Colors.black54,
        ),
        Spacer(),
        CustomText(
          text: "view all",
          size: 18,
          weight: FontWeight.bold,
          color: Colors.black54,
        ),
        Icon(Icons.navigate_next_rounded),
      ],
    );
  }
}
