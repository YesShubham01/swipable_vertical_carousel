import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_circular_button.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/user_input_widgets/carousel_swipe_control_buttons.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  late ControllerProvider controller;

  setUp(() {
    controller = ControllerProvider();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider.value(
        value: controller,
        child: const Scaffold(body: CarouselSwipeControlButtons()),
      ),
    );
  }

  group('CarouselSwipeControlButtons Tests', () {
    testWidgets('renders both Swipe Up and Swipe Down buttons', (tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.byType(CustomCircularButton), findsNWidgets(2));
      expect(find.text('Swipe Up'), findsOneWidget);
      expect(find.text('Swipe Down'), findsOneWidget);
    });

    testWidgets('tap on Swipe Up triggers carouselSwipeUp logic', (
      tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      expect(controller.swipeUpEnabled, true);
      expect(controller.swipeDownEnabled, false);

      await tester.tap(find.text('Swipe Up'));
      await tester.pumpAndSettle();

      expect(controller.swipeUpEnabled, true);
    });

    testWidgets('tap on Swipe Down triggers carouselSwipeDown logic', (
      tester,
    ) async {
      controller.modifySwipeDownFlag(isEnabled: true);

      await tester.pumpWidget(createTestWidget());
      await tester.pump();

      await tester.tap(find.text('Swipe Down'));
      await tester.pumpAndSettle();

      expect(controller.swipeDownEnabled, true);
    });

    testWidgets('respects isEnabled flags visually', (tester) async {
      controller.modifySwipeUpFlag(isEnabled: false);
      controller.modifySwipeDownFlag(isEnabled: false);

      await tester.pumpWidget(createTestWidget());

      final upButton = find.text('Swipe Up');
      final downButton = find.text('Swipe Down');

      expect(upButton, findsOneWidget);
      expect(downButton, findsOneWidget);

      await tester.tap(upButton);
      await tester.tap(downButton);
      await tester.pump();

      expect(controller.swipeUpEnabled, false);
      expect(controller.swipeDownEnabled, false);
    });
  });
}
