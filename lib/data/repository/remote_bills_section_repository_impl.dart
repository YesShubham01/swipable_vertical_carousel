import 'package:cred_assignment_by_shubham_puhal/data/data_sources/bills_section_data_source.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/data/repository/bills_section_repository.dart';

/// Implementation of [BillsSectionRepository].
class RemoteBillsSectionRepositoryImpl implements BillsSectionRepository {
  final BillsSectionDataSource remoteDataSource;

  RemoteBillsSectionRepositoryImpl({required this.remoteDataSource});

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
