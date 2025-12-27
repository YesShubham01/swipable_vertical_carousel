import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/bill_section_provider.dart';
import 'package:cred_assignment_by_shubham_puhal/data/repository/remote_bills_section_repository_impl.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

import 'bill_section_provider_test.mocks.dart';

@GenerateMocks([RemoteBillsSectionRepositoryImpl])
void main() {
  late BillsSectionProvider provider;
  late MockBillsSectionRepositoryImpl mockRepository;
  late SectionModel mockSectionModel;

  setUp(() {
    mockRepository = MockBillsSectionRepositoryImpl();
    provider = BillsSectionProvider(repository: mockRepository);

    mockSectionModel = const SectionModel(
      entityType: "section",
      externalId: "id_123",
      templateName: "bills_section",
      templateProperties: SectionTemplatePropertiesModel(
        body: SectionBodyModel(
          autoScrollEnabled: true,
          badge: BadgeModel(
            cta: CallToActionModel(),
            icon:
                "https://assets.dreamplug.in/octapaul/heartbeat/de0d37b0a85811edb942dd1d2dcae4c2.png",
          ),
          billsCount: "9",
          cardsAnimationConfig: CardsAnimationConfigModel(
            count: 10,
            delay: 3,
            duration: "0.7",
          ),
          orientation: "vertical",
          templateType: "your_bills_section_horizontal",
          title: "UPCOMING BILLS",
        ),
        childList: [],
        ctas: CallToActionModel(
          primary: CallToActionPrimary(title: "view all", type: "deeplink"),
        ),
      ),
    );
  });

  group('BillsSectionProvider', () {
    test(
      'fetchBills sets loading and updates sectionData on success',
      () async {
        when(
          mockRepository.getBillsSection(url: anyNamed('url')),
        ).thenAnswer((_) async => mockSectionModel);

        await provider.fetchBills();

        expect(provider.isLoading, isFalse);
        expect(provider.error, isNull);
        expect(provider.sectionData, isA<SectionModel>());
        expect(
          provider.sectionData?.templateProperties.body.title,
          "UPCOMING BILLS",
        );
        verify(mockRepository.getBillsSection(url: anyNamed('url'))).called(1);
      },
    );

    test('fetchBills sets error when repository throws', () async {
      when(
        mockRepository.getBillsSection(url: anyNamed('url')),
      ).thenThrow(Exception('Network error'));

      await provider.fetchBills();

      expect(provider.isLoading, isFalse);
      expect(provider.error, isNotNull);
      expect(provider.sectionData, isNull);
    });

    test('toggleResponse flips flag and calls fetchBills', () async {
      when(
        mockRepository.getBillsSection(url: anyNamed('url')),
      ).thenAnswer((_) async => mockSectionModel);

      final oldFlag = provider.showFirstResponse;
      await provider.toggleResponse();

      expect(provider.showFirstResponse, !oldFlag);
      verify(mockRepository.getBillsSection(url: anyNamed('url'))).called(1);
    });
  });
}
