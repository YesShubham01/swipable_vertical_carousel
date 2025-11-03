import 'package:flutter_test/flutter_test.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';

void main() {
  test('SectionModel.fromJson maps all fields correctly', () {
    final Map<String, dynamic> mockJson = {
      "entity_type": "bills",
      "external_id": "1",
      "template_name": "bills_section",
      "template_properties": {
        "body": {
          "auto_scroll_enabled": false,
          "badge": {
            "cta": {
              "primary": {
                "background_color": "#fff",
                "title": "Pay",
                "type": "action",
              },
            },
            "icon": "icon_url",
          },
          "bills_count": "3",
          "cards_animation_config": {
            "count": 3,
            "delay": 1,
            "duration": "200ms",
          },
          "orientation": "horizontal",
          "template_type": "bills",
          "title": "Your Bills",
        },
        "child_list": [],
        "ctas": {
          "primary": {
            "background_color": "#fff",
            "title": "Pay Now",
            "type": "action",
          },
        },
      },
    };

    final model = SectionModel.fromJson(mockJson);

    // Verify top-level fields
    expect(model.entityType, 'bills');
    expect(model.externalId, '1');
    expect(model.templateName, 'bills_section');

    // Verify body fields
    final body = model.templateProperties.body;
    expect(body.title, 'Your Bills');
    expect(body.autoScrollEnabled, false);
    expect(body.orientation, 'horizontal');
    expect(body.templateType, 'bills');
    expect(body.billsCount, "3");

    // Verify badge
    expect(body.badge.icon, 'icon_url');
    expect(body.badge.cta.primary?.title, 'Pay');
    expect(body.badge.cta.primary?.backgroundColor, '#fff');
    expect(body.badge.cta.primary?.type, 'action');

    // Verify animation config
    expect(body.cardsAnimationConfig.count, 3);
    expect(body.cardsAnimationConfig.delay, 1);
    expect(body.cardsAnimationConfig.duration, '200ms');

    // Verify CTAs
    expect(model.templateProperties.ctas.primary?.title, 'Pay Now');
    expect(model.templateProperties.ctas.primary?.type, 'action');
    expect(model.templateProperties.ctas.primary?.backgroundColor, '#fff');
  });
}
