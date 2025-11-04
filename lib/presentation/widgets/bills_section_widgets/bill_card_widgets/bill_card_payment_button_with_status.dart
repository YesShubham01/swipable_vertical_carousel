import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_card_widgets/bill_card_button.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_card_widgets/bill_card_footer_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BillCardPaymentButtonWithStatus extends StatefulWidget {
  final SectionChildBody cardData;

  const BillCardPaymentButtonWithStatus({super.key, required this.cardData});

  @override
  State<BillCardPaymentButtonWithStatus> createState() =>
      _BillCardPaymentButtonWithStatusState();
}

class _BillCardPaymentButtonWithStatusState
    extends State<BillCardPaymentButtonWithStatus> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BillCardButton(cardData: widget.cardData),
        const Gap(5),
        BillCardFooterText(cardData: widget.cardData),
      ],
    );
  }
}
