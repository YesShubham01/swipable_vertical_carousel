import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/swipable_vertical_carousel/swipable_vertical_carousel_builder.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/entities/card_entity.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'swipable_vertical_carousel_builder_test.mocks.dart';

@GenerateMocks([ControllerProvider])
void main() {
  late MockControllerProvider mockControllerProvider;

  setUp(() {
    mockControllerProvider = MockControllerProvider();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: ChangeNotifierProvider<ControllerProvider>.value(
        value: mockControllerProvider,
        child: Scaffold(body: child),
      ),
    );
  }

  group('SwipableVerticalCarousalBuilder Tests', () {
    testWidgets('renders BillSectionCards for provided cards', (tester) async {
      final cards = List.generate(
        3,
        (i) => CardEntity(
          id: i,
          cardData: SectionChildTemplatePropertiesModel(
            background: const Background(
              asset: null,
              color: GradientColor(colors: ['#ffffff'], direction: 'top'),
            ),
            body: SectionChildBody(
              title: 'Card $i',
              subTitle: 'Sub $i',
              paymentAmount: '₹100$i',
              templateType: 'bill',
              logo: const Logo(
                bgColor: '#ffffff',
                shape: 'circle',
                url: 'https://example.com/logo.png',
              ),
            ),
            ctas: const CallToActionModel(),
          ),
        ),
      );

      when(mockControllerProvider.attach(any, any)).thenReturn(null);
      when(
        mockControllerProvider.modifySwipeDownFlag(
          isEnabled: anyNamed('isEnabled'),
        ),
      ).thenReturn(null);
      when(
        mockControllerProvider.modifySwipeUpFlag(
          isEnabled: anyNamed('isEnabled'),
        ),
      ).thenReturn(null);

      await tester.pumpWidget(
        makeTestableWidget(SwipableVerticalCarousalBuilder(cards: cards)),
      );

      await tester.pumpAndSettle();

      expect(find.byType(BillSectionCard), findsNWidgets(3));
    });

    testWidgets('calls controllerProvider.attach once on init', (tester) async {
      final cards = [
        CardEntity(
          id: 0,
          cardData: const SectionChildTemplatePropertiesModel(
            background: Background(
              asset: null,
              color: GradientColor(colors: ['#ffffff'], direction: 'top'),
            ),
            body: SectionChildBody(
              title: 'Card 0',
              subTitle: 'Sub 0',
              paymentAmount: '₹100',
              templateType: 'bill',
              logo: Logo(
                bgColor: '#ffffff',
                shape: 'circle',
                url: 'https://example.com/logo.png',
              ),
            ),
            ctas: CallToActionModel(),
          ),
        ),
      ];

      when(mockControllerProvider.attach(any, any)).thenReturn(null);
      when(
        mockControllerProvider.modifySwipeDownFlag(
          isEnabled: anyNamed('isEnabled'),
        ),
      ).thenReturn(null);
      when(
        mockControllerProvider.modifySwipeUpFlag(
          isEnabled: anyNamed('isEnabled'),
        ),
      ).thenReturn(null);

      await tester.pumpWidget(
        makeTestableWidget(SwipableVerticalCarousalBuilder(cards: cards)),
      );

      await tester.pump();

      verify(mockControllerProvider.attach(any, any)).called(1);
    });
  });
}
