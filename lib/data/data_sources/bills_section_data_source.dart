import 'dart:convert';
import 'package:http/http.dart' as http;

/// An abstract contract for fetching the Bills Section data.
abstract class BillsSectionDataSource {
  Future<List<Map<String, dynamic>>> fetchBillsSection();
}

/// A remote implementation of [BillsSectionDataSource].
class BillsSectionRemoteDataSource implements BillsSectionDataSource {
  final http.Client client;

  BillsSectionRemoteDataSource(this.client);

  @override
  Future<List<Map<String, dynamic>>> fetchBillsSection() async {
    final url = Uri.parse('https://jsonblob.com/api/jsonBlob/1425067032428339200');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print(decoded);
      return List<Map<String, dynamic>>.from(decoded);
    } else {
      throw Exception('Failed to fetch bills section');
    }
  }
}

