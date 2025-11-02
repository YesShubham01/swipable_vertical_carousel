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
    entityType: json['entityType'],
    externalId: json['externalId'],
    templateName: json['templateName'],
    templateProperties: SectionTemplatePropertiesModel.fromJson(
      json['templateProperties'],
    ),
  );

  Map<String, dynamic> toJson() => {
    'entityType': entityType,
    'externalId': externalId,
    'templateName': templateName,
    'templateProperties': templateProperties.toJson(),
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
        body: SectionBodyModel.fromJson(json['body']),
        childList: (json['childList'] as List<dynamic>)
            .map((e) => SectionChildModel.fromJson(e))
            .toList(),
        ctas: CallToActionModel.fromJson(json['ctas']),
      );

  Map<String, dynamic> toJson() => {
    'body': body.toJson(),
    'childList': childList.map((e) => e.toJson()).toList(),
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
        autoScrollEnabled: json['autoScrollEnabled'],
        badge: BadgeModel.fromJson(json['badge']),
        billsCount: json['billsCount'],
        cardsAnimationConfig: CardsAnimationConfigModel.fromJson(
          json['cardsAnimationConfig'],
        ),
        orientation: json['orientation'],
        templateType: json['templateType'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
    'autoScrollEnabled': autoScrollEnabled,
    'badge': badge.toJson(),
    'billsCount': billsCount,
    'cardsAnimationConfig': cardsAnimationConfig.toJson(),
    'orientation': orientation,
    'templateType': templateType,
    'title': title,
  };
}

class BadgeModel {
  final CallToActionModel cta;
  final String icon;

  const BadgeModel({required this.cta, required this.icon});

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
    cta: CallToActionModel.fromJson(json['cta']),
    icon: json['icon'],
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
        count: json['count'],
        delay: json['delay'],
        duration: json['duration'],
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
        entityType: json['entityType'],
        externalId: json['externalId'],
        templateName: json['templateName'],
        templateProperties: SectionChildTemplatePropertiesModel.fromJson(
          json['templateProperties'],
        ),
      );

  Map<String, dynamic> toJson() => {
    'entityType': entityType,
    'externalId': externalId,
    'templateName': templateName,
    'templateProperties': templateProperties.toJson(),
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
    background: Background.fromJson(json['background']),
    body: SectionChildBody.fromJson(json['body']),
    ctas: CallToActionModel.fromJson(json['ctas']),
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
    color: GradientColor.fromJson(json['color']),
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
      Asset(type: json['type'], url: json['url']);

  Map<String, dynamic> toJson() => {'type': type, 'url': url};
}

class GradientColor {
  final List<String> colors;
  final String direction;

  const GradientColor({required this.colors, required this.direction});

  factory GradientColor.fromJson(Map<String, dynamic> json) => GradientColor(
    colors: List<String>.from(json['colors']),
    direction: json['direction'],
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
        footerText: json['footerText'],
        logo: Logo.fromJson(json['logo']),
        paymentAmount: json['paymentAmount'],
        subTitle: json['subTitle'],
        templateType: json['templateType'],
        title: json['title'],
        flipperConfig: json['flipperConfig'] != null
            ? FlipperConfig.fromJson(json['flipperConfig'])
            : null,
        paymentTag: json['paymentTag'],
      );

  Map<String, dynamic> toJson() => {
    'footerText': footerText,
    'logo': logo.toJson(),
    'paymentAmount': paymentAmount,
    'subTitle': subTitle,
    'templateType': templateType,
    'title': title,
    'flipperConfig': flipperConfig?.toJson(),
    'paymentTag': paymentTag,
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
    finalStage: FinalStage.fromJson(json['finalStage']),
    flipCount: json['flipCount'],
    flipDelay: json['flipDelay'],
    items: (json['items'] as List<dynamic>)
        .map((e) => FinalStage.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'finalStage': finalStage.toJson(),
    'flipCount': flipCount,
    'flipDelay': flipDelay,
    'items': items.map((e) => e.toJson()).toList(),
  };
}

class FinalStage {
  final String text;

  const FinalStage({required this.text});

  factory FinalStage.fromJson(Map<String, dynamic> json) =>
      FinalStage(text: json['text']);

  Map<String, dynamic> toJson() => {'text': text};
}

class Logo {
  final String bgColor;
  final String shape;
  final String url;

  const Logo({required this.bgColor, required this.shape, required this.url});

  factory Logo.fromJson(Map<String, dynamic> json) =>
      Logo(bgColor: json['bgColor'], shape: json['shape'], url: json['url']);

  Map<String, dynamic> toJson() => {
    'bgColor': bgColor,
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
        backgroundColor: json['backgroundColor'],
        title: json['title'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
    'backgroundColor': backgroundColor,
    'title': title,
    'type': type,
  };
}
