import 'package:cred_assignment_by_shubham_puhal/core/constants/app_colors.dart';
import 'package:cred_assignment_by_shubham_puhal/core/controllers/swipable_carousel_controller.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bills_section.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // screen size
  Size get screenSize => MediaQuery.of(context).size;
  double get height => screenSize.height;
  double get width => screenSize.width;

  // controller
  final SwipableCarouselController _controller = SwipableCarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Swipable Vertical Carousel"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // your bills section
          BillsSection(controller: _controller),
          Gap(height * 0.02),

          // swipe up button
          ElevatedButton(
            onPressed: () {
              _controller.swipeUp();
            },
            child: const CustomText(text: "Swipe Up"),
          ),
          Gap(height * 0.02),

          // swipe down button
          ElevatedButton(
            onPressed: () {
              _controller.swipeDown();
            },
            child: const CustomText(text: "Swipe Down"),
          ),
        ],
      ),
    );
  }
}
