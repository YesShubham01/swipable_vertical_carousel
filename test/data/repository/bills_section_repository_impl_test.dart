import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cred_assignment_by_shubham_puhal/data/repository/bills_section_repository_impl.dart';
import 'package:cred_assignment_by_shubham_puhal/data/data_sources/bills_section_data_source.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

// generated mocks by build_runner
import 'bills_section_repository_impl_test.mocks.dart';

@GenerateMocks([BillsSectionDataSource])
void main() {
  late BillsSectionRepositoryImpl repository;
  late MockBillsSectionDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockBillsSectionDataSource();
    repository = BillsSectionRepositoryImpl(remoteDataSource: mockDataSource);
  });

  group('BillsSectionRepositoryImpl', () {
    test(
      'should return a list of SectionModel when data source returns valid JSON',
      () async {
        final mockJsonList = [
          {
            "entityType": "bills",
            "externalId": "1",
            "templateName": "bills_section",
            "templateProperties": {
              "body": {
                "autoScrollEnabled": false,
                "badge": {
                  "cta": {
                    "primary": {
                      "backgroundColor": "#fff",
                      "title": "Pay",
                      "type": "action",
                    },
                  },
                  "icon": "icon_url",
                },
                "billsCount": "3",
                "cardsAnimationConfig": {
                  "count": 3,
                  "delay": 1,
                  "duration": "200ms",
                },
                "orientation": "horizontal",
                "templateType": "bills",
                "title": "Your Bills",
              },
              "childList": [],
              "ctas": {
                "primary": {
                  "backgroundColor": "#fff",
                  "title": "Pay Now",
                  "type": "action",
                },
              },
            },
          },
        ];
        
        when(
          mockDataSource.fetchBillsSection(),
        ).thenAnswer((_) async => mockJsonList);

        final result = await repository.getBillsSection();

        expect(result, isA<List<SectionModel>>());
        expect(result.first.entityType, 'bills');
        // deep level checks to ensure that json is correctly getting converted to models at all levels.
        expect(
          result[0].templateProperties.body.badge.cta.primary?.title,
          "Pay",
        );
        expect(result[0].templateProperties.ctas.primary?.title, "Pay Now");

        verify(mockDataSource.fetchBillsSection()).called(1);
      },
    );

    test('should throw exception when data source throws', () async {
      when(
        mockDataSource.fetchBillsSection(),
      ).thenThrow(Exception('Network error'));

      expect(
        () async => await repository.getBillsSection(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
