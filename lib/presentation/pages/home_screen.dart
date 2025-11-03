import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_carousal.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/dummy_carousal.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/main_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double height; // height of the screen
  late double width; // width of the screen

  final GlobalKey<SwipableVerticalCarouselState> _carouselKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(
      context,
    ).size; // dimension of the screen which can be used to make the design responsive.
    width = dimensions.width;
    height = dimensions.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: CustomAppBar(title: "Swipable Vertical Carousal"),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // BillsSectionCarousal(),
          // CustomText(text: "Button"),
          SwipableVerticalCarousel(
            key: _carouselKey,
            widgets: [
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
              _card(),
            ],
          ),
          Gap(20),
          // SizedBox(
          //   height: 300,
          //   width: width,
          //   child: OverlappedCarousel(
          //     widgets: [_card(), _card(), _card(), _card(), _card(), _card()],
          //     onClicked: (int e) {},
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {
              _carouselKey.currentState?.swipeUp();
            },
            child: CustomText(text: "Swipe Up"),
          ),

          Gap(20),
          ElevatedButton(
            onPressed: () {
              _carouselKey.currentState?.swipeDown();
            },
            child: CustomText(text: "Swipe Down"),
          ),
        ],
      ),
    );
  }

  _card() {
    return Container(
      height: 110,
      width: width * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 201, 200, 200)),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );
  }
}
