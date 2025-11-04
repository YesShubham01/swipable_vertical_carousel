import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BillSectionHeader extends StatefulWidget {
  final String? title;
  final String? billsCount;
  const BillSectionHeader({super.key, this.title, this.billsCount});

  @override
  State<BillSectionHeader> createState() => _BillSectionHeaderState();
}

class _BillSectionHeaderState extends State<BillSectionHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text:
              "${widget.title ?? 'UPCOMING BILLS'} (${widget.billsCount ?? 9})",
          size: 18,
          weight: FontWeight.bold,
          color: Colors.black54,
        ),
        const Spacer(),
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
