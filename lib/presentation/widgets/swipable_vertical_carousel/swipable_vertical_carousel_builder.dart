import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cred_assignment_by_shubham_puhal/presentation/entities/card_entity.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_section_card.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/entities/carousel_layout_config_entity.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';

/// Purpose is to build and display all the cards in swipable vertical carousel
class SwipableVerticalCarousalBuilder extends StatefulWidget {
  final List<CardEntity> cards;
  final CarouselLayoutConfig layoutConfig;
  const SwipableVerticalCarousalBuilder({
    super.key,
    required this.cards,
    this.layoutConfig = const CarouselLayoutConfig(),
  });

  @override
  State<SwipableVerticalCarousalBuilder> createState() =>
      SwipableVerticalCarousalBuilderState();
}

class SwipableVerticalCarousalBuilderState
    extends State<SwipableVerticalCarousalBuilder> {
  late int childItemCount;
  int firstActiveIndex = 0;
  int secondActiveIndex = 1;

  bool isSwiping = false;
  bool isAnimating = false;

  CarouselLayoutConfig get config => widget.layoutConfig;

  @override
  void initState() {
    super.initState();
    childItemCount = widget.cards.length;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controllerProvider = context.read<ControllerProvider>();
      controllerProvider.attach(swipeUp, swipeDown);
      _updateControllerProvider();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < -10) {
          swipeUp();
        } else if (details.delta.dy > 10) {
          swipeDown();
        }
      },
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: _sortChildrenAndBuild(widget.cards),
        ),
      ),
    );
  }

  /// this function assign stackIndex to each card which is used to decide order of elements in stack
  List<Widget> _sortChildrenAndBuild(List<CardEntity> cards) {
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].id == firstActiveIndex || cards[i].id == secondActiveIndex) {
        cards[i].stackIndex = 1.0; // top most
      } else if (cards[i].id > secondActiveIndex) {
        cards[i].stackIndex = ((cards[i].id - secondActiveIndex) + 2)
            .toDouble();
      } else if (firstActiveIndex != 0 &&
          cards[i].id == (firstActiveIndex - 1)) {
        cards[i].stackIndex = 3.0;
      } else {
        cards[i].stackIndex = (cards.length + (firstActiveIndex - cards[i].id))
            .toDouble();
      }
    }

    cards.sort((a, b) => b.stackIndex.compareTo(a.stackIndex));

    int visibleCardCount = (firstActiveIndex == 0) ? 4 : 5;
    final visibleCards = cards
        .skip((cards.length - visibleCardCount).clamp(0, cards.length))
        .toList();

    return visibleCards.map((e) => _displayCarousal(e)).toList();
  }

  Widget _displayCarousal(CardEntity card) {
    bool showShadows = !(card.id == firstActiveIndex && !isAnimating);

    return AnimatedPositioned(
      curve: Curves.fastOutSlowIn,
      key: ValueKey(card.id),
      duration: Duration(milliseconds: config.animationDurationMs),
      top: calculateTopDistance(card.id),
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        duration: Duration(milliseconds: config.animationDurationMs),
        transform: getTransform(card.id),
        alignment: FractionalOffset.center,
        child: BillSectionCard(
          showShadows: showShadows,
          cardData: card.cardData.body,
        ),
      ),
    );
  }

  double calculateTopDistance(int index) {
    if (index == firstActiveIndex) {
      return 0;
    } else if (index == secondActiveIndex) {
      return config.secondCardOffset;
    } else if (index < firstActiveIndex) {
      return 10;
    } else {
      int distanceFromSecond = index - secondActiveIndex;
      if (distanceFromSecond == 1) {
        return (distanceFromSecond * config.belowCardOffset) +
            config.secondCardOffset;
      } else {
        return (distanceFromSecond * config.belowCardSmallerOffset) +
            config.secondCardOffset;
      }
    }
  }

  Matrix4 getTransform(int index) {
    var transform = Matrix4.identity();

    if (index < firstActiveIndex) {
      double scaleDownFactor =
          1 - ((index - secondActiveIndex) * config.scaleFactorBehind);
      scaleDownFactor = scaleDownFactor.clamp(config.minScale, 1.0);
      transform.scale(scaleDownFactor, scaleDownFactor, scaleDownFactor);
    } else {
      double scaleDownFactor =
          1 - ((index - secondActiveIndex) * config.scaleFactorAhead);
      scaleDownFactor = scaleDownFactor.clamp(config.minScale, 1.0);
      transform.scale(scaleDownFactor, scaleDownFactor, scaleDownFactor);
    }

    return transform;
  }

  void swipeUp() {
    if (isSwiping) return;
    isSwiping = true;
    isAnimating = true;

    setState(() {
      if (secondActiveIndex < widget.cards.length - 1) {
        firstActiveIndex++;
        secondActiveIndex++;
        _updateControllerProvider();
      }
    });
    _disableSwipeForDuration();
  }

  void swipeDown() {
    if (isSwiping) return;
    isSwiping = true;

    setState(() {
      if (firstActiveIndex > 0) {
        firstActiveIndex--;
        secondActiveIndex--;
        _updateControllerProvider();
      }
    });
    _disableSwipeForDuration();
  }

  /// this few second of disabling swiping prevents multiple swipes with one touch.
  void _disableSwipeForDuration() {
    Future.delayed(Duration(milliseconds: config.animationDurationMs), () {
      isSwiping = false;
      setState(() {
        isAnimating = false;
      });
    });
  }

  void _updateControllerProvider() {
    if (firstActiveIndex == 0) {
      context.read<ControllerProvider>().modifySwipeDownFlag(isEnabled: false);
    } else {
      context.read<ControllerProvider>().modifySwipeDownFlag(isEnabled: true);
    }

    if (secondActiveIndex == childItemCount - 1) {
      context.read<ControllerProvider>().modifySwipeUpFlag(isEnabled: false);
    } else {
      context.read<ControllerProvider>().modifySwipeUpFlag(isEnabled: true);
    }
  }
}
