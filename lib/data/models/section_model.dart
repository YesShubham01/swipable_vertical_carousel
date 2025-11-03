/// Represents a top-level section like bills section
class SectionModel {
  final String entityType;
  final String externalId;
  final String templateName;
  final SectionTemplatePropertiesModel templateProperties;

  const SectionModel({
    required this.entityType,
    required this.externalId,
    required this.templateName,
    required this.templateProperties,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
    entityType: json['entity_type'] ?? '',
    externalId: json['external_id'] ?? '',
    templateName: json['template_name'] ?? '',
    templateProperties: SectionTemplatePropertiesModel.fromJson(
      json['template_properties'] ?? {},
    ),
  );

  Map<String, dynamic> toJson() => {
    'entity_type': entityType,
    'external_id': externalId,
    'template_name': templateName,
    'template_properties': templateProperties.toJson(),
  };
}

class SectionTemplatePropertiesModel {
  final SectionBodyModel body;
  final List<SectionChildModel> childList;
  final CallToActionModel ctas;

  const SectionTemplatePropertiesModel({
    required this.body,
    required this.childList,
    required this.ctas,
  });

  factory SectionTemplatePropertiesModel.fromJson(Map<String, dynamic> json) =>
      SectionTemplatePropertiesModel(
        body: SectionBodyModel.fromJson(json['body'] ?? {}),
        childList: (json['child_list'] as List<dynamic>? ?? [])
            .map((e) => SectionChildModel.fromJson(e))
            .toList(),
        ctas: json['ctas'] != null
            ? CallToActionModel.fromJson(json['ctas'])
            : const CallToActionModel(),
      );

  Map<String, dynamic> toJson() => {
    'body': body.toJson(),
    'child_list': childList.map((e) => e.toJson()).toList(),
    'ctas': ctas.toJson(),
  };
}

class SectionBodyModel {
  final bool autoScrollEnabled;
  final BadgeModel badge;
  final String billsCount;
  final CardsAnimationConfigModel cardsAnimationConfig;
  final String orientation;
  final String templateType;
  final String title;

  const SectionBodyModel({
    required this.autoScrollEnabled,
    required this.badge,
    required this.billsCount,
    required this.cardsAnimationConfig,
    required this.orientation,
    required this.templateType,
    required this.title,
  });

  factory SectionBodyModel.fromJson(Map<String, dynamic> json) =>
      SectionBodyModel(
        autoScrollEnabled: json['auto_scroll_enabled'] ?? false,
        badge: json['badge'] != null
            ? BadgeModel.fromJson(json['badge'])
            : const BadgeModel(cta: CallToActionModel(), icon: ''),
        billsCount: json['bills_count']?.toString() ?? '',
        cardsAnimationConfig: CardsAnimationConfigModel.fromJson(
          json['cards_animation_config'] ?? {},
        ),
        orientation: json['orientation'] ?? '',
        templateType: json['template_type'] ?? '',
        title: json['title'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'auto_scroll_enabled': autoScrollEnabled,
    'badge': badge.toJson(),
    'bills_count': billsCount,
    'cards_animation_config': cardsAnimationConfig.toJson(),
    'orientation': orientation,
    'template_type': templateType,
    'title': title,
  };
}

class BadgeModel {
  final CallToActionModel cta;
  final String icon;

  const BadgeModel({required this.cta, required this.icon});

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
    cta: CallToActionModel.fromJson(json['cta'] ?? {}),
    icon: json['icon'] ?? '',
  );

  Map<String, dynamic> toJson() => {'cta': cta.toJson(), 'icon': icon};
}

class CardsAnimationConfigModel {
  final int count;
  final int delay;
  final String duration;

  const CardsAnimationConfigModel({
    required this.count,
    required this.delay,
    required this.duration,
  });

  factory CardsAnimationConfigModel.fromJson(Map<String, dynamic> json) =>
      CardsAnimationConfigModel(
        count: json['count'] ?? 0,
        delay: json['delay'] ?? 0,
        duration: json['duration'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'count': count,
    'delay': delay,
    'duration': duration,
  };
}

class SectionChildModel {
  final String entityType;
  final String externalId;
  final String templateName;
  final SectionChildTemplatePropertiesModel templateProperties;

  const SectionChildModel({
    required this.entityType,
    required this.externalId,
    required this.templateName,
    required this.templateProperties,
  });

  factory SectionChildModel.fromJson(Map<String, dynamic> json) =>
      SectionChildModel(
        entityType: json['entity_type'] ?? '',
        externalId: json['external_id'] ?? '',
        templateName: json['template_name'] ?? '',
        templateProperties: SectionChildTemplatePropertiesModel.fromJson(
          json['template_properties'] ?? {},
        ),
      );

  Map<String, dynamic> toJson() => {
    'entity_type': entityType,
    'external_id': externalId,
    'template_name': templateName,
    'template_properties': templateProperties.toJson(),
  };
}

class SectionChildTemplatePropertiesModel {
  final Background background;
  final SectionChildBody body;
  final CallToActionModel ctas;

  const SectionChildTemplatePropertiesModel({
    required this.background,
    required this.body,
    required this.ctas,
  });

