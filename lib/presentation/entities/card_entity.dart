import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

class CardEntity {
  final int id;
  double stackIndex;
  final SectionChildTemplatePropertiesModel cardData;

  CardEntity({required this.id, this.stackIndex = 0.0, required this.cardData});
}
