import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BillSectionCard extends StatefulWidget {
  bool showShadows;
  BillSectionCard({super.key, this.showShadows = true});

  @override
  State<BillSectionCard> createState() => _BillSectionCardState();
}

class _BillSectionCardState extends State<BillSectionCard> {
  late double height; // height of the screen
  late double width; // width of the screen

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(context).size;
    width = dimensions.width;
    height = dimensions.height;

    return Container(
      height: 100,
      width: width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 201, 200, 200)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: widget.showShadows
            ? [
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    55,
                    55,
                    55,
                  ).withOpacity(0.25),
                  offset: const Offset(0, 6),
                  blurRadius: 12,
                ),
              ]
            : [],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.cake, size: 40),
            Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _outLineButton(),
        Gap(5),
        CustomText(
          text: "AUTOPAY IN 3 DAYS",
          size: 10,
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
          CustomText(text: "₹10,000", size: 16, weight: FontWeight.bold),
        ],
      ),
    );
  }
}
