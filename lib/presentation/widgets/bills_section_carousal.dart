import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bill_section_card.dart';
import 'package:flutter/material.dart';

class BillsSectionCarousal extends StatefulWidget {
  const BillsSectionCarousal({super.key});

  @override
  State<BillsSectionCarousal> createState() => _BillsSectionCarousalState();
}

class _BillsSectionCarousalState extends State<BillsSectionCarousal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(children: [BillSectionCard(), BillSectionCard()]),
    );
  }
}
