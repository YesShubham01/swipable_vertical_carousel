import 'package:cred_assignment_by_shubham_puhal/core/constants/app_colors.dart';
import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bills_section.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_button.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_app_bar.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/carousel_swipe_control_buttons.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/toggle_api_response_button.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Swipable Vertical Carousel"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(context.height * 0.1),
          SizedBox(height: context.height * 0.4, child: const BillsSection()),
          Gap(context.height * 0.02),
          const CarouselSwipeControlButtons(),
          Gap(context.height * 0.03),
          const ToggleApiResponseButton(),
        ],
      ),
    );
  }
}
