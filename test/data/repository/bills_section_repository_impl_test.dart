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
        final Map<String, dynamic> mockJsonList = {
          "entity_type": "bills",
          "external_id": "1",
          "template_name": "bills_section",
          "template_properties": {
            "body": {
              "auto_scroll_enabled": false,
              "badge": {
                "cta": {
                  "primary": {
                    "background_color": "#fff",
                    "title": "Pay",
                    "type": "action",
                  },
                },
                "icon": "icon_url",
              },
              "bills_count": "3",
              "cards_animation_config": {
                "count": 3,
                "delay": 1,
                "duration": "200ms",
              },
              "orientation": "horizontal",
              "template_type": "bills",
              "title": "Your Bills",
            },
            "child_list": [],
            "ctas": {
              "primary": {
                "background_color": "#fff",
                "title": "Pay Now",
                "type": "action",
              },
            },
          },
        };

        when(
          mockDataSource.fetchBillsSection(),
        ).thenAnswer((_) async => mockJsonList);

        final result = await repository.getBillsSection();

        expect(result, isA<SectionModel>());
        expect(result.entityType, 'bills');
        // deep level checks to ensure that json is correctly getting converted to models at all levels.
        expect(result.templateProperties.body.badge.cta.primary?.title, "Pay");
        expect(result.templateProperties.ctas.primary?.title, "Pay Now");

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
