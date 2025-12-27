import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

/// Abstract contract for the repository
abstract class BillsSectionRepository {
  Future<SectionModel> getBillsSection({required String url});
}
