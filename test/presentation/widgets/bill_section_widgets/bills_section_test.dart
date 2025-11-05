import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bills_section.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/shimmers/bill_section_shimmer.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'bills_section_test.mocks.dart';

@GenerateMocks([BillsSectionProvider])
void main() {
  late MockBillsSectionProvider mockProvider;

  setUp(() {
    mockProvider = MockBillsSectionProvider();
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider<BillsSectionProvider>.value(
        value: mockProvider,
        child: const Scaffold(body: BillsSection()),
      ),
    );
  }

  group('BillsSection widget Tests', () {
    testWidgets('shows shimmer when loading', (tester) async {
      when(mockProvider.isLoading).thenReturn(true);
      when(mockProvider.error).thenReturn(null);
      when(mockProvider.billsSection).thenReturn(null);

      await tester.pumpWidget(makeTestableWidget());
      await tester.pump();

      expect(find.byType(BillsSectionShimmer), findsOneWidget);
    });

    testWidgets('shows error text when provider.error is set', (tester) async {
      when(mockProvider.isLoading).thenReturn(false);
      when(mockProvider.error).thenReturn('Network error');
      when(mockProvider.billsSection).thenReturn(null);

      await tester.pumpWidget(makeTestableWidget());
      await tester.pump();

      expect(find.textContaining('Error:'), findsOneWidget);
      expect(find.textContaining('Network error'), findsOneWidget);
    });

    testWidgets('shows "No data available" when billsSection is null', (
      tester,
    ) async {
      when(mockProvider.isLoading).thenReturn(false);
      when(mockProvider.error).thenReturn(null);
      when(mockProvider.billsSection).thenReturn(null);

      await tester.pumpWidget(makeTestableWidget());
      await tester.pump();

      expect(find.text('No data available'), findsOneWidget);
    });
  });
}
