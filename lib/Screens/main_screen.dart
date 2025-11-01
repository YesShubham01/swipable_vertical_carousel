import 'package:cred_assignment_by_shubham_puhal/Widgets/bills_section_carousal.dart';
import 'package:cred_assignment_by_shubham_puhal/Widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/Widgets/main_screen_appbar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late double height; // height of the screen
  late double width;  // width of the screen

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(context).size; // dimension of the screen which can be used to make the design responsive.
    width = dimensions.width;
    height = dimensions.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: CustomAppBar(title: "Swipable Vertical Carousal"),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BillsSectionCarousal(),
          CustomText(text: "Button"),
        ],
      ),
    );
  }
}
