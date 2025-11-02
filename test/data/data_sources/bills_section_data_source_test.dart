import 'dart:convert';
import 'package:cred_assignment_by_shubham_puhal/data/data_sources/bills_section_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// generated mocks by build_runner 
import 'bills_section_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late BillsSectionRemoteDataSource dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = BillsSectionRemoteDataSource(mockClient);
  });

  test('should return list of maps when response code is 200', () async {
    final testUri = Uri.parse('https://jsonblob.com/api/jsonBlob/1425067032428339200');
    final mockJson = jsonEncode([
      {"title": "Bill 1"},
      {"title": "Bill 2"},
    ]);

    when(mockClient.get(testUri))
        .thenAnswer((_) async => http.Response(mockJson, 200));

    final result = await dataSource.fetchBillsSection();

    expect(result, isA<List<Map<String, dynamic>>>());
    expect(result.length, 2);
    expect(result.first["title"], "Bill 1");
  });

  test('should throw Exception when response code is not 200', () async {
    final testUri = Uri.parse('https://jsonblob.com/api/jsonBlob/1425067032428339200');
    when(mockClient.get(testUri))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));

    expect(() => dataSource.fetchBillsSection(), throwsException);
  });
}
