import 'dart:convert';
import 'package:http/http.dart' as http;

/// An abstract contract for fetching the Bills Section data.
abstract class BillsSectionDataSource {
  Future<Map<String, dynamic>> fetchBillsSection({required String url});
}

/// A remote implementation of [BillsSectionDataSource].
class BillsSectionRemoteDataSource implements BillsSectionDataSource {
  final http.Client client;

  BillsSectionRemoteDataSource(this.client);

  @override
  Future<Map<String, dynamic>> fetchBillsSection({required String url}) async {
    final response = await client.get(Uri.parse(url));
    print("url is $url");

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      print(decoded);
      return Map<String, dynamic>.from(decoded);
    } else {
      throw Exception(
        'Failed to fetch bills section > status code : ${response.statusCode}',
      );
    }
  }
}
