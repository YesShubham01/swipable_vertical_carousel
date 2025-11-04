import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:cred_assignment_by_shubham_puhal/core/constants/app_colors.dart';
import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bills_section.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_app_bar.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/carousel_swipe_control_buttons.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/toggle_api_response_button.dart';

/// The main screen displaying the swipable vertical carousel and control options.
///
///   Structure:
/// - BillsSection (carousel)
/// - Swipe control buttons
/// - Toggle API response button
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = context.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Swipable Vertical Carousel"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap((height * 0.1).clamp(40.0, 80.0)),
              SizedBox(height: height * 0.4, child: const BillsSection()),
              Gap(height * 0.02),
              const CarouselSwipeControlButtons(),
              Gap(height * 0.03),
              const ToggleApiResponseButton(),
            ],
          ),
        ),
      ),
    );
  }
}
