import 'dart:convert';
import 'package:cred_assignment_by_shubham_puhal/data/data_sources/bills_section_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bills_section_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late BillsSectionRemoteDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = BillsSectionRemoteDataSource(mockClient);
  });

  test('should return a Map when response code is 200', () async {
    // arrange
    const testUrl = 'https://jsonblob.com/api/jsonBlob/1425067032428339200';
    final testUri = Uri.parse(testUrl);

    final mockJson = jsonEncode({
      "entity_type": "section",
      "external_id": "section_ab18b286-ff33-4072-992d-f3727c6809ff",
      "template_name": "your_bills_section_horizontal",
      "template_properties": {
        "body": {"title": "UPCOMING BILLS"},
        "child_list": [
          {"entity_type": "card", "template_name": "your_bills_card_vertical"},
        ],
      },
    });

    when(
      mockClient.get(testUri),
    ).thenAnswer((_) async => http.Response(mockJson, 200));

    // act
    final result = await dataSource.fetchBillsSection(url: testUrl);

    // assert
    expect(result, isA<Map<String, dynamic>>());
    expect(result['entity_type'], equals('section'));
    expect(result['template_name'], equals('your_bills_section_horizontal'));
  });

  test('should throw Exception when response code is not 200', () async {
    // arrange
    const testUrl = 'https://jsonblob.com/api/jsonBlob/1425067032428339200';
    final testUri = Uri.parse(testUrl);

    when(
      mockClient.get(testUri),
    ).thenAnswer((_) async => http.Response('Error', 404));

    // act + assert
    expect(
      () => dataSource.fetchBillsSection(url: testUrl),
      throwsA(isA<Exception>()),
    );
  });
}
