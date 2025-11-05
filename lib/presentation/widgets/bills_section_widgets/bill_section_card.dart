import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_card_widgets/bill_card_logo.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_card_widgets/bill_card_payment_button_with_status.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';

class BillSectionCard extends StatelessWidget {
  final bool showShadows;
  final SectionChildBody cardData;
  const BillSectionCard({
    super.key,
    this.showShadows = true,
    required this.cardData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: context.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 201, 200, 200)),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: _getShadow(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BillCardLogo(logoData: cardData.logo),
            const Gap(15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: cardData.title,
                  size: 20,
                  weight: FontWeight.w800,
                ),
                CustomText(
                  text: cardData.subTitle,
                  size: 16,
                  color: const Color.fromARGB(255, 130, 130, 130),
                  weight: FontWeight.w500,
                ),
              ],
            ),
            const Spacer(),
            BillCardPaymentButtonWithStatus(cardData: cardData),
          ],
        ),
      ),
    );
  }

  List<BoxShadow>? _getShadow() {
    return showShadows
        ? [
            BoxShadow(
              color: const Color.fromARGB(255, 55, 55, 55).withOpacity(0.25),
              offset: const Offset(0, 6),
              blurRadius: 12,
            ),
          ]
        : [];
  }
}
