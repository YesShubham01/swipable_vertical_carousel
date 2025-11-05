import 'package:flutter/material.dart';

import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/entities/card_entity.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/swipable_vertical_carousel/swipable_vertical_carousel_builder.dart';

class SwipableVerticalCarousel extends StatefulWidget {
  final List<SectionChildTemplatePropertiesModel> cardDataList;
  const SwipableVerticalCarousel({super.key, required this.cardDataList});

  @override
  State<SwipableVerticalCarousel> createState() =>
      SwipableVerticalCarousalState();
}

class SwipableVerticalCarousalState extends State<SwipableVerticalCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: context.width,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SwipableVerticalCarousalBuilder(
            cards: List.generate(
              widget.cardDataList.length,
              (index) =>
                  CardEntity(id: index, cardData: widget.cardDataList[index]),
            ),
          );
        },
      ),
    );
  }
}
