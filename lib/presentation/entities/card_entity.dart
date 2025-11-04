import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

/// Represents a single card entity in the vertical carousel stack.
///
/// [id] uniquely identifies the card.
/// [stackIndex] defines its position in the visual stack.
/// [cardData] holds display-related template data from backend.
class CardEntity {
  final int id;
  final SectionChildTemplatePropertiesModel cardData;
  double stackIndex;

  CardEntity({required this.id, required this.cardData, this.stackIndex = 0.0});
}
