import 'package:flutter_test/flutter_test.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

void main() {
  test('SectionModel.fromJson maps all fields correctly', () {
    final Map<String, dynamic> mockJson = {
      "entityType": "bills",
      "externalId": "1",
      "templateName": "bills_section",
      "templateProperties": {
        "body": {
          "autoScrollEnabled": false,
          "badge": {
            "cta": {
              "primary": {
                "backgroundColor": "#fff",
                "title": "Pay",
                "type": "action",
              },
            },
            "icon": "icon_url",
          },
          "billsCount": "3",
          "cardsAnimationConfig": {"count": 3, "delay": 1, "duration": "200ms"},
          "orientation": "horizontal",
          "templateType": "bills",
          "title": "Your Bills",
        },
        "childList": [],
        "ctas": {
          "primary": {
            "backgroundColor": "#fff",
            "title": "Pay Now",
            "type": "action",
          },
        },
      },
    };

    final model = SectionModel.fromJson(mockJson);

    // Verify Top-level fields
    expect(model.entityType, 'bills');
    expect(model.externalId, '1');
    expect(model.templateName, 'bills_section');

    // Verify Body properties
    final body = model.templateProperties.body;
    expect(body.title, 'Your Bills');
    expect(body.autoScrollEnabled, false);
    expect(body.orientation, 'horizontal');
    expect(body.templateType, 'bills');
    expect(body.billsCount, '3');

    // Verify Badge & CTA
    expect(body.badge.icon, 'icon_url');
    expect(body.badge.cta.primary?.title, 'Pay');
    expect(body.badge.cta.primary?.backgroundColor, '#fff');
    expect(body.badge.cta.primary?.type, 'action');

    // Verify Cards animation config
    expect(body.cardsAnimationConfig.count, 3);
    expect(body.cardsAnimationConfig.delay, 1);
    expect(body.cardsAnimationConfig.duration, '200ms');

    // Verify Section-level CTA
    expect(model.templateProperties.ctas.primary?.title, 'Pay Now');
    expect(model.templateProperties.ctas.primary?.type, 'action');
  });
}
