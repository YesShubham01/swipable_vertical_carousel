import 'package:cred_assignment_by_shubham_puhal/data/data_sources/bills_section_data_source.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

/// Abstract contract for the repository
abstract class BillsSectionRepository {
  Future<List<SectionModel>> getBillsSection();
}

/// Implementation of [BillsSectionRepository].
class BillsSectionRepositoryImpl implements BillsSectionRepository {
  final BillsSectionDataSource remoteDataSource;

  BillsSectionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SectionModel>> getBillsSection() async {
    try {
      final sectionJsonList = await remoteDataSource.fetchBillsSection();

      // Convert JSON list to list of SectionModel
      final sections = sectionJsonList
          .map((json) => SectionModel.fromJson(json))
          .toList();

      return sections;
    } catch (e) {
      // Optionally handle specific exceptions like network errors
      throw Exception('Failed to load bills section: $e');
    }
  }
}
