import 'package:cred_assignment_by_shubham_puhal/core/utils/context_size_extension.dart';
import 'package:cred_assignment_by_shubham_puhal/data/models/section_model.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/entities/card_entity.dart';
import 'package:cred_assignment_by_shubham_puhal/presentation/widgets/bills_section_widgets/bill_section_card.dart';
import 'package:cred_assignment_by_shubham_puhal/provider/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

/// Purpose is to build and display all the cards.
class SwipableVerticalCarousalBuilder extends StatefulWidget {
  final List<CardEntity> cards;
  const SwipableVerticalCarousalBuilder({super.key, required this.cards});

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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controllerProvider = context.read<ControllerProvider>();
      controllerProvider.attach(swipeUp, swipeDown);
      _updateControllerProvider();
    });

    childItemCount = widget.cards.length;
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

    // show only top 4 cards or 5 cards depending on the scroll position.
    int visibleCardCount = (firstActiveIndex == 0) ? 4 : 5;
    final visibleCards = cards
        .skip((cards.length - visibleCardCount).clamp(0, cards.length))
        .toList();

    return visibleCards.map((e) => _displayCarousal(e)).toList();
  }

  /// display card
  Widget _displayCarousal(CardEntity card) {
    bool showShadows =
        !(card.id == firstActiveIndex &&
            !isAnimating); // flag to show shadow in BillSectionCard if it's not at firstActiveIndex
    return AnimatedPositioned(
      curve: Curves.fastOutSlowIn,
      key: ValueKey(card.id),
      duration: const Duration(milliseconds: 500),
      top: calculateTopDistance(card.id),
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        duration: const Duration(milliseconds: 500),
        transform: getTransform(card.id),
        alignment: FractionalOffset.center,
        child: BillSectionCard(
          showShadows: showShadows,
          cardData: card.cardData.body,
        ),
      ),
    );
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
    print(
      "SwipeUp triggered inside SwipableVerticalCarousalBuilder: now at index $firstActiveIndex",
    );

    // this few second of disabling swiping prevents multiple swipes with one touch.
    Future.delayed(const Duration(milliseconds: 500), () {
      isSwiping = false;
      setState(() {
        isAnimating = false;
      });
    });
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
    print("SwipeDown triggered: now at index $firstActiveIndex");

    // this few second of disabling swiping prevents multiple swipes with one touch.
    Future.delayed(const Duration(milliseconds: 500), () {
      isSwiping = false;
    });
  }

  double calculateTopDistance(int index) {
    if (index == firstActiveIndex) {
      // top most card
      return 0;
    } else if (index == secondActiveIndex) {
      // second visible card
      return 100;
    } else if (index < firstActiveIndex) {
      // cards that are under first card
      return 10;
    } else {
      // cards which are after the second card
      int distanceFromSecond = index - secondActiveIndex;
      if (distanceFromSecond == 1) {
        return (distanceFromSecond * 30) + 100;
      } else {
        return (distanceFromSecond * 25) + 100;
      }
    }
  }

  Matrix4 getTransform(int index) {
    var transform = Matrix4.identity(); // default

    if (index == firstActiveIndex || index == secondActiveIndex) {
      // keep the size same
    } else if (index < firstActiveIndex) {
      // cards that are under first card
      double scaleDownFactor = 1 - ((index - secondActiveIndex) * 0.5);
      scaleDownFactor = scaleDownFactor.clamp(0.7, 1.0);
      transform.scale(scaleDownFactor, scaleDownFactor, scaleDownFactor);
    } else {
      double scaleDownFactor = 1 - ((index - secondActiveIndex) * 0.1);
      scaleDownFactor = scaleDownFactor.clamp(0.7, 1.0);
      transform.scale(scaleDownFactor, scaleDownFactor, scaleDownFactor);
    }

    return transform;
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
