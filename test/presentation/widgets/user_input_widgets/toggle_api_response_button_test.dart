import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_button.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/customised_widgets/custom_text.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/footer_text_response_toggle_button_shimmer.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/user_input_widgets/toggle_api_response_button.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'toggle_api_response_button_test.mocks.dart';

@GenerateMocks([BillsSectionProvider])
void main() {
  late MockBillsSectionProvider mockProvider;

  setUp(() {
    mockProvider = MockBillsSectionProvider();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider<BillsSectionProvider>.value(
        value: mockProvider,
        child: const Scaffold(body: ToggleApiResponseButton()),
      ),
    );
  }

  group('ToggleApiResponseButton Widget Tests', () {
    testWidgets('shows shimmer when provider is loading', (tester) async {
      when(mockProvider.isLoading).thenReturn(true);
      when(mockProvider.showFirstResponse).thenReturn(true);

      await tester.pumpWidget(createTestWidget());

      expect(
        find.byType(FooterTextResponseToggleButtonShimmer),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('footer-response-text')),
        findsNothing,
        reason: 'Footer response text should not be visible while loading',
      );
    });

    testWidgets('shows Response 1 text when showFirstResponse = true', (
      tester,
    ) async {
      when(mockProvider.isLoading).thenReturn(false);
      when(mockProvider.showFirstResponse).thenReturn(true);

      await tester.pumpWidget(createTestWidget());

      expect(find.textContaining('Response 1'), findsOneWidget);
      expect(find.textContaining('2 items'), findsOneWidget);
    });

    testWidgets('shows Response 2 text when showFirstResponse = false', (
      tester,
    ) async {
      when(mockProvider.isLoading).thenReturn(false);
      when(mockProvider.showFirstResponse).thenReturn(false);

      await tester.pumpWidget(createTestWidget());

      expect(find.textContaining('Response 2'), findsOneWidget);
      expect(find.textContaining('9 items'), findsOneWidget);
    });

    testWidgets('tapping button triggers provider.toggleResponse()', (
      tester,
    ) async {
      when(mockProvider.isLoading).thenReturn(false);
      when(mockProvider.showFirstResponse).thenReturn(false);

      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      verify(mockProvider.toggleResponse()).called(1);
    });
  });
}
