import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/data/repository/bills_section_repository_impl.dart';

class GetBillsSectionUseCase {
  final BillsSectionRepository repository;

  GetBillsSectionUseCase(this.repository);

  Future<SectionModel> call() async {
    return await repository.getBillsSection();
  }
}