  factory SectionChildTemplatePropertiesModel.fromJson(
    Map<String, dynamic> json,
  ) => SectionChildTemplatePropertiesModel(
    background: Background.fromJson(json['background'] ?? {}),
    body: SectionChildBody.fromJson(json['body'] ?? {}),
    ctas: CallToActionModel.fromJson(json['ctas'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'background': background.toJson(),
    'body': body.toJson(),
    'ctas': ctas.toJson(),
  };
}

class Background {
  final Asset? asset;
  final GradientColor color;

  const Background({this.asset, required this.color});

  factory Background.fromJson(Map<String, dynamic> json) => Background(
    asset: json['asset'] != null ? Asset.fromJson(json['asset']) : null,
    color: GradientColor.fromJson(json['color'] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    'asset': asset?.toJson(),
    'color': color.toJson(),
  };
}

class Asset {
  final String type;
  final String url;

  const Asset({required this.type, required this.url});

  factory Asset.fromJson(Map<String, dynamic> json) =>
      Asset(type: json['type'] ?? '', url: json['url'] ?? '');

  Map<String, dynamic> toJson() => {'type': type, 'url': url};
}

class GradientColor {
  final List<String> colors;
  final String direction;

  const GradientColor({required this.colors, required this.direction});

  factory GradientColor.fromJson(Map<String, dynamic> json) => GradientColor(
    colors: List<String>.from(json['colors'] ?? []),
    direction: json['direction'] ?? '',
  );

  Map<String, dynamic> toJson() => {'colors': colors, 'direction': direction};
}

class SectionChildBody {
  final String? footerText;
  final Logo logo;
  final String paymentAmount;
  final String subTitle;
  final String templateType;
  final String title;
  final FlipperConfig? flipperConfig;
  final String? paymentTag;

  const SectionChildBody({
    this.footerText,
    required this.logo,
    required this.paymentAmount,
    required this.subTitle,
    required this.templateType,
    required this.title,
    this.flipperConfig,
    this.paymentTag,
  });

  factory SectionChildBody.fromJson(Map<String, dynamic> json) =>
      SectionChildBody(
        footerText: json['footer_text'],
        logo: Logo.fromJson(json['logo'] ?? {}),
        paymentAmount: json['payment_amount']?.toString() ?? '',
        subTitle: json['sub_title'] ?? '',
        templateType: json['template_type'] ?? '',
        title: json['title'] ?? '',
        flipperConfig: json['flipper_config'] != null
            ? FlipperConfig.fromJson(json['flipper_config'])
            : null,
        paymentTag: json['payment_tag'],
      );

  Map<String, dynamic> toJson() => {
    'footer_text': footerText,
    'logo': logo.toJson(),
    'payment_amount': paymentAmount,
    'sub_title': subTitle,
    'template_type': templateType,
    'title': title,
    'flipper_config': flipperConfig?.toJson(),
    'payment_tag': paymentTag,
  };
}

class FlipperConfig {
  final FinalStage finalStage;
  final int flipCount;
  final int flipDelay;
  final List<FinalStage> items;

  const FlipperConfig({
    required this.finalStage,
    required this.flipCount,
    required this.flipDelay,
    required this.items,
  });

  factory FlipperConfig.fromJson(Map<String, dynamic> json) => FlipperConfig(
    finalStage: FinalStage.fromJson(json['final_stage'] ?? {}),
    flipCount: json['flip_count'] ?? 0,
    flipDelay: json['flip_delay'] ?? 0,
    items: (json['items'] as List<dynamic>? ?? [])
        .map((e) => FinalStage.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'final_stage': finalStage.toJson(),
    'flip_count': flipCount,
    'flip_delay': flipDelay,
    'items': items.map((e) => e.toJson()).toList(),
  };
}

class FinalStage {
  final String text;

  const FinalStage({required this.text});

  factory FinalStage.fromJson(Map<String, dynamic> json) =>
      FinalStage(text: json['text'] ?? '');

  Map<String, dynamic> toJson() => {'text': text};
}

class Logo {
  final String bgColor;
  final String shape;
  final String url;

  const Logo({required this.bgColor, required this.shape, required this.url});

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
    bgColor: json['bg_color'] ?? '',
    shape: json['shape'] ?? '',
    url: json['url'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'bg_color': bgColor,
    'shape': shape,
    'url': url,
  };
}

class CallToActionModel {
  final CallToActionPrimary? primary;

  const CallToActionModel({this.primary});

  factory CallToActionModel.fromJson(Map<String, dynamic> json) =>
      CallToActionModel(
        primary: json['primary'] != null
            ? CallToActionPrimary.fromJson(json['primary'])
            : null,
      );

  Map<String, dynamic> toJson() => {'primary': primary?.toJson()};
}

class CallToActionPrimary {
  final String? backgroundColor;
  final String? title;
  final String? type;

  const CallToActionPrimary({this.backgroundColor, this.title, this.type});

  factory CallToActionPrimary.fromJson(Map<String, dynamic> json) =>
      CallToActionPrimary(
        backgroundColor: json['background_color'],
        title: json['title'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
    'background_color': backgroundColor,
    'title': title,
    'type': type,
  };
}
