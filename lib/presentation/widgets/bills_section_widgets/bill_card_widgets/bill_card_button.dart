import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BillCardButton extends StatefulWidget {
  final SectionChildBody cardData;
  const BillCardButton({super.key, required this.cardData});

  @override
  State<BillCardButton> createState() => _BillCardButtonState();
}

class _BillCardButtonState extends State<BillCardButton> {
  // screen size
  Size get screenSize => MediaQuery.of(context).size;
  double get height => screenSize.height;
  double get width => screenSize.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.28,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.black, width: 1.3),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Center(
        child: CustomText(
          text: "Pay ${widget.cardData.paymentAmount}",
          color: Colors.white,
          size: 13,
          weight: FontWeight.w800,
        ),
      ),
    );
  }
}
