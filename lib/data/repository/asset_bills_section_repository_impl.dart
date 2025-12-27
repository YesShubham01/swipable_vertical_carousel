import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/data/repository/bills_section_repository.dart';

class AssetBillsSectionRepositoryImpl implements BillsSectionRepository {
  @override
  Future<SectionModel> getBillsSection({required String url}) async {
    try {
      final assetPath = _mapUrlToAsset(url);

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      return SectionModel.fromJson(jsonMap);
    } catch (e) {
      throw Exception('Failed to load bills section from assets: $e');
    }
  }

  /// Maps the incoming url to an asset file.
  String _mapUrlToAsset(String url) {
    if (url.contains('019b231f-a285-787e-9787-18375a8941cb')) {
      return 'assets/two_items_response.json';
    }

    if (url.contains('019b231b-b75e-7914-ab92-6e3b572dcbcc')) {
      return 'assets/nine_items_response.json';
    }

    // sensible default
    return 'assets/nine_items_response.json';
  }
}
