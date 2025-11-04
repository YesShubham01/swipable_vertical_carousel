import 'package:cred_assignment_by_shubham_puhal/data/data_sources/bills_section_data_source.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

/// Abstract contract for the repository
abstract class BillsSectionRepository {
  Future<SectionModel> getBillsSection({required String url});
}

/// Implementation of [BillsSectionRepository].
class BillsSectionRepositoryImpl implements BillsSectionRepository {
  final BillsSectionDataSource remoteDataSource;

  BillsSectionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SectionModel> getBillsSection({required String url}) async {
    try {
      final sectionJson = await remoteDataSource.fetchBillsSection(url: url);

      // Convert JSON list to list of SectionModel
      final sectionData = SectionModel.fromJson(sectionJson);

      return sectionData;
    } catch (e) {
      // Optionally handle specific exceptions like network errors
      throw Exception('Failed to load bills section: $e');
    }
  }
}
