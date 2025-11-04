import 'package:cred_assignment_by_shubham_puhal/core/constants/app_colors.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bills_section.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_button.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_circular_button.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_app_bar.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    // provider
    final provider = context.watch<BillsSectionProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Swipable Vertical Carousel"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(height * 0.1),
          // your bills section
          SizedBox(height: height * 0.45, child: const BillsSection()),
          Gap(height * 0.02),

          _swipeControlButtons(),

          // swipe down button
          CustomButton(
            onPressed: () {
              provider.toggleResponse();
            },
            text: "Toggle Response",
          ),
        ],
      ),
    );
  }

  Widget _swipeControlButtons() {
    final controllerProvider = context.watch<ControllerProvider>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Swipe Up Button
          CustomCircularButton(
            icon: Icons.keyboard_arrow_up_rounded,
            label: "Swipe Up",
            onTap: () => controllerProvider.carouselSwipeUp(),
            isEnabled: controllerProvider.swipeUpEnabled,
          ),
          const Spacer(),
          // Swipe Down Button
          CustomCircularButton(
            icon: Icons.keyboard_arrow_down_rounded,
            label: "Swipe Down",
            onTap: () => controllerProvider.carouselSwipeDown(),
            isEnabled: controllerProvider.swipeDownEnabled,
          ),
        ],
      ),
    );
  }
}
