import 'package:cred_assignment_by_shubham_puhal/core/constants/api_endpoints.dart';
import 'package:cred_assignment_by_shubham_puhal/data/repository/bills_section_repository.dart';
import 'package:cred_assignment_by_shubham_puhal/data/repository/remote_bills_section_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/data/data_sources/bills_section_data_source.dart';
import 'package:http/http.dart' as http;

class BillsSectionProvider extends ChangeNotifier {
  final BillsSectionRepository _repository;
  BillsSectionProvider({BillsSectionRepository? repository})
    : _repository =
          repository ??
          RemoteBillsSectionRepositoryImpl(
            remoteDataSource: BillsSectionRemoteDataSource(http.Client()),
          );

  // variables
  bool _isLoading = false;
  String? _error;
  SectionModel? _sectionData;
  bool _showFirstResponse = false;

  // getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  SectionModel? get sectionData => _sectionData;
  bool get showFirstResponse => _showFirstResponse;
  String get currentUrl => _showFirstResponse
      ? ApiEndpoints.billsSectionTwoItems
      : ApiEndpoints.billsSectionNineItems;

  Future<void> fetchBills() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetchedData = await _repository.getBillsSection(url: currentUrl);
      _sectionData = fetchedData;
    } catch (e) {
      _error = e.toString();
      print("Errror $_error\n\n\n");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// toggle between 2-item and 9-item responses
  Future<void> toggleResponse() async {
    _showFirstResponse = !_showFirstResponse;
    await fetchBills();
  }

  SectionModel? get billsSection => _sectionData;
}
