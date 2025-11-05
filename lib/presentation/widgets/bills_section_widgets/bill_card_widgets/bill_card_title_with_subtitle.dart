import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class BillCardTitleWithSubtitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const BillCardTitleWithSubtitle({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: CustomText(text: title, size: 20, weight: FontWeight.w800),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: CustomText(
            text: subTitle,
            size: 16,
            color: const Color.fromARGB(255, 130, 130, 130),
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
