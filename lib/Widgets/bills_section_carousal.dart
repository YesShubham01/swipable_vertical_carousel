import 'package:cred_assignment_by_shubham_puhal/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
      child: Column(children: [_card(), _card()]),
    );
  }

  Widget _card() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 201, 200, 200)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.cake, size: 40),
            Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "ICICI Bank",
                  size: 18,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  text: "XXXXXXXXXXX",
                  size: 14,
                  color: const Color.fromARGB(255, 130, 130, 130),
                  weight: FontWeight.w500,
                ),
              ],
            ),
            Spacer(),
            _flippingButtonWithSubtitle(),
          ],
        ),
      ),
    );
  }

  Widget _flippingButtonWithSubtitle() {
    return Column(
      children: [
        _outLineButton(),
        Gap(5),
        CustomText(
          text: "AUTOPAY IN 3 DAYS",
          size: 12,
          color: const Color.fromARGB(255, 57, 177, 123),
          weight: FontWeight.bold,
        ),
      ],
    );
  }

  Widget _outLineButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.3),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.ac_unit_rounded,
            size: 20,
            color: const Color.fromARGB(255, 57, 177, 123),
          ),
          Gap(5),
          CustomText(text: "₹10,000", size: 18, weight: FontWeight.bold),
        ],
      ),
    );
  }
}
