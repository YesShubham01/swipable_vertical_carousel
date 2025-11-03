import 'package:cred_assignment_by_shubham_puhal/data/repository/bills_section_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/data/data_sources/bills_section_data_source.dart';
import 'package:http/http.dart' as http;

class BillsSectionProvider extends ChangeNotifier {
  final _repository = BillsSectionRepositoryImpl(
    remoteDataSource: BillsSectionRemoteDataSource(http.Client()),
  );

  bool _isLoading = false;
  String? _error;
  SectionModel? _sectionData;

  bool get isLoading => _isLoading;
  String? get error => _error;
  SectionModel? get sectionData => _sectionData;

  Future<void> fetchBills() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetchedData = await _repository.getBillsSection();
      _sectionData = fetchedData;
    } catch (e) {
      _error = e.toString();
      print("‼️Errror $_error\n\n\n");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  SectionModel? get billsSection => _sectionData;
}
